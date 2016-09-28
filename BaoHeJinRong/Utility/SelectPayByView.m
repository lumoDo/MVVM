//
//  SelectPayByView.m
//  HeXunRongHeJinFu
//
//  Created by 祝敏彧 on 16/2/4.
//  Copyright © 2016年 庄小宁. All rights reserved.
//

#import "SelectPayByView.h"


#define BANKBTNTAG 8888
@interface SelectPayByView () {
    NSString *bankName;
    NSString *bankCode;
}

@end

@implementation SelectPayByView

@synthesize selectDelegate = _selectDelegate;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SelectBankCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSUInteger cellRow = [indexPath row];
    if (cellRow == 0) {
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setTitle:@"返回" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.frame=CGRectMake(5, 5, 30, 30);
        closeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:closeBtn];
        
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, 30)];
        titleLbl.text = @"选择支付方式";
        titleLbl.textAlignment = NSTextAlignmentCenter;
        titleLbl.textColor = [UIColor darkGrayColor];
        titleLbl.font = [UIFont systemFontOfSize:18];
        [cell.contentView addSubview:titleLbl];
    }
    else if (cellRow == 4) {
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 40, 30)];
        titleLbl.text = @"使用新卡付款";
        titleLbl.textAlignment = NSTextAlignmentLeft;
        titleLbl.textColor = [UIColor darkGrayColor];
        titleLbl.font = [UIFont systemFontOfSize:18];
        [cell.contentView addSubview:titleLbl];
    }
    else {
        if (cellRow == 3) {
            UILabel *zhyeLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2, 30)];
            zhyeLbl.text = @"账户余额(元):88.88";
            zhyeLbl.textAlignment = NSTextAlignmentLeft;
            zhyeLbl.textColor = [UIColor darkGrayColor];
            zhyeLbl.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:zhyeLbl];
            
            UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [selectBtn setTitle:@"选择" forState:UIControlStateSelected];
            [selectBtn setTitle:@"" forState:UIControlStateNormal];
            [selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            selectBtn.frame=CGRectMake(SCREEN_WIDTH - 40, 5, 30, 30);
            selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            selectBtn.selected = YES;
            [cell.contentView addSubview:selectBtn];
        }
        else {
            UIImageView *bankImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
            bankImgView.image = [UIImage imageNamed:@"icon-58"];
            bankImgView.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:bankImgView];
            
            UILabel *bankNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(bankImgView.frame.origin.x + bankImgView.frame.size.width + 5, 10, SCREEN_WIDTH/2, 30)];
            bankNameLbl.text = [NSString stringWithFormat:@"XX银行(%d)",(int)cellRow+6666];
            bankNameLbl.textAlignment = NSTextAlignmentLeft;
            bankNameLbl.textColor = [UIColor darkGrayColor];
            bankNameLbl.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:bankNameLbl];
            
            UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [selectBtn setTitle:@"选择" forState:UIControlStateSelected];
            [selectBtn setTitle:@"" forState:UIControlStateNormal];
            [selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            selectBtn.frame=CGRectMake(SCREEN_WIDTH - 40, 5, 30, 30);
            selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            selectBtn.tag = (int)(cellRow + BANKBTNTAG);
            selectBtn.selected = ((int)cellRow == 1?YES:NO);
            [cell.contentView addSubview:selectBtn];
        }
    }
    
    
    return cell;
}

- (void)onClose {
    if (_selectDelegate != nil && [_selectDelegate respondsToSelector:@selector(SelectBankName:andBankCode:)]) {
        [_selectDelegate SelectBankName:@"中国银行" andBankCode:@"8888"];
    }    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger cellRow = [indexPath row];
    if (cellRow == 4) {
        CLog(@"绑定新卡");
    }
    else if (cellRow == 3) {
        
    }
    else {
        for (int i = 1; i < 3; i++) {
            UITableViewCell *cell = [tableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:[indexPath section]]];
            UIButton *selectBtn = (UIButton *)[cell.contentView viewWithTag:i + BANKBTNTAG];
            selectBtn.selected = (cellRow == i ? YES:NO);
        }
    }
}

@end
