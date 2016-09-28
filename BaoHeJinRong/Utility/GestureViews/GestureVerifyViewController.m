
#import "GestureVerifyViewController.h"
#import "PCCircleViewConst.h"
#import "PCCircleView.h"
#import "PCLockLabel.h"
#import "GestureViewController.h"
#import "HXSafeCenterViewController.h"
#import "HXSettingWebViewController.h"
@interface GestureVerifyViewController ()<CircleViewDelegate>

/**
 *  文字提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;

@end

@implementation GestureVerifyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //    [self.navigationController.navigationBar setBarTintColor:CircleViewBackgroundColor];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:CircleViewBackgroundColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    self.title = @"验证手势解锁";
    
    //    [self.navigationController.navigationBar setBarTintColor:CircleViewBackgroundColor];
    
    [self setNavigationView];
    
    // 头像
    UIImageView  *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 65, 65);
    imageView.center = CGPointMake(kScreenW/2, kScreenH/5-20);
    [imageView setImage:[UIImage imageNamed:@"gesture_man"]];
    [self.view addSubview:imageView];
    
    
    UILabel  *telLabel = [[UILabel alloc]init];
    telLabel.frame = CGRectMake((kScreenW-200)/2, imageView.frame.origin.y+imageView.frame.size.height+5, 200, 20);
    telLabel.text = [self setTelephoneNum:[[AppDelegate App].userDic heHuoRenObjectForKey:@"userMobile"]];
    telLabel.textColor = [UIColor whiteColor];
    telLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:telLabel];
    
    
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    [lockView setType:CircleViewTypeVerify];
    [self.view addSubview:lockView];
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 30);
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.numberOfLines = 2;
    msgLabel.frame = CGRectMake(0, telLabel.frame.origin.y+telLabel.frame.size.height+5, kScreenW, 30);
    
    [msgLabel showNormalMsg:gestureTextOldGesture];
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}
- (void)setNavigationView{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    bg.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:bg];
    
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    t.font = [UIFont boldSystemFontOfSize:18];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    //    t.text = @"验证手势解锁";
    [bg addSubview:t];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *setImg = [UIImage imageNamed:@"backItem"];
    backBtn.frame = CGRectMake(10, 10, 21, 30);
    [backBtn setBackgroundImage:setImg forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:backBtn];
}
- (void)setBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    if (type == CircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功");
            [[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:@"maxGestureError"]; //手势密码最大出错次数;
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (self.isToSetNewGesture) {
                GestureViewController *gestureVc = [[GestureViewController alloc] init];
                [gestureVc setType:GestureViewControllerTypeSetting];
                [self.navigationController pushViewController:gestureVc animated:YES];
            } else {
                for (NSInteger num=0; num<self.navigationController.viewControllers.count; num++) {
                    UIViewController *temp=self.navigationController.viewControllers[num];
                    if ([temp isKindOfClass:[HXSafeCenterViewController class]]) {
                        [self.navigationController popToViewController:temp animated:YES];
                        break;
                    }
                    if (num==self.navigationController.viewControllers.count-1) {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }
            }
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"closeClientTime"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"openClientTime"];
            [AppDelegate App].isHaveGesture = NO;
            if ([AppDelegate App].userDic != nil){
                if ([[PCCircleViewConst getGestureWithKey:[[AppDelegate App].userDic heHuoRenObjectForKey:@"userMobile"]] length]) {
                    [PCCircleViewConst removeGestureWithKey:[[AppDelegate App].userDic heHuoRenObjectForKey:@"userMobile"]];
                }
            }
            if(self.delegate && [self.delegate respondsToSelector:@selector(gestureVerifySuccess)]){
                [self.delegate gestureVerifySuccess];
            }
        } else {
            NSLog(@"密码错误！");
            int errorCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"maxGestureError"]intValue];
            errorCount--;
            CLog(@"剩余密码错误%d次",errorCount);
            if(errorCount <= 0){
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"maxGestureError"]; //手势密码最大出错次数;
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.msgLabel showWarnMsgAndShake:STR_GESSTURE_ERROR];
                //清空本地用户信息，跳转到登陆页面
                if ([AppDelegate App].isLogin == YES) {
                    [AppDelegate App].isLogin = NO;
                    [self performSelector:@selector(pushToLoginView_GestureVerify) withObject:nil afterDelay:0.5];
                }
                
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",errorCount] forKey:@"maxGestureError"]; //手势密码最大出错次数;
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.msgLabel showWarnMsgAndShake:[NSString stringWithFormat:gestureTextGestureVerifyError,[[NSUserDefaults standardUserDefaults] objectForKey:@"maxGestureError"]]];
            }
            
        }
        
    }
}
- (void)pushToLoginView_GestureVerify{
#pragma mark - 登出操作
    [AppDelegate App].isHaveGesture = NO;
    if ([AppDelegate App].userDic != nil){
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_LOGINOUT] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:WEBVIEW_TIMEOUT];
        [webView loadRequest:request];
        [self.view addSubview:webView];
        [webView setHidden:YES];
#pragma mark - 清除webCookies
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray* heXunCookies = [storage cookiesForURL:[NSURL URLWithString:H5HEADURL]];
        for (NSHTTPCookie *cookie in heXunCookies)
        {
            [storage deleteCookie:cookie];
        }
#pragma mark - 清除手势
        if ([[PCCircleViewConst getGestureWithKey:[[AppDelegate App].userDic heHuoRenObjectForKey:@"userMobile"]] length]) {
            [PCCircleViewConst removeGestureWithKey:[[AppDelegate App].userDic heHuoRenObjectForKey:@"userMobile"]];
        }
    }
//    [[NSUserDefaults standardUserDefaults] setObject:@"YES"  forKey:PushToLoginView];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:User_Current];
    [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *nav = (UINavigationController *)app.window.rootViewController.navigationController;
    [nav popToRootViewControllerAnimated:NO];//先推到顶堆栈，然后从堆栈指定到某个页面
}

- (NSString *)setTelephoneNum:(NSString *)phoneNum{
    
    if ([phoneNum length] > 0) {
        NSString * num= [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return num;
    }
    else {
        return @"null";
    }

}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.barTintColor=[UIColor colorWithHexString:@"#0fa8ff"];
//}
@end
