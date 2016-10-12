

#import "BHRequestBase.h"

@interface BHLoginRequest : BHRequestBase

+ (id)shareManager;
/**
 *  使用自有账户密码进行登陆
 *
 *  @param userName    用户名
 *  @param password   密码
 *  @param block 结果回调
 */
- (void)login:(NSString*)userName withPassword:(NSString*)password resultBlock:(RequestResultBlock)block;
- (void)test;
@end
