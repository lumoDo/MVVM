//
//  HXErrorView
//
//  Created by HX_MAC_PRO2 on 10/10/12.
//  Copyright (c) 2012 hexun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXLoadingAnimation.h"

@class HXErrorView;

@protocol HXErrorViewDelegate <NSObject>

- (void) onCallBack;

@end

@interface HXErrorView : UIButton {
  
    UIImage                     *image;
    BOOL                        isHaveBackBtn;
}
@property(nonatomic,assign) id <HXErrorViewDelegate> delegate;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) HXLoadingAnimation      *loadingAnimation;
@property (nonatomic, strong) UIImageView *hxLogo;
@property (nonatomic, strong) UILabel   *loadingLabel;
@property (nonatomic) BOOL isJSFunction;
- (void)EVstartAnimating;

- (void)EVstopAnimating;

- (void)EVstopAnimatingWithError;

- (BOOL)EVisAnimating;


@end
