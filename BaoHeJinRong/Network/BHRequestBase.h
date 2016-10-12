

#import <Foundation/Foundation.h>
typedef enum
{
    post,
    get,
} RequestType;

typedef id (^AnalysisFun)(id data);

typedef enum {
    RS_SUCCEED = 0,                //结果正常
    RS_FAILED,                     //操作失败
    RS_ERR_UNKNOW,                 //未知错误
    RS_ERR_ANALYSIS,               //解析错误
    RS_ERR_NETWORK_NOT_CONNECTED,  //网络未连接
    RS_ERR_NETWORK,                //网络错误
    RS_ERR_SERVER,                 //服务器错误
    RS_USER_ACCESS_TOKEN           //账户令牌错误
} ResultStatus;

typedef void (^RequestResultBlock)(ResultStatus status, id result);
typedef void (^RequestDataResultBlock)(ResultStatus status, id result, int page);

@interface UploadFile : NSObject
@property(nonatomic,strong) id data;
@property(nonatomic,strong) NSString* fileName;
@property(nonatomic,strong) NSString* fileType;
@property(nonatomic,strong) NSString* fileKey;

+(instancetype) build:(id) data withName:(NSString*)fileName withFileType:(NSString*)fileType withFileKey:(NSString*)fileKey;
@end


@interface BHRequestBase : NSObject

- (NSString*)encryption:(NSDictionary*)params;
- (NSString*)decryption:(NSString*)result;



/**
 *  请求数据方法
 *
 *  @param type   请求类型，目前支持get和post两种
 *  @param url    请求接口连接
 *  @param params 请求参数
 *  @param block  结果回调方法
 */
- (void)request:(RequestType)type withUrl:(NSString*)url andParams:(NSDictionary*)params resultBlock:(RequestResultBlock)block;

/**
 *  简单的数据请求方法
 *
 *  @param url   请求接口连接，该方法为get模式
 *  @param block 结果回调方法
 */
- (void)request:(NSString*)url resultBlock:(RequestResultBlock)block;

@end
