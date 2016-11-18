

#import "BHLoginRequest.h"

static BHLoginRequest* loginRequest = nil;

@implementation BHLoginRequest

+ (id)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (loginRequest == nil)
        {
            loginRequest = [[super allocWithZone:NULL] init];
        }
    });
    return loginRequest;
}

- (void)login:(NSString*)userName withPassword:(NSString*)password resultBlock:(RequestResultBlock)block
{
    [self onLogin:@{ @"username" : userName,
                     @"password" : password }
      resultBlock:block];
}
- (void)onLogin:(NSDictionary*)param resultBlock:(RequestResultBlock)block
{
    NSDictionary* postParam = nil;
    if (param && [param count] > 0)
    {
//        NSString* json = [UTILE dataToJson:param];
//        postParam = @{ @"content" : [UTILE encryption:json withKey:DES_KEY] };
    }
    
    [self request:post withUrl:@"url" andParams:postParam resultBlock:^(ResultStatus status, id result) {
        if (RS_SUCCEED == status)
        {
            
        }
        else if (RS_USER_ACCESS_TOKEN == status)
        {
            
        }
        if (block)
        {
            block(status, result);
        }
    }];
}

- (void)test
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"page",@"news",@"news",@"20",@"pageSize",@"0",@"parentid",@"1",@"type", nil];
    [self request:post withUrl:@"http://zhushou.72g.com/app/gift/gift_list/" andParams:dic resultBlock:^(ResultStatus status, id result) {
        
    }];
}

@end
