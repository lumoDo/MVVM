//
//  BHBasicViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/26.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHBasicViewController.h"

@interface BHBasicViewController ()

@end

@implementation BHBasicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildLeftBarButtonItem];
    // Do any additional setup after loading the view.
}

- (void)setTitle:(NSString *)title
{
    
    self.navigationItem.titleView = [self createTitleLabel:title];
}


- (UILabel *)createTitleLabel:(NSString *)title
{
    //计算一段文本的尺寸大小
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:CHANGGUI size:18]};
    CGSize labelsize = [title boundingRectWithSize:CGSizeMake(100, 0) options: NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelsize.width, labelsize.height)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:CUTI size:18.0];
    //    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5]; //浮雕效果8
    label.textColor = [UIColor whiteColor]; // change this color
    label.text = NSLocalizedString(title, @"");
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildRightBarButtonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:item];
}



- (void)buildLeftBarButtonItem
{
    UIImage *image = [UIImage imageNamed:@"backItem"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(0, 0,image.size.width, image.size.height);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:item];
}

#pragma mark - TBNVC

- (void)setTBNVCTitle:(NSString *)title
{
    self.tabBarController.navigationItem.titleView = [self createTitleLabel:title];
}

- (void)setTBNVCLeftBarButton
{
    //UIImage *image = [UIImage imageNamed:@"backItem"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //button.frame=CGRectMake(0, 0,image.size.width, image.size.height);
    button.frame=CGRectMake(0, 0,40, 40);
    [button setTitle:@"更多" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.tabBarController.navigationItem setLeftBarButtonItem:item];
}

#pragma mark - Action

- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonAction:(UIButton *)button
{
    
    
}

- (void)leftBarButtonAction:(UIButton *)button
{
   
}


@end
