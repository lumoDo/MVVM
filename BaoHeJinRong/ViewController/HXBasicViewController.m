//
//  HXBasicViewController.m
//  HeXunRongHeJinFu
//
//  Created by 庄小宁 on 15/12/18.
//  Copyright © 2015年 庄小宁. All rights reserved.
//

#import "HXBasicViewController.h"
#import "HXSafeCenterViewController.h"
#import "HXSettingWebViewController.h"
#import "AFHTTPSessionManager.h"
//#import "HXSecondViewController.h"
@interface HXBasicViewController ()

@end

@implementation HXBasicViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [AppDelegate App].isCurrentVC = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)setNavigationTitleView:(NSString *)title andBarTintColor:(int)rgb
{
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(rgb);//背景色
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //计算一段文本的尺寸大小
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:CHANGGUI size:18]};
    CGSize labelsize = [title boundingRectWithSize:CGSizeMake(100, 0) options: NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelsize.width, labelsize.height)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:CUTI size:18.0];
//    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5]; //浮雕效果8
    label.textColor = [UIColor whiteColor]; // change this color
    label.text = NSLocalizedString(title, @"");
    self.navigationItem.titleView = label;
}

- (UIBarButtonItem *)buildLeftBarButtonItem
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(setBackAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(0, 10, 21, 30);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return backItem;
}
- (UIBarButtonItem *)buildRightBarButtonItem{
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [self buildLeftBarButtonItem];
    self.navigationItem.rightBarButtonItem = [self buildRightBarButtonItem];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:User_Current];
    if (data != nil) {
        [AppDelegate App].userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
}
- (void)setBackAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)openGessture{
    NSString *closeClientTime = [[NSUserDefaults standardUserDefaults]stringForKey:@"closeClientTime"];
    NSString *openClientTime = [[NSUserDefaults standardUserDefaults]stringForKey:@"openClientTime"];
    NSString *gestureStr = [[NSUserDefaults standardUserDefaults]stringForKey:@"checkSuccess"];
    float time = [self intervalFromLastDate:closeClientTime
                                  toTheDate:openClientTime];
    
    if ([AppDelegate App].isHaveGesture == YES && [gestureStr isEqualToString:@"0"]) {
        if (closeClientTime && openClientTime)  {
            if (time>=Time_BACKGROUND) {
                [AppDelegate App].isOpenGessture = YES;
            }else{
                [AppDelegate App].isOpenGessture = NO;
            }
        }else{
            [AppDelegate App].isOpenGessture = YES;
        }
    }else{
        [AppDelegate App].isOpenGessture = NO;
    }
}
- (void)gestureLoginSuccess:(NSInteger)vcTag{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"closeClientTime"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"openClientTime"];
    
    [AppDelegate App].isOpenGessture = NO;
    
    if (vcTag == 501) {
        HXSafeCenterViewController *safeCenterVC=[[HXSafeCenterViewController alloc]init];
        safeCenterVC.title = TITLE_SAFECENTER;
        safeCenterVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:safeCenterVC animated:YES];
    }else if (vcTag == 502){
//        HXSecondViewController *setWebView=[[HXSecondViewController alloc]init];
//        setWebView.urlStr=URL_NAME;
//        setWebView.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:setWebView animated:YES];
    }else if (vcTag == 503){
//        HXSecondViewController *setWebView=[[HXSecondViewController alloc]init];
//        setWebView.urlStr=URL_FEEDBACK;
//        setWebView.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:setWebView animated:YES];
    }else if(vcTag == 504){
//        HXSecondViewController *setWebView=[[HXSecondViewController alloc]init];
//        setWebView.urlStr=URL_MYBANKCARD;
//        setWebView.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:setWebView animated:YES];
        
    }
    
}
- (void)checkGesturePassword:(NSInteger)vcTag{
    GestureViewController *gestureVc = [[GestureViewController alloc] init];
    gestureVc.vcTag = vcTag;
    gestureVc.delegate=self;
    [gestureVc setType:GestureViewControllerTypeLogin];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:gestureVc];
    [[AppDelegate App].window.rootViewController presentViewController:nav animated:NO completion:nil];
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

-(void)showTips:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil
                          ];
    [alert show];
    int delayInSeconds = 2;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}

//-(void)pushToFisrtVC_Gesture{
////    [[NSNotificationCenter defaultCenter]postNotificationName:@"PushLoginView" object:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

//- (void)loginOut{
//
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    [session GET:URL_LOGINOUT parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        [AppDelegate App].isLogin = NO;
//        CLog(@"成功");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        CLog(@"失败");
//    }];
//}

- (void)removeNavigationBarBlackImageView
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
