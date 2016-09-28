//
//  HXLoadingAnimation.m
//  JQIndicatorViewDemo
//
//  Created by 祝敏彧 on 16/1/12.
//  Copyright © 2016年 JQ. All rights reserved.
//

#import "HXLoadingAnimation.h"
#define IndicatorAnimationDuration 0.8
#define IndicatorNumOfDot 3
#define IndicatorDefaultSize CGSizeMake(60,60)

@implementation HXLoadingAnimation
@synthesize spotLayer = _spotLayer;
@synthesize loadingLbl = _loadingLbl;

- (instancetype)initWithIndicator{
    if (self = [super init]) {
//        [self creatAnimation];
    }
    return self;
}


- (void)creatAnimation {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame = CGRectMake((SCREEN_WIDTH - IndicatorDefaultSize.width)/2 - 3,(SCREEN_HEIGHT - IndicatorDefaultSize.height)/2, IndicatorDefaultSize.width, IndicatorDefaultSize.height);
        replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:replicatorLayer];
        [self addCyclingSpotAnimationLayerAtLayer:replicatorLayer withTintColor:UIColorFromRGB(0x0fa7ff) size:IndicatorDefaultSize];
        
        replicatorLayer.instanceCount = IndicatorNumOfDot;
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(IndicatorDefaultSize.width/4, 0, 0);
        replicatorLayer.instanceDelay = IndicatorAnimationDuration/IndicatorNumOfDot;
        self.loadingLbl = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - IndicatorDefaultSize.width)/2,(SCREEN_HEIGHT - IndicatorDefaultSize.height)/2 + 5, IndicatorDefaultSize.width, IndicatorDefaultSize.height/2)];
        self.loadingLbl.text = @"加载中";
        self.loadingLbl.font = [UIFont systemFontOfSize:12.0f];
        self.loadingLbl.textColor = [UIColor blackColor];
        self.loadingLbl.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        self.loadingLbl.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.loadingLbl.backgroundColor = [UIColor clearColor];
        self.loadingLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.loadingLbl];
}

- (void)addCyclingSpotAnimationLayerAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{

    CGFloat radius = size.width/5;
    self.spotLayer = [CALayer layer];
    self.spotLayer.bounds = CGRectMake(0, 0, radius, radius);
    self.spotLayer.position = CGPointMake(size.width/2 - radius, 0);
    self.spotLayer.cornerRadius = radius/2;
    self.spotLayer.backgroundColor = color.CGColor;
    self.spotLayer.transform = CATransform3DMakeScale(0.2, 0.2, 0.2);
    
    [layer addSublayer:self.spotLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @0.2;
    animation.toValue = @1;
    animation.duration = IndicatorAnimationDuration;
    animation.autoreverses = YES;
    animation.repeatCount = CGFLOAT_MAX;
    animation.removedOnCompletion = NO;
    
    [self.spotLayer addAnimation:animation forKey:@"animation"];
}

- (void)removeAnimation{
    [self.spotLayer removeAnimationForKey:@"animation"];
}

- (void)startAnimate
{
    if (self.isAnimating) {
        [self stopAnimate];
    }
    _isAnimating = YES;
    [self creatAnimation];
}


- (void)stopAnimate
{
    _isAnimating = NO;
    [self removeAnimation];

}


@end
