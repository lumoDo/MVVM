//
//  BHHelpCenterViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/26.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHHelpCenterViewController.h"

#import "BHMenu.h"
#import "BHScrollMenu.h"

@interface BHHelpCenterViewController ()<UIScrollViewDelegate,BHScrollMenuDelegate>

@end

@implementation BHHelpCenterViewController
{
    UIScrollView *_scrollView;
    BHScrollMenu *_scrollMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController setNavigationBarHidden:YES];
    self.title = @"帮助中心";
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self createScrollView];
}

- (void)createScrollView
{
    //顶部滑动按钮区域
    _scrollMenu = [[BHScrollMenu alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 40)];
    _scrollMenu.delegate = self;
    _scrollMenu.selectedIndex = 0;
    [self.view addSubview:_scrollMenu];
    //底部滑动视图区域
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    NSMutableArray *menus = [NSMutableArray array];
    for (int i = 0; i <= 5 ; i ++)
    {
        BHMenu *menu = [[BHMenu alloc] init];
        
        NSString *title = nil;
        switch (i) {
            case 0:
                title = @"宝和";
                break;
            case 1:
                title = @"账户";
                break;
            case 2:
                title = @"银行卡";
                break;
            case 3:
                title = @"灵活宝";
                break;
            case 4:
                title = @"定期";
                break;
            case 5:
                title = @"债权";
                break;
        }
        menu.title = title;
        menu.titleSelectedColor = [UIColor colorForKey:kColorNaviTitle];
        menu.titleNormalColor = [UIColor lightGrayColor];
        menu.titleFont = [UIFont systemFontOfSize:14.0];
        [menus addObject:menu];
        
        UITableView *fundTabelV = [[UITableView alloc] initWithFrame:self.view.frame];
        //        fundTabelV.delegate = self;
        //        fundTabelV.dataSource = self;
        fundTabelV.separatorStyle = UITextBorderStyleNone;
        fundTabelV.tag = i;
        [_scrollView addSubview:fundTabelV];
    }
    _scrollMenu.menus = menus;
    [_scrollMenu reloadData];
    [_scrollView setContentSize:CGSizeMake(menus.count * CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds))];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        //每页宽度
        CGFloat pageWidth = scrollView.frame.size.width;
        //根据当前的坐标与页宽计算当前页码
        int currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
        
        [_scrollMenu setSelectedIndex:currentPage animated:YES calledDelegate:YES];
    }
    
}
#pragma mark - XHScrollMenuDelegate
- (void)scrollMenuDidSelected:(BHScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex {
    
    NSLog(@"selectIndex : %ld", (unsigned long)selectIndex);
    [scrollMenu.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [((UIButton *)obj) setSelected:NO];
        }
    }];
    [scrollMenu menuButtonAtIndex:selectIndex].selected = YES;
    
    
    [self menuSelectedIndex:selectIndex];
}

- (void)scrollMenuDidManagerSelected:(BHScrollMenu *)scrollMenu {
    NSLog(@"scrollMenuDidManagerSelected");
}

- (void)menuSelectedIndex:(NSUInteger)index
{
    CGRect visibleRect = CGRectMake(index * CGRectGetWidth(_scrollView.bounds), 0, CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_scrollView scrollRectToVisible:visibleRect animated:NO];
    } completion:^(BOOL finished) {
        
        
        
    }];
}

@end
