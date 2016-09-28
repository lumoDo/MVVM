//
//  HXErrorView
//
//  Created by HX_MAC_PRO2 on 10/10/12.
//  Copyright (c) 2012 hexun. All rights reserved.
//

#import "HXErrorView.h"

@implementation HXErrorView

@synthesize activity = _activity;
@synthesize hxLogo = _hxLogo;
@synthesize loadingLabel = _loadingLabel;
@synthesize loadingAnimation = _loadingAnimation;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        image =[UIImage imageNamed:@"error"];
        _hxLogo = [[UIImageView alloc] initWithFrame:CGRectZero];
        _hxLogo.image = image;
        
        [self addSubview:_hxLogo];
        
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _loadingLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.textColor = [UIColor colorWithRed:0.63 green:0.63 blue:0.63 alpha:1.0];
        _loadingLabel.backgroundColor = [UIColor clearColor];
        
        
        [self addSubview:_loadingLabel];
        //        activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        //        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        //        activity.hidesWhenStopped = YES;
        //        [self addSubview:activity];
        
        _loadingAnimation = [[HXLoadingAnimation alloc]initWithIndicator];
        _loadingAnimation.hidden = YES;
        [self addSubview:_loadingAnimation];
        self.hidden = YES;
        
        UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *setImg = [UIImage imageNamed:@"backGray"];
        backBtn.frame = CGRectMake(0, 20, 60, 60);
        [backBtn setImage:setImg forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(onCallBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
    }
    return self;
}

- (void) onCallBack
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(onCallBack)]){
        [self.delegate onCallBack];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    //    CGFloat activityW = 20;
    //    CGFloat activityH = 20;
    CGFloat hxLogoW = image.size.width;
    CGFloat hxLogoH = image.size.height;
    CGFloat loadingLabelH = 30;
    CGFloat loadingLabelW = bounds.size.width;
    
    CGFloat paddingX = (bounds.size.width - hxLogoW) / 2.0f;
    CGFloat paddingY = (bounds.size.height - hxLogoH) / 2.0f - loadingLabelH;
    
    
    _hxLogo.frame = CGRectMake(paddingX,
                               paddingY,
                               hxLogoW,
                               hxLogoH);
    //    activity.frame = CGRectMake((bounds.size.width-activityW) / 2.0f,
    //                                paddingY + hxLogoH+10,
    //                                activityW,
    //                                activityH);
    _loadingLabel.frame = CGRectMake(0, paddingY + hxLogoH+10, loadingLabelW, loadingLabelH);
    
}


- (void)EVstartAnimating
{
    if (self.isJSFunction == YES) {
        return;
    }
    if([self EVisAnimating])
        [_loadingAnimation stopAnimate];
    self.hidden = NO;
//    self.enabled = NO;
    _loadingAnimation.hidden = NO;
    [_loadingAnimation startAnimate];
    _loadingLabel.hidden = YES;
    _hxLogo.hidden = YES;
}

- (void)EVstopAnimating
{
    _loadingAnimation.hidden = YES;
    self.hidden = YES;
//    self.enabled = NO;
    if([self EVisAnimating])
        [_loadingAnimation stopAnimate];
    _loadingLabel.text = nil;
}

- (void)EVstopAnimatingWithError
{
    if([self EVisAnimating])
        [_loadingAnimation stopAnimate];
    _loadingLabel.text = @"页面出错啦,请点击屏幕刷新";
    _loadingLabel.hidden = NO;
    _hxLogo.hidden = NO;
    _loadingAnimation.hidden = YES;
//    self.enabled = YES;
    self.hidden=NO;
}

- (BOOL)EVisAnimating
{
    return [_loadingAnimation isAnimating];
}


@end
