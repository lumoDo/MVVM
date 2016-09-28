//
//  BHUserInfoViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/22.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHUserInfoViewController.h"
#import "BHRiskAssessmentViewController.m"

#define cellHeight (50.0 * SCREEN_PERCENT)
#define sectionHeight (6.0 * SCREEN_PERCENT)
@interface BHUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BHUserInfoViewController
{
    NSMutableArray *accountInfoArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"账户信息";
    
    UIView *headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake(8, (CGRectGetHeight(headerView.frame) - 34)/2.0, 34, 34)];
    head.image = [UIImage imageNamed:@"head"];
    [headerView addSubview:head];
    CGFloat font = 16.0;
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(head.frame) + 8, (CGRectGetHeight(headerView.frame) - font)/2.0, SCREEN_WIDTH - 20 - CGRectGetMaxX(head.frame), font)];
    userName.text = @"Plato";
    userName.font = [UIFont systemFontOfSize:font];
    userName.textColor = [UIColor blackColor];
    [headerView addSubview:userName];
    
    CGFloat tableViewBottom = 60.0 * SCREEN_PERCENT;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-tableViewBottom) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
    logout.backgroundColor = [UIColor colorForKey:kColorNaviTitle];
    [logout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logout.frame = CGRectMake(8, SCREEN_HEIGHT - tableViewBottom, SCREEN_WIDTH - 16, tableViewBottom - 8);
    [logout setTitle:@"安全退出" forState:UIControlStateNormal];
    [self.view addSubview:logout];
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"accountInfo" ofType:@"plist"];
    NSDictionary *rootDictionary = [[NSDictionary alloc] initWithContentsOfFile:plist];
    accountInfoArray = [rootDictionary objectForKey:@"accountInfo"];
    //[self setNavigationTitleView:@"账户信息" andBarTintColor:0x0C5CBE];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return accountInfoArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = accountInfoArray[section];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *array = accountInfoArray[indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    NSDictionary *dictionary = array[indexPath.row];
    NSString *title = dictionary[@"title"];
    if (title)
    {
        cell.textLabel.text = dictionary[@"title"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = accountInfoArray[indexPath.section];
    NSDictionary *dictionary = array[indexPath.row];
    NSString *string = dictionary[@"viewController"];
    if (string && string.length > 0 )
    {
       id viewController = [[NSClassFromString(string) alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
