//
//  BHMessageCenterViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/26.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHMessageCenterViewController.h"
#import "BHMessageCenterTableViewCell.h"
#define cellHeight 80.0

@interface BHMessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *messageCenterTableView;

@end

@implementation BHMessageCenterViewController
{
    BOOL isRead;
}
static NSString *identifier = @"BHMessageCenterTableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息中心";
    [self buildRightBarButtonWithTitle:@"全部标为已读"];
    self.messageCenterTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.messageCenterTableView.backgroundColor = [UIColor colorForKey:kColorBackground];
    self.messageCenterTableView.delegate = self;
    self.messageCenterTableView.dataSource= self;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
    self.messageCenterTableView.tableFooterView = footView;
    [self.view addSubview:self.messageCenterTableView];
    // Do any additional setup after loading the view.
}

- (void)rightBarButtonAction:(UIButton *)button
{
    isRead = !isRead;
    [self.messageCenterTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BHMessageCenterTableViewCell *cell = [[BHMessageCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    [cell messageRead:isRead];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

@end
