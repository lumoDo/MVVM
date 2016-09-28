//
//  BHSecurityViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/23.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHSecurityViewController.h"

@interface BHSecurityViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BHSecurityViewController
{
    NSMutableArray *security;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"账户安全";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"security" ofType:@"plist"];
    security = [[NSMutableArray alloc] initWithContentsOfFile:plist];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return security.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = security[section];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *array = security[indexPath.section];
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
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = security[indexPath.section];
    NSDictionary *dictionary = array[indexPath.row];
    NSString *string = dictionary[@"viewController"];
    if (string && string.length > 0)
    {
        id viewController = [[NSClassFromString(string) alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
@end
