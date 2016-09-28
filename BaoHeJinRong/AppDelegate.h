//
//  AppDelegate.h
//  BaoHeJinRong
//
//  Created by Richard on 16/9/20.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#define UmengAppkey @"5677a6dee0f55ab3ac000b32"//线上
@class BHMVVMImpl;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIWebViewDelegate,CycleScrollViewDelegate>
{
    CycleScrollView *scrollview;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic, strong) NSDictionary *userDic;//当前用户
@property (nonatomic, assign) BOOL isOpenGessture;
@property (nonatomic, assign) BOOL isCurrentVC;//该页面是否需要登录，验证手势密码
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isHaveGesture;
@property (strong, nonatomic) BHMVVMImpl *impl;
//@property (strong, nonatomic) UIViewController *adImageViewC;
+ (AppDelegate *)App;


@end

