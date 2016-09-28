//
//  BHBasicViewController.h
//  BaoHeJinRong
//
//  Created by Richard on 16/9/26.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHBasicViewController : UIViewController

/**
 *  创建右边导航栏按钮
 *
 *  @param title 按钮了标题
 */
- (void)buildRightBarButtonWithTitle:(NSString *)title;
/**
 *  右边导航栏按钮方法
 *
 *  @param button 
 */
- (void)rightBarButtonAction:(UIButton *)button;
/**
 *  设置tabbar控制器的导航栏标题
 *
 *  @param title
 */
- (void)setTBNVCTitle:(NSString *)title;
- (void)setTBNVCLeftBarButton;
@end
