

#import "BHRequestBase.h"
#import <AFNetworking.h>

@implementation UploadFile

+(instancetype) build:(id) data withName:(NSString*)fileName withFileType:(NSString*)fileType withFileKey:(NSString*)fileKey
{
    UploadFile* obj = [[UploadFile alloc]init];
    obj.data = data;
    obj.fileName = fileName;
    obj.fileType = fileType;
    obj.fileKey = fileKey;
    return  obj;
}
@end


@implementation BHRequestBase

- (NSString*)encryption:(NSDictionary*)params
{
    NSMutableString* strParams = [NSMutableString string];
    if (nil != params)
    {
        for (NSString* key in [params allKeys])
        {
            [strParams appendFormat:@"&%@=%@", key, [params objectForKey:key]];
        }
        [strParams deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    return strParams;
}


- (void)request:(RequestType)type withUrl:(NSString*)url andParams:(NSDictionary*)params resultBlock:(RequestResultBlock)block
{
    if (get == type)
    {
        [self dealGetRequest:url andParams:params resultBlock:(RequestResultBlock)block];
    }
    else if (post == type)
    {
        [self dealPostRequest:url andParams:params resultBlock:(RequestResultBlock)block];
    }
}

- (void)dealGetRequest:(NSString*)url andParams:(NSDictionary*)params resultBlock:(RequestResultBlock)block

{
    AFHTTPSessionManager *httpSessionManager = [AFHTTPSessionManager manager];
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];//text/html
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    requestSerializer.timeoutInterval = 10;
    requestSerializer.stringEncoding = NSUTF8StringEncoding;
    httpSessionManager.requestSerializer= requestSerializer;
    
//    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
//    responseSerializer.stringEncoding = NSUTF8StringEncoding;
//    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    httpSessionManager.securityPolicy = securityPolicy;
    [httpSessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject  =[[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        ResultStatus status = RS_ERR_NETWORK;
        id result ;
        if (responseObject)
        {
            status = RS_SUCCEED;
            result = responseObject;
        }
        else
        {
            result = @"网络错误";
        }
        
        [self onAnalysisResult:status andResult:result resultBlock:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(RS_ERR_NETWORK,@"网络错误");
        
    }];
}

- (void)dealPostRequest:(NSString*)url andParams:(NSDictionary*)params resultBlock:(RequestResultBlock)block

{
    __block NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    __block UploadFile* file = nil;
    if (nil != params)
    {
        for (NSString* key in [params allKeys])
        {
            NSObject* obj = [params objectForKey:key];
            if ([obj isKindOfClass:[NSString class]])
            {
                [parameters setObject:obj forKey:key];

            }else if ([obj isKindOfClass:[UploadFile class]])
            {
                file = (UploadFile*)obj;
            }
        }
    }
    
    AFHTTPSessionManager *httpSessionManager = [AFHTTPSessionManager manager];
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];//text/html
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    requestSerializer.timeoutInterval = 10;
    requestSerializer.stringEncoding = NSUTF8StringEncoding;
    httpSessionManager.requestSerializer= requestSerializer;
    //这里不使用AF的解析，可能接口会密文传输
//    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
//    responseSerializer.stringEncoding = NSUTF8StringEncoding;
//    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    httpSessionManager.securityPolicy = securityPolicy;
    
    [httpSessionManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (file)
        {
            [formData appendPartWithFileData:file.data name:file.fileKey fileName:file.fileName mimeType:file.fileType];
        }
    }progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        responseObject  =[[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        ResultStatus status = RS_ERR_NETWORK;
        id result ;
        if (responseObject)
        {
            status = RS_SUCCEED;
            result = responseObject;
        }
        else
        {
            result = @"网络错误";
        }
        
        [self onAnalysisResult:status andResult:result resultBlock:block];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(RS_ERR_NETWORK,@"网络错误");
    }];

    
}

- (NSString*)decryption:(NSString*)result
{
    return [UTILE decryption:result withKey:DES_KEY];
}

- (void)onAnalysisResult:(ResultStatus)status andResult:(NSString*)result resultBlock:(RequestResultBlock)block
{
    [self onAnalysisResult:status andResult:result withAnalysisFun:nil resultBlock:block];
}

- (void)onAnalysisResult:(ResultStatus)status andResult:(NSString*)result withAnalysisFun:(AnalysisFun) fun resultBlock:(RequestResultBlock)block;
{
    if (nil != block)
    {
        if (RS_SUCCEED == status)
        {
            //解密
//            result = [self decryption:result];
            NSDictionary* resultDict = [UTILE jsonToData:result];
            int statusCode = RS_FAILED;
            if (resultDict)
            {
                if (![[resultDict objectForKey:@"ret"] isKindOfClass:[NSNull class]])
                {
                    statusCode = [((NSNumber*)[resultDict objectForKey:@"ret"]) intValue];
                }
                
            }
            if (statusCode != RS_FAILED)
            {
                if (nil != fun)
                {
                    block(statusCode, fun([resultDict objectForKey:@"data"]));
                }else
                {
                    block(statusCode, resultDict);
                }
            }
            else
            {
                block(statusCode, [resultDict objectForKey:@"msg"]);
            }
        }else
        {
            block(status,result);
        }
    }
}

- (void)request:(NSString*)url resultBlock:(RequestResultBlock)block
{
    [self request:get withUrl:url andParams:nil resultBlock:block];
}

@end
