//
//  HXWebBasicViewController.m
//  HeXunRongHeJinFu
//
//  Created by 庄小宁 on 15/12/5.
//  Copyright © 2015年 庄小宁. All rights reserved.
//

#import "HXWebBasicViewController.h"
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"
#import "AFHTTPSessionManager.h"
#import "SBJsonParser.h"
#import <objc/runtime.h>
@interface HXWebBasicViewController ()

@end



@implementation HXWebBasicViewController
//@synthesize delegate_login;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [AppDelegate App].isCurrentVC = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithHexString:@"#0fa8ff"];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"backGray@2x.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(popToVC:) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.frame=CGRectMake(10, 25, 21, 30);
    [_backBtn setBackgroundColor:[UIColor clearColor]];
    [_backBtn setHidden:YES];
    
    self.errorView = [[HXErrorView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.errorView addTarget:self action:@selector(startRequest:) forControlEvents:UIControlEventTouchUpInside];
    self.errorView.backgroundColor=[UIColor whiteColor];
    self.errorView.delegate = self;
    [self.errorView setHidden:YES];
    
    self.mySetting = [[MyJSTest alloc]init];
    self.mySetting.delegate = self;
    
    self.myWebView = [[EasyJSWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.myWebView.scrollView.bounces = NO;
    self.myWebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.myWebView.delegate=self;
    self.myWebView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self.myWebView addJavascriptInterfaces:self.mySetting WithName:@"javatojs"];
    _errorView.center = self.myWebView.center;
    
    [self.view addSubview:self.myWebView];
    [self.view addSubview:self.errorView];
    [self.view addSubview:_backBtn];
    
    self.view.userInteractionEnabled = YES;
    
}
- (void)popToVC:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    CLog(@"HXWebBasicViewController -> %@",request.URL.absoluteString);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.errorView performSelectorOnMainThread:@selector(EVstartAnimating) withObject:nil waitUntilDone:YES];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"onSetKnowChannel('RHJF_APP_IOS_KC');"];
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"onSetAppVersion('2');"];
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [self.errorView performSelectorOnMainThread:@selector(EVstopAnimating) withObject:nil waitUntilDone:YES];
    [self.errorView setHidden:YES];
    [self.backBtn setHidden:YES];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    CLog(@"load page error:%@", [error description]);
    if (error.code == NSURLErrorCancelled) {
        return;
    }
    [self.errorView performSelectorOnMainThread:@selector(EVstopAnimatingWithError) withObject:nil waitUntilDone:YES];
    [self.errorView setHidden:NO];
    [self.backBtn setHidden:NO];
    
}
- (void)JSWithType:(NSString*)type AndJsonString:(NSString *)string{
    CLog(@"JS 解析:%@-%@",type,string);
    self.errorView.isJSFunction = YES;
    /*{"version":"1","userMobile":"13564787541","userSex":"1","userName":"孩子他爸","token":"5BEA5F1605E650A6D6B03CAB4B4A3A70F5A388B14AFD9F5848BB933375AFB53E"}*/
    NSString *str = [NSString stringWithFormat:@"%@",string];
    SBJsonParser *sbjson = [[SBJsonParser alloc] init];
    NSDictionary* dic = [sbjson objectWithString:str];
    if([type isEqualToString:@"1"]==YES && [dic boolObjectOfData:@"userMobile"]){//登录成功返回
        [[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:@"maxGestureError"]; //手势密码最大出错次数;
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *version = [dic heHuoRenObjectForKey:@"version"];
        NSString *userMobile = [dic heHuoRenObjectForKey:@"userMobile"];
        NSString *userSex = [dic heHuoRenObjectForKey:@"userSex"];
        NSString *userName = [dic heHuoRenObjectForKey:@"userName"];
        NSString *tokenStr = [dic heHuoRenObjectForKey:@"token"];
        
        NSDictionary *dic_save = [NSDictionary dictionaryWithObjectsAndKeys:version,@"version",
                                  userMobile,@"userMobile",userSex,@"userSex",userName,@"userName",tokenStr,@"token",
                                  nil];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:User_Current];
        [[NSUserDefaults standardUserDefaults] setValue:[NSKeyedArchiver archivedDataWithRootObject:dic_save]  forKey:User_Current];//当前用户信息
        NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:User_Current];
        [AppDelegate App].userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];;
        [[NSUserDefaults standardUserDefaults] synchronize];
        if ([[PCCircleViewConst getGestureWithKey:[dic heHuoRenObjectForKey:@"userMobile"]] length]) {
            [AppDelegate App].isHaveGesture = YES;
        }
        //        NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:User_History];
        //        NSMutableArray *userArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        //        
        //        NSMutableArray *nameArray = nil;
        //        for (NSDictionary *dic_history in userArray) {
        //            if ([dic_history objectForKey:@"userName"]){
        //                [nameArray addObject:[dic_history objectForKey:@"userName"]];
        //            }
        //        }
        //        
        //        if ([nameArray containsObject:userName]==NO) {
        //            [userArray   addObject:dic_save];
        //            
        //        }
        //        
        //        [[NSUserDefaults standardUserDefaults] setValue:[NSKeyedArchiver archivedDataWithRootObject:userArray]  forKey:User_History];//历史用户信息
        //        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //        for (NSMutableDictionary *dic_history in userArray) {
        //            if ([[dic_history objectForKey:@"userName"] isEqualToString:userName] && [dic_history objectForKey:@"gessture"]) {
        //                [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"GestureSwitch"];
        //                [PCCircleViewConst saveGesture:[dic_history objectForKey:@"gesture"] Key:gestureFinalSaveKey];
        //                break;
        //            }
        //        }
        
        
        //        [[NSUserDefaults standardUserDefaults] setObject:@"NO"  forKey:PushToLoginView];
        [AppDelegate App].isLogin = YES;
