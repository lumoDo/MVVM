//
//  AppDelegate.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/20.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "AppDelegate.h"
#import "PCCircleViewConst.h"
#import "BHFirstViewController.h"
#import "BHProductViewController.h"
#import "BHDiscoveryViewController.h"
#import "BHMyViewController.h"
#import "BHMVVMImpl.h"
#import "APService.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialInstagramHandler.h"
#import "UMSocialSinaHandler.h"
#import <CommonCrypto/CommonDigest.h>

@interface AppDelegate ()

@property (strong, nonatomic) UITabBarController *tabBarController;

@end

@implementation AppDelegate
{
    BOOL    isSaveTime;
}

+ (AppDelegate *)App
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:[self createTabBarController]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor =  [UIColor colorForKey:kColorNaviTitle];//背景色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    [self setUMShare];
    [self initJPush:launchOptions];
    [self setScrollview];
    return YES;
}

- (UITabBarController *)createTabBarController
{
    
    BHFirstViewController *homeVC=[BHFirstViewController shareInstance];
    BHProductViewController *productListVC = [BHProductViewController shareInstance];
    BHDiscoveryViewController *discoveryVC = [BHDiscoveryViewController shareInstance];
    BHMyViewController *myAssetsVC = [BHMyViewController shareInstance];
    
//    UINavigationController *homeNvc=[[UINavigationController alloc]initWithRootViewController:homeVC];
//    UINavigationController *productListNav = [[UINavigationController alloc]initWithRootViewController:productListVC];
//    UINavigationController *discoveryNav = [[UINavigationController alloc]initWithRootViewController:discoveryVC];
//    UINavigationController *myAssetsNav = [[UINavigationController alloc]initWithRootViewController:myAssetsVC];
    
    _tabBarController = [[UITabBarController alloc]init];
    _tabBarController.viewControllers = [NSArray arrayWithObjects:homeVC, productListVC, discoveryVC, myAssetsVC, nil];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:10.0f],
                                                        NSForegroundColorAttributeName : UIColorFromRGB(0x0fa8ff)
                                                        } forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:10.0f],
                                                        NSForegroundColorAttributeName : UIColorFromRGB(0x999999) }
                                             forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, _tabBarController.tabBar.frame.size.width, _tabBarController.tabBar.frame.size.height);
    
    UIView *v = [[UIView alloc]initWithFrame:frame];
    
    [v setBackgroundColor:[UIColor whiteColor]];
    [_tabBarController.tabBar setBackgroundImage:[self createImageWithColor:UIColorFromRGB(0xdddddd)]];
    [_tabBarController.tabBar setShadowImage:[self createImageWithColor:UIColorFromRGB(0xdddddd)]];
    [_tabBarController.tabBar insertSubview:v atIndex:0];
    
    self.impl = [[BHMVVMImpl alloc] initTabBarController:_tabBarController];
    return _tabBarController;
}

// 打开应用是否开启推送
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    BOOL isPush = [[NSUserDefaults standardUserDefaults] boolForKey:@"push"];
    if (isPush)
    {
        [APService registerDeviceToken:deviceToken];
    }
    NSString *devToken = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString:@"<"withString:@""]
                           stringByReplacingOccurrencesOfString:@">" withString:@""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    [[NSUserDefaults standardUserDefaults] setValue:devToken
                                             forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//显示推送内容
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];
    CLog(@"push note %@", userInfo);
}

-(void) initJPush:(NSDictionary *)launchOptions
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
    
}

-(void)unObserveAllNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidSetupNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidCloseNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidRegisterNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidLoginNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidReceiveMessageNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFServiceErrorNotification
                           object:nil];
}

- (void)networkDidSetup:(NSNotification *)notification
{
    CLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification
{
    CLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification
{
    CLog(@"%@", [notification userInfo]);
    
    CLog(@"RegistrationID:%@",
         [[notification userInfo] valueForKey:@"RegistrationID"]);
    
    CLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification
{
    
    CLog(@"已登录");
    
    if ([APService registrationID]) {
        CLog(@"get RegistrationID : %@", [APService registrationID]);
    }
}

-(void)serviceError:(NSNotification *)notification{
    
}
- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    
    BOOL isAllowPush = [[NSUserDefaults standardUserDefaults] boolForKey:@"push"];
    if( isAllowPush == NO )
    {
        return;
    }
    
    NSDictionary *userInfo = [notification userInfo];
    NSString *contentStr = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    //json parse
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);//kCFStringEncodingUTF8
    NSData *jsonData = [contentStr dataUsingEncoding:enc];
    NSString *strData = [[NSString alloc] initWithData:jsonData encoding:enc];
    CLog(@"%@",strData);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"checkSuccess"];
    
    CLog(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"closeClientTime"]);
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSString * morelocationString=[dateformatter stringFromDate:senddate];
    [[NSUserDefaults standardUserDefaults] setObject:morelocationString forKey:@"closeClientTime"];
    isSaveTime = YES;
    //#pragma mark - 清除webCookies
    //    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //    NSArray* heXunCookies = [storage cookiesForURL:[NSURL URLWithString:H5HEADURL]];
    //    for (NSHTTPCookie *cookie in heXunCookies)
    //    {
    //        [storage deleteCookie:cookie];
    //    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
