
#import "GestureViewController.h"
#import "PCCircleView.h"
#import "PCCircleViewConst.h"
#import "PCLockLabel.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"
#import "HXSafeCenterViewController.h"
//#import "HXSettingWebViewController.h"
@interface GestureViewController ()<CircleViewDelegate>

/**
 *  重设按钮
 */
@property (nonatomic, strong) UIButton *resetBtn;

/**
 *  提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;

/**
 *  解锁界面
 */
@property (nonatomic, strong) PCCircleView *lockView;

/**
 *  infoView
 */
@property (nonatomic, strong) PCCircleInfoView *infoView;


@end

@implementation GestureViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.type == GestureViewControllerTypeLogin) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    //    [self.navigationController.navigationBar setBarTintColor:CircleViewBackgroundColor];
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // 进来先清空存的第一个密码
    [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isNewUser = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:CircleViewBackgroundColor];
    //    [self.navigationController.navigationBar setBarTintColor:CircleViewBackgroundColor];

    // 1.界面相同部分生成器
    [self setupSameUI];
    
    // 2.界面不同部分生成器
    [self setupDifferentUI];
    
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
    t.text = @"设置手势密码";
    [bg addSubview:t];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (self.isNewUser == YES) {
        backBtn.frame = CGRectMake((SCREEN_WIDTH - kScreenW/2)/2 , SCREEN_HEIGHT - 60, kScreenW/2, 20);
        [backBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [backBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.view addSubview:backBtn];
    }
    else {
        UIImage *setImg = [UIImage imageNamed:@"backItem"];
        backBtn.frame = CGRectMake(10, 10, 21, 30);
        [backBtn setBackgroundImage:setImg forState:UIControlStateNormal];
        [bg addSubview:backBtn];
    }
    [backBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"重设" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(SCREEN_WIDTH-60, 10, 60, 30);//(CGRect){CGPointZero, {100, 20}};
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.tag = buttonTagReset;
    //    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [button setHidden:YES];
    [bg addSubview:button];
    self.resetBtn = button;
}
- (void)setBack{
    if (self.isNewUser == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
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
}

#pragma mark - 创建UIBarButtonItem
//- (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action tag:(NSInteger)tag
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    button.frame = (CGRect){CGPointZero, {100, 20}};
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:17];
//    button.tag = tag;
//    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [button setHidden:YES];
//    self.resetBtn = button;
//    return [[UIBarButtonItem alloc] initWithCustomView:button];
//}

#pragma mark - 界面不同部分生成器
- (void)setupDifferentUI
{
    switch (self.type) {
        case GestureViewControllerTypeSetting:
            [self setupSubViewsSettingVc];
            break;
        case GestureViewControllerTypeLogin:
            [self setupSubViewsLoginVc];
            break;
        default:
            break;
    }
}

#pragma mark - 界面相同部分生成器
- (void)setupSameUI
{
    // 创建导航栏右边按钮
    //    self.navigationItem.rightBarButtonItem = [self itemWithTitle:@"重设" target:self action:@selector(didClickBtn:) tag:buttonTagReset];
    
    // 解锁界面
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    self.lockView = lockView;
    [self.view addSubview:lockView];
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 30);
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.numberOfLines = 2;
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 30);
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}

#pragma mark - 设置手势密码界面
- (void)setupSubViewsSettingVc
{
    [self.lockView setType:CircleViewTypeSetting];
    
    self.title = @"设置手势密码";
    
    [self.msgLabel showNormalMsg:gestureTextBeforeSet];
    
    PCCircleInfoView *infoView = [[PCCircleInfoView alloc] init];
    infoView.frame = CGRectMake(0, 0, CircleRadius * 2 * 0.6, CircleRadius * 2 * 0.6);
    infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel.frame) - CGRectGetHeight(infoView.frame)/2 - 10);
    self.infoView = infoView;
    [self.view addSubview:infoView];
    
    [self setNavigationView];
    
}

#pragma mark - 登陆手势密码界面
- (void)setupSubViewsLoginVc
{
    [self.lockView setType:CircleViewTypeLogin];
    
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
    
    self.msgLabel.frame = CGRectMake(0, telLabel.frame.origin.y+telLabel.frame.size.height+5, kScreenW, 30);
    
    // 管理手势密码
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self creatButton:leftBtn frame:CGRectMake(CircleViewEdgeMargin + 20, kScreenH - 60, kScreenW/2, 20) title:@"忘记手势密码" alignment:UIControlContentHorizontalAlignmentLeft tag:buttonTagForget];
    
    // 登录其他账户
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self creatButton:rightBtn frame:CGRectMake(kScreenW/2 - CircleViewEdgeMargin - 20, kScreenH - 60, kScreenW/2, 20) title:@"切换账户" alignment:UIControlContentHorizontalAlignmentRight tag:buttonTagManager];
}

