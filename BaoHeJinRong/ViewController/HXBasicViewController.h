//
//  HXBasicViewController.h
//  HeXunRongHeJinFu
//
//  Created by 庄小宁 on 15/12/18.
//  Copyright © 2015年 庄小宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureViewController.h"
#import "GestureVerifyViewController.h"
@interface HXBasicViewController : UIViewController<GestureViewControllerDelegate,GestureVerifyViewControllerDelegate>
//@property (nonatomic)NSDictionary *userDic;
- (void)setNavigationTitleView:(NSString *)title andBarTintColor:(int)rgb;
- (UIBarButtonItem *)buildLeftBarButtonItem;
- (UIBarButtonItem *)buildRightBarButtonItem;
- (void)removeNavigationBarBlackImageView;
- (void)gestureLoginSuccess:(NSInteger)vcTag;
- (void)checkGesturePassword:(NSInteger)vcTag;
- (void)openGessture;
-(void)showTips:(NSString *)message;
//- (void)loginOut;
@end
