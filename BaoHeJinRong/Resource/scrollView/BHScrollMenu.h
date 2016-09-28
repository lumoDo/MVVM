//
//  BHMenuButton.h
//  BaoHeJinRong
//
//  Created by Richard on 16/9/27.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHIndicatorView.h"
#import "BHMenu.h"
#import "BHMenuButton.h"

#define kXHMenuButtonPaddingX 30
#define kXHMenuButtonStarX 8

@class BHScrollMenu;

@protocol BHScrollMenuDelegate <NSObject>

- (void)scrollMenuDidSelected:(BHScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex;
- (void)scrollMenuDidManagerSelected:(BHScrollMenu *)scrollMenu;

@end

@interface BHScrollMenu : UIView

@property (nonatomic, assign) id <BHScrollMenuDelegate> delegate;

// UI
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) BHIndicatorView *indicatorView;

// DataSource
@property (nonatomic, strong) NSArray *menus;

// select
@property (nonatomic, assign) NSUInteger selectedIndex; // default is 0

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate;

- (CGRect)rectForSelectedItemAtIndex:(NSUInteger)index;

- (BHMenuButton *)menuButtonAtIndex:(NSUInteger)index;

// reload dataSource
- (void)reloadData;

@end