#pragma mark - 创建UIButton
- (void)creatButton:(UIButton *)btn frame:(CGRect)frame title:(NSString *)title alignment:(UIControlContentHorizontalAlignment)alignment tag:(NSInteger)tag
{
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:alignment];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - button点击事件
- (void)didClickBtn:(UIButton *)sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case buttonTagReset:
        {
            NSLog(@"点击了重设按钮");
            // 1.隐藏按钮
            [self.resetBtn setHidden:YES];
            
            // 2.infoView取消选中
            [self infoViewDeselectedSubviews];
            
            // 3.msgLabel提示文字复位
            [self.msgLabel showNormalMsg:gestureTextBeforeSet];
            
            // 4.清除之前存储的密码
            [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
        }
            break;
        case buttonTagManager:
        {
            CLog(@"点击了登录其他账户按钮");
            [self openTips:@"确认切换用户？"];
            
            
        }
            break;
        case buttonTagForget:{
            CLog(@"点击了忘记手势密码按钮");
            
            [self openTips:@"忘记手势密码,需重新登录"];
        }
            
            break;
        default:
            break;
    }
}

#pragma mark - circleView - delegate
#pragma mark - circleView - delegate - setting
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture
{
    NSString *gestureOne = [PCCircleViewConst getGestureWithKey:gestureOneSaveKey];
    
    // 看是否存在第一个密码
    if ([gestureOne length]) {
        [self.resetBtn setHidden:NO];
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    } else {
        NSLog(@"密码长度不合法%@", gesture);
        [self.msgLabel showWarnMsgAndShake:gestureTextConnectLess];
    }
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    NSLog(@"获得第一个手势密码%@", gesture);
    //    [self.resetBtn setHidden:NO];
    [self.msgLabel showWarnMsg:gestureTextDrawAgain];
    
    // infoView展示对应选中的圆
    [self infoViewSelectedSubviewsSameAsCircleView:view];
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal
{
    NSLog(@"获得第二个手势密码%@",gesture);
    
    if (equal) {
        [[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:@"maxGestureError"]; //手势密码最大出错次数;
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"两次手势匹配！可以进行本地化保存了");
        //        NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:User_History];
        //        NSMutableArray *userArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
//        NSData *data1 = [[NSUserDefaults standardUserDefaults] valueForKey:User_Current];
//        NSDictionary *userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        //        for (NSDictionary *dic in userArray) {
        //            if ([[dic heHuoRenObjectForKey:@"userName"] isEqualToString:[userDic heHuoRenObjectForKey:@"userName"]]) {
        //                NSString *version = [dic objectForKey:@"version"];
        //                NSString *userMobile = [dic objectForKey:@"userMobile"];
        //                NSString *userSex = [dic objectForKey:@"userSex"];
        //                NSString *userName = [dic objectForKey:@"userName"];
        //                NSString *tokenStr = [dic objectForKey:@"token"];
        //                
        //                NSDictionary *dic_save = [NSDictionary dictionaryWithObjectsAndKeys:version,@"version",
        //                                          userMobile,@"userMobile",userSex,@"userSex",userName,@"userName",tokenStr,@"token",gesture,@"gesture",
        //                                          nil];
        //                
        //                //                [dic setValue:gesture forKey:@"gesture"];
        //                //                [dic setObject:gesture forKey:@"gesture"];
        //                int location =(int) [userArray indexOfObject:dic];
        //                userArray[location] = dic_save;
        //                [[NSUserDefaults standardUserDefaults] setValue:[NSKeyedArchiver archivedDataWithRootObject:userArray]  forKey:User_History];//历史用户信息
        //                break;
        //            }
        //        }
        //        //        [[NSUserDefaults standardUserDefaults] setValue:[NSKeyedArchiver archivedDataWithRootObject:userArray]  forKey:User_History];//历史用户信息
        
        [self.msgLabel showWarnMsg:gestureTextSetSuccess];
        
        [PCCircleViewConst saveGesture:gesture Key:[[AppDelegate App].userDic heHuoRenObjectForKey:@"userMobile"]];
        [AppDelegate App].isHaveGesture = YES;
        if (self.isNewUser == YES) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
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
        if(self.delegate && [self.delegate respondsToSelector:@selector(gestureSuccess)]){
            [self.delegate gestureSuccess];
        }
        
    } else {
        NSLog(@"两次手势不匹配！");
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
        [self.resetBtn setHidden:NO];
    }
}
#pragma mark - circleView - delegate - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    // 此时的type有两种情况 Login or verify
    if (type == CircleViewTypeLogin) {
        
        if (equal) {
            [[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:@"maxGestureError"]; //手势密码最大出错次数;
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"登陆成功！");
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"checkSuccess"];
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(gestureLoginSuccess:)]){
                [self.delegate gestureLoginSuccess:_vcTag];
            }
            //            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            NSLog(@"密码错误！");
            int errorCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"maxGestureError"]intValue];
            errorCount--;
            CLog(@"剩余密码错误%d次",errorCount);

            if(errorCount <= 0){
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"maxGestureError"]; //手势密码最大出错次数;
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.msgLabel showWarnMsgAndShake:STR_GESSTURE_ERROR];//跳转到登陆页面
                if ([AppDelegate App].isLogin == YES) {
                    [AppDelegate App].isLogin = NO;
                    [self performSelector:@selector(pushToLoginView_Gesture) withObject:nil afterDelay:0.5];
                }
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",errorCount] forKey:@"maxGestureError"]; //手势密码最大出错次数;
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.msgLabel showWarnMsgAndShake:[NSString stringWithFormat:gestureTextGestureVerifyError,[[NSUserDefaults standardUserDefaults] objectForKey:@"maxGestureError"]]];
            }
        }
    } else if (type == CircleViewTypeVerify) {
        
        if (equal) {
            [[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:@"maxGestureError"]; //手势密码最大出错次数;
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"验证成功，跳转到设置手势界面");
            
        } else {
            NSLog(@"原手势密码输入错误！");
            int errorCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"maxGestureError"]intValue];
            errorCount--;
            CLog(@"剩余密码错误%d次",errorCount);
            if(errorCount <= 0){
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"maxGestureError"]; //手势密码最大出错次数;
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.msgLabel showWarnMsgAndShake:STR_GESSTURE_ERROR];//跳转到登陆页面
                if ([AppDelegate App].isLogin == YES) {
                    [AppDelegate App].isLogin = NO;
                    [self performSelector:@selector(pushToLoginView_Gesture) withObject:nil afterDelay:0.5];
                }
                
                
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",errorCount] forKey:@"maxGestureError"]; //手势密码最大出错次数;
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.msgLabel showWarnMsgAndShake:[NSString stringWithFormat:gestureTextGestureVerifyError,[[NSUserDefaults standardUserDefaults] objectForKey:@"maxGestureError"]]];
            }
        }
    }
}

