//
//  BHMVVMImpl.h
//  BaoHeJinRong
//
//  Created by Richard on 16/9/21.
//  Copyright © 2016年 JuXin. All rights reserved.

//  分离跳转

#import <Foundation/Foundation.h>

@interface BHMVVMImpl : NSObject<BHMVVMService>

- (instancetype)initTabBarController:(UITabBarController *)tabBarController;

@end
