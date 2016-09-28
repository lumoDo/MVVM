//
//  HXLoadingAnimation.h
//  JQIndicatorViewDemo
//
//  Created by 祝敏彧 on 16/1/12.
//  Copyright © 2016年 JQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HXLoadingAnimation : UIView

@property CALayer *spotLayer;
@property UILabel *loadingLbl;
@property BOOL    isAnimating;

- (instancetype)initWithIndicator;
/**
 *  开始动画
 */
-(void)startAnimate;


/**
 *  结束动画
 */
-(void)stopAnimate;
@end
