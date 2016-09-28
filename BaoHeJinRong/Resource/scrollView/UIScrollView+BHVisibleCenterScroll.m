//
//  UIScrollView+BHVisibleCenterScroll.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/27.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "UIScrollView+BHVisibleCenterScroll.h"

@implementation UIScrollView (BHVisibleCenterScroll)
- (void)scrollRectToVisibleCenteredOn:(CGRect)visibleRect
                             animated:(BOOL)animated {
    CGRect centeredRect = CGRectMake(visibleRect.origin.x + visibleRect.size.width/2.0 - self.frame.size.width/2.0,
                                     visibleRect.origin.y + visibleRect.size.height/2.0 - self.frame.size.height/2.0,
                                     self.frame.size.width,
                                     self.frame.size.height);
    [self scrollRectToVisible:centeredRect
                     animated:animated];
}
@end
