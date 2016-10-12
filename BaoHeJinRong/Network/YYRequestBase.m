

#import "YYRequestBase.h"

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

@implementation YYRequestBase

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

- (NSString*)decryption:(NSString*)result
{
    return result;
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
                    block(statusCode, [resultDict objectForKey:@"data"]);
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

- (ASIHTTPRequest*)dealGetRequest:(NSString*)url andParams:(NSDictionary*)params
{
    NSMutableString* strUrl = [NSMutableString stringWithString:url];
    if (nil != params && [params count] > 0)
    {
        if ([strUrl rangeOfString:@"?"].location == NSNotFound)
        {
            [strUrl appendString:@"?"];
        }else if ([strUrl characterAtIndex:strUrl.length-1] == '&')
        {
            [strUrl deleteCharactersInRange:NSMakeRange(strUrl.length - 1, 1)];
        }

        for (NSString* key in [params allKeys])
        {
            [strUrl appendFormat:@"&%@=%@", key, [params objectForKey:key]];
        }
    }
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
    [request buildRequestHeaders];
    return request;
}

- (ASIFormDataRequest*)dealPostRequest:(NSString*)url andParams:(NSDictionary*)params
{
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setRequestMethod:@"POST"];

    if (nil != params)
    {
        for (NSString* key in [params allKeys])
        {
            NSObject* obj = [params objectForKey:key];
            if ([obj isKindOfClass:[NSString class]])
            {
                [request setPostValue:[params objectForKey:key] forKey:key];
            }else if ([obj isKindOfClass:[UploadFile class]])
            {
                UploadFile* file = (UploadFile*)obj;
                [request addData:file.data withFileName:file.fileName andContentType:file.fileType forKey:file.fileKey];
            }
        }
    }
    [request buildRequestHeaders];

    return request;
}

- (void)request:(RequestType)type withUrl:(NSString*)url andParams:(NSDictionary*)params resultBlock:(RequestResultBlock)block
{
    ASIHTTPRequest* request = nil;
    if (get == type)
    {
        request = [self dealGetRequest:url andParams:params];
    }
    else if (post == type)
    {
        request = [self dealPostRequest:url andParams:params];
    }

    __block ASIHTTPRequest* requestCopy = request;
    [request setCompletionBlock:^{
        ResultStatus status = RS_ERR_NETWORK;
        id result ;
        if (200 == requestCopy.responseStatusCode)
        {
            status = RS_SUCCEED;
            NSData* dataResult = [requestCopy responseData];
            if (dataResult && dataResult.length > 0)
            {
                result = [[NSString alloc] initWithData:dataResult encoding:NSUTF8StringEncoding];
            }else
            {
                result = @"读取网络数据失败";
                status = RS_ERR_UNKNOW;
            }
        }else
        {
            result = @"网络错误";
        }
        [self onAnalysisResult:status andResult:result resultBlock:block];
    }];
    [request setFailedBlock:^{
        [self onAnalysisResult:RS_ERR_NETWORK andResult:@"网络错误" resultBlock:block];
    }];
    [request startAsynchronous];
}

- (void)request:(NSString*)url resultBlock:(RequestResultBlock)block
{
    [self request:get withUrl:url andParams:nil resultBlock:block];
}

@end