//        if (self.delegate_login &&[self.delegate_login respondsToSelector:@selector(HXWebLoginSuccess:)]) {
//            [self.delegate_login HXWebLoginSuccess:self];
//        }
        /*
         for (NSInteger num=0; num<self.navigationController.viewControllers.count; num++) {
         UIViewController *temp=self.navigationController.viewControllers[num];
         if ([temp isKindOfClass:[HXSafeCenterViewController class]]) {
         [self.navigationController popToViewController:temp animated:YES];
         break;
         }
         if (num==self.navigationController.viewControllers.count-1) {
         [self.navigationController popToRootViewControllerAnimated:YES];
         }
         }*/
        
    }else if([type isEqualToString:@"2"]==YES){//产品分享
        NSString *imageUrl = [dic heHuoRenObjectForKey:@"imageUrl"];
        NSString *title = [dic heHuoRenObjectForKey:@"title"];
        NSString *content = [dic heHuoRenObjectForKey:@"content"];
        NSString *shareUrl = [dic heHuoRenObjectForKey:@"shareUrl"];
        [self UMShreWithText:content andShareImage:[self getImageFromURL:imageUrl] andTitle:title andShareUrl:shareUrl];
        
    }else if([type isEqualToString:@"3"] == YES){//返回原生界面
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if([type isEqualToString:@"5"]==YES && [dic boolObjectOfData:@"tel"]){//拨打电话
        tel= [dic heHuoRenObjectForKey:@"tel"];
        [self makeTelephone:tel];
    }
    else if ([type isEqualToString:@"6"] == YES && [[AppDelegate App].userDic boolObjectOfData:@"userMobile"]) { //新用户首次注册成功跳转手势界面
        GestureViewController *gestureVc = [[GestureViewController alloc] init];
        gestureVc.type = GestureViewControllerTypeSetting;
        gestureVc.isNewUser = YES;
        gestureVc.delegate = self;
        [self presentViewController:gestureVc animated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:NO];
    }
    else if ([type isEqualToString:@"9"] == YES && [dic boolObjectOfData:@"isOpen"]) {
        if ([[dic heHuoRenObjectForKey:@"isOpen"] isEqualToString:@"YES"]) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            self.myWebView.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
            self.myWebView.scrollView.scrollEnabled = NO;
        }
        else if ([[dic heHuoRenObjectForKey:@"isOpen"] isEqualToString:@"NO"]) {
            self.myWebView.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20);
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
            self.myWebView.scrollView.scrollEnabled = YES;
        }
    }
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    if ([fileURL length] != 0) {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        result = [UIImage imageWithData:data];
    }
    else {
        result = [UIImage imageNamed:@"icon-120.png"];
        
    }
    return result;
    
}

- (void)UMShreWithText:(NSString *)shareText andShareImage:(UIImage *)shareImage andTitle:(NSString *)title andShareUrl:(NSString *)shareUrl{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina,nil]
                                       delegate:self];
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;//朋友圈
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;//好友
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeNone;//默认为图文
    
    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
    [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
    [UMSocialData defaultData].extConfig.qqData.title = title;
    [UMSocialData defaultData].extConfig.qzoneData.title = title;
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
    
}
- (void)makeTelephone:(NSString *)telephoneNum{
    float iOSVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (iOSVersion < 9.0f) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:[NSString stringWithFormat:@"是否拨打电话:\n%@",telephoneNum]
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"拨打", nil];

        [alert show];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"提示"
                                                                       message: [NSString stringWithFormat:@"是否拨打电话:\n%@",telephoneNum]
                                                                preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: @"取消"
                                                               style: UIAlertActionStyleCancel
                                                             handler: nil];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle: @"拨打"
                                                              style: UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
             NSString *url=[NSString stringWithFormat:@"tel://%@",tel];
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }];
        
        [alertController addAction: cancelAction];
        [alertController addAction: otherAction];
        
        [cancelAction setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
        [otherAction setValue:UIColorFromRGB(0x0fa8ff) forKey:@"titleTextColor"];
        
//        //修改title
//        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
//        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
//        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 2)];
//        [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
//        //修改message
//        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"提示内容"];
//        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, 4)];
//        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 4)];
//        [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        
        [self presentViewController:alertController animated:YES completion:nil];
    
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView{
    CLog(@"%@",alertView.subviews);
    for( UIView * view in alertView.subviews)
    {
        if( [view isKindOfClass:[UILabel class]] )
        {
            UILabel* label = (UILabel*) view;
            label.textAlignment = NSTextAlignmentLeft;
            label.font=[UIFont fontWithName:@"STHeitiSC-Medium" size:18];
            if ([label.text hasPrefix:@"是否拨打电话:"]) {
                label.textColor=[UIColor blueColor];
            }else if ([label.text hasPrefix:@"提示"]){
                label.textColor=[UIColor blackColor];
            }
        }else if ( [view isKindOfClass:[UIButton class]] ){
            UIButton* btn = (UIButton*) view;
            if ([btn.titleLabel.text isEqualToString:@"拨打"]) {
                [btn setTitleColor:UIColorFromRGB(0x0fa8ff) forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
        NSString *url=[NSString stringWithFormat:@"tel://%@",tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark HXErrorViewDelegate Methods
- (void) onCallBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
