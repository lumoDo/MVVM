//
//  BHBankCardViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/23.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHBankCardViewController.h"
#import "BHBankCardTableViewCell.h"
#import "BHBindCardViewController.h"

#define cellHeight 80.0

@interface BHBankCardViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *cardTableView;
@end

@implementation BHBankCardViewController
{
    NSInteger count;
}
static NSString *identifier = @"BHBankCardTableViewCell";
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    count = 2;
    self.title = @"银行卡";
    self.view.backgroundColor = [UIColor whiteColor];
    self.cardTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.cardTableView.dataSource = self;
    self.cardTableView.delegate = self;
    self.cardTableView.backgroundColor = [UIColor colorForKey:kColorBackground];
    [self.view addSubview:self.cardTableView];
    [self setTableFootViewWithNumber:count];
    // Do any additional setup after loading the view.
}

#pragma mark -


- (void)tapAction:(UITapGestureRecognizer *)gesture
{
    BHBindCardViewController *bindCardViewController = [[BHBindCardViewController alloc] init];
    [self.navigationController pushViewController:bindCardViewController animated:YES];
}

- (void)setTableFootViewWithNumber:(NSInteger)number
{
    if (number == 0)
    {
        self.cardTableView.tableFooterView = [self createTableFootView];
    }
    else
    {
        self.cardTableView.tableFooterView = nil;
    }
}


- (UIView *)createSectionFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellHeight)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [footView addGestureRecognizer:tap];
    footView.backgroundColor = [UIColor whiteColor];
    CGFloat font = 14.0;
    UILabel *addCardLabel = [[UILabel alloc] init];
    addCardLabel.text = @"添加银行卡";
    addCardLabel.font = [UIFont systemFontOfSize:font];
    [footView addSubview:addCardLabel];
    [addCardLabel sizeToFit];
    addCardLabel.center = footView.center;
    return footView;
}


- (UIView *)createTableFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellHeight)];
    footView.backgroundColor = [UIColor whiteColor];
    CGFloat font = 14.0;
    UILabel *addCardLabel = [[UILabel alloc] init];
    addCardLabel.text = @"您尚未添加任何银行卡";
    addCardLabel.font = [UIFont systemFontOfSize:font];
    [footView addSubview:addCardLabel];
    [addCardLabel sizeToFit];
    addCardLabel.center = footView.center;
    return footView;
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return  [self createSectionFootView];;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BHBankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[BHBankCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


@end
