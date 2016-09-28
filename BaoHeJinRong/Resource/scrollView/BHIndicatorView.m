//
//  BHIndicatorView.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/27.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHIndicatorView.h"

@implementation BHIndicatorView

- (void)setIndicatorWidth:(CGFloat)indicatorWidth {
    _indicatorWidth = indicatorWidth;
    CGRect indicatorRect = self.frame;
    indicatorRect.size.width = _indicatorWidth;
    self.frame = indicatorRect;
}

+ (instancetype)initIndicatorView {
    BHIndicatorView *indicatorView = [[BHIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, kXHIndicatorViewHeight)];
    return indicatorView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorForKey:kColorNaviTitle];
    }
    return self;
}


@end
