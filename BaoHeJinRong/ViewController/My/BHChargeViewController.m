//
//  BHChargeViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/27.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHChargeViewController.h"
#import "BHSendCodeView.h"

#define chargeFont 14.0
#define chargeLeft 100.0



@interface BHChargeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BHChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"充值";
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50 + 10)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(12, 10, SCREEN_WIDTH - 24, 50);
    button.backgroundColor = [UIColor colorForKey:kColorNaviTitle];
    [button setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"立即充值" forState:UIControlStateNormal];
    [footView addSubview:button];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = footView;
    [self.view addSubview:tableView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:chargeFont];
    cell.textLabel.textColor = [UIColor blackColor];
    switch (indexPath.section)
    {
        case 0:
        {
            cell.textLabel.text = @"账户余额";
            cell.textLabel.textColor = [UIColor lightGrayColor];
            UILabel *money = [[UILabel alloc] init];
            money.textAlignment = NSTextAlignmentRight;
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"1000.00元"];
            NSRange range;
            range.length = attributedString.string.length - 1;
            range.location = 0;
            [attributedString addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] range:range];
            money.attributedText = attributedString;
            [cell addSubview:money];
            [money mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset = - 16.0;
                make.centerY.equalTo(cell).offset = 0;
                make.height.offset = chargeFont;
                make.width.offset = 100;
            }];
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"";
            UIImage *image = [UIImage imageNamed:@"bank"];
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = image;
            [cell addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset = 16.0;
                make.centerY.equalTo(cell).offset = 0.0;
                make.width.offset = image.size.width;
                make.height.offset = image.size.height;
            }];
            UILabel *cardName = [[UILabel alloc] init];
            cardName.text = @"招商银行(5841)";
            cardName.font = [UIFont systemFontOfSize:chargeFont];
            [cell addSubview:cardName];
            [cardName mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageView.mas_right).offset = 0.0;
                make.centerY.equalTo(cell).offset = 0.0;
                make.right.offset = 0.0;
                make.height.offset = chargeFont;
            }];
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"金额(元)";
            UITextField *textField = [[UITextField alloc] init];
            textField.placeholder = @"最低为100元";
            textField.font = [UIFont systemFontOfSize:chargeFont];
            [cell addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset = chargeLeft;
                make.centerY.equalTo(cell).offset = 0;
                make.height.offset = chargeFont;
                make.right.offset = 0.0;
            }];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"手续费";
            UILabel *money = [[UILabel alloc] init];
            money.textAlignment = NSTextAlignmentLeft;
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"3.00元"];
            NSRange range;
            range.length = attributedString.string.length - 1;
            range.location = 0;
            [attributedString addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] range:range];
            money.attributedText = attributedString;
            [cell addSubview:money];
            [money mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset = chargeLeft;
                make.centerY.equalTo(cell).offset = 0;
                make.height.offset = chargeFont;
                make.right.offset = 0.0;
            }];
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"实际到账";
            UILabel *money = [[UILabel alloc] init];
            money.textAlignment = NSTextAlignmentLeft;
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"97.00元"];
            NSRange range;
            range.length = attributedString.string.length - 1;
            range.location = 0;
            [attributedString addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] range:range];
            money.attributedText = attributedString;
            [cell addSubview:money];
            [money mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset = chargeLeft;
                make.centerY.equalTo(cell).offset = 0;
                make.height.offset = chargeFont;
                make.right.offset = 0.0;
            }];
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"验证码";
            BHSendCodeView *mybutton = [[BHSendCodeView alloc] init];
            [cell addSubview:mybutton];
            [mybutton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset = 0.0;
                make.top.offset = 0.0;
                make.bottom.offset = 0.0;
                make.width.offset = 100.0;
            }];
            UITextField *textField = [[UITextField alloc] init];
            textField.placeholder = @"请输入短信验证码";
            textField.font = [UIFont systemFontOfSize:chargeFont];
            [cell addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset = chargeLeft;
                make.centerY.equalTo(cell).offset = 0;
                make.height.offset = chargeFont;
                make.right.equalTo(mybutton.mas_left).offset = 0.0;
            }];
        }
            break;
        case 6:
        {
            cell.textLabel.text = @"交易密码";
            UITextField *textField = [[UITextField alloc] init];
            textField.placeholder = @"请输入交易密码";
            textField.font = [UIFont systemFontOfSize:chargeFont];
            [cell addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset = chargeLeft;
                make.centerY.equalTo(cell).offset = 0;
                make.height.offset = chargeFont;
                make.right.offset = 0.0;
            }];
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 50.0;
    }
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"单笔限额20万,每日限额50万";
        label.font = [UIFont systemFontOfSize:14.0];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset = 0.0;
            make.bottom.offset = 0.0;
            make.left.offset = 16.0;
            make.right.offset = 0.0;
        }];
        return view;
    }
    else
    {
        return nil;
    }
}

@end