#pragma mark - infoView展示方法
#pragma mark - 让infoView对应按钮选中
- (void)infoViewSelectedSubviewsSameAsCircleView:(PCCircleView *)circleView
{
    for (PCCircle *circle in circleView.subviews) {
        
        if (circle.state == CircleStateSelected || circle.state == CircleStateLastOneSelected) {
            
            for (PCCircle *infoCircle in self.infoView.subviews) {
                if (infoCircle.tag == circle.tag) {
                    [infoCircle setState:CircleStateSelected];
                }
            }
        }
    }
}

#pragma mark - 让infoView对应按钮取消选中
- (void)infoViewDeselectedSubviews
{
    [self.infoView.subviews enumerateObjectsUsingBlock:^(PCCircle *obj, NSUInteger idx, BOOL *stop) {
        [obj setState:CircleStateNormal];
    }];
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
-(void)openTips:(NSString *)string{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil
                          ];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        [AppDelegate App].isLogin = NO;
        [self pushToLoginView_Gesture];
    }
    
}
- (void)pushToLoginView_Gesture{
#pragma mark - 登出操作
    [AppDelegate App].isHaveGesture = NO;
    if ([AppDelegate App].userDic != nil){
//        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_LOGINOUT] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:WEBVIEW_TIMEOUT];
//        [webView loadRequest:request];
//        [self.view addSubview:webView];
//        [webView setHidden:YES];
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
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:User_Current];
    [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *nav = (UINavigationController *)app.window.rootViewController.navigationController;
    [nav popToRootViewControllerAnimated:NO];//先推到顶堆栈，然后从堆栈指定到某个页面
    
}

@end