#pragma mark - 手势密码验证
    if (isSaveTime) {
        NSDate * senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
        NSString * morelocationString=[dateformatter stringFromDate:senddate];
        [[NSUserDefaults standardUserDefaults] setObject:morelocationString forKey:@"openClientTime"];
        isSaveTime = NO;
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"closeClientTime"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"openClientTime"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"checkSuccess"];
    
    NSString *closeClientTime = [[NSUserDefaults standardUserDefaults]stringForKey:@"closeClientTime"];
    NSString *openClientTime = [[NSUserDefaults standardUserDefaults]stringForKey:@"openClientTime"];
    float time = [self intervalFromLastDate:closeClientTime
                                  toTheDate:openClientTime];
    
    self.isHaveGesture = NO;
    if (self.userDic != nil){
        if ([[PCCircleViewConst getGestureWithKey:[self.userDic heHuoRenObjectForKey:@"userMobile"]] length]) {
            self.isHaveGesture = YES;
        }
        if (self.isHaveGesture == YES && [AppDelegate App].isCurrentVC == YES && time>=Time_BACKGROUND && self.isLogin) {
            GestureViewController *gestureVc = [[GestureViewController alloc] init];
            [gestureVc setType:GestureViewControllerTypeLogin];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:gestureVc];
            [self.window.rootViewController presentViewController:nav animated:NO completion:nil];
            
        }
        
#pragma mark - 解决2次登录问题（需要修改）
        
        if ([self.userDic boolObjectOfData:@"token"]) {
            NSString *transVerifyKey = @"HEXUNFSD";
            
            NSDate * nowDate=[NSDate date];
            NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"YYYYMMdd"];
            NSString * morelocationString=[dateformatter stringFromDate:nowDate];
            
            NSString *md5Str = [NSString stringWithFormat:@"%@%@%@",transVerifyKey,morelocationString,[self.userDic heHuoRenObjectForKey:@"token"]];
            NSString *signature = [self md5:md5Str];
            
            UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/app/publicweb/autoLogin?appPara1=%@&appPara2=%@",H5HEADURL,signature,[self.userDic heHuoRenObjectForKey:@"token"]]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:WEBVIEW_TIMEOUT];
            [webView loadRequest:request];
            webView.delegate = self;
            [self.window addSubview:webView];
            [webView setHidden:YES];
        }
    }

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma - UM-Share
- (void)setUMShare
{
    [UMSocialData setAppKey:UmengAppkey];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxd97650442a16f518" appSecret:@"0fb3f4938d8c40e2743c108eaa09d09d" url:@"http://www.rhjf.com.cn/"];
    // 打开新浪微博的SSO开关
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"715019441"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1105151306" appKey:@"IiIgnJGHP5uI9ZbI" url:@"http://www.rhjf.com.cn/"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
    //    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}
#pragma mark  - 
- (void)setScrollview
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"firstIn"] intValue] < [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] intValue]) {
        [defaults setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"firstIn"];
        [defaults synchronize];
        NSMutableArray * imgList = [NSMutableArray array];
        for (int i = 1; i < 4; i ++) {
            NSString * path = [NSString stringWithFormat:@"indidate_%d.png",i];
            UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:path]];
            imgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleToFill;
            [imgList addObject:imgView];
        }
        scrollview = [[CycleScrollView alloc]initWithFrame:[[UIScreen mainScreen] bounds] pictures:imgList];
        scrollview.showNumLabel.hidden = YES;
        scrollview.delegate =self;
        scrollview.backgroundColor = [UIColor whiteColor];
        [self.window addSubview:scrollview];
    }
}

-(void)pageViewClicked:(NSInteger)pageIndex
{
    [UIView animateWithDuration:0.5 animations:^(void){
        scrollview.alpha = 0;
    }completion:^(BOOL finished){
        [scrollview removeFromSuperview];
    }];
}

#pragma - 

- (UIImage *)createImageWithColor:(UIColor *)color

{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

- (float)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    CLog(@"dateOne = %@.....dateTwo = %@",dateString1,dateString2);
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late2-late1;
    
    CLog(@"#######__%f",cha);
    
    return cha;
}

- (NSString *)md5:(NSString *)str
{
    
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
    
}

@end
