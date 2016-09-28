//
//  BHMVVMImpl.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/21.
//  Copyright © 2016年 JuXin. All rights reserved.

//  分离跳转

#import "BHMVVMImpl.h"

@interface BHMVVMImpl()
@property (strong, nonatomic) UITabBarController *tabBarController;
@end

@implementation BHMVVMImpl

- (instancetype)initTabBarController:(UITabBarController *)tabBarController
{
    self = [super init];
    if (self)
    {
        self.tabBarController = tabBarController;
    }
    return self;
}

-(void)pushViewController:(NSString *)className
{
    id viewController = [[NSClassFromString(className) alloc] init];
    if (viewController && [viewController isKindOfClass:[UIViewController class]])
    {
        [[AppDelegate App].navigationController pushViewController:viewController animated:YES];
    }
}

@end
