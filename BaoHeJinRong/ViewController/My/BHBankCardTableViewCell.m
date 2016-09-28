//
//  BHBankCardTableViewCell.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/23.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHBankCardTableViewCell.h"

@implementation BHBankCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView
{
    UIImage *image = [UIImage imageNamed:@"bank"];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 8;
        make.width.offset = image.size.width;
        make.height.offset = image.size.height;
        make.centerY.equalTo(self);
    }];
    CGFloat cardNameFont = 14.0;
    UILabel *cardName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 8, self.frame.size.height/2.0 - cardNameFont - 8, SCREEN_WIDTH - CGRectGetMaxX(imageView.frame) - 8 - 8 , cardNameFont)];
    cardName.font = [UIFont systemFontOfSize:cardNameFont];
    cardName.text = @"招商银行(5841)";
    [self addSubview:cardName];
    [cardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset = 0;
        make.right.offset = 16.0;
        make.height.offset =  cardNameFont;
        make.centerY.equalTo(self).offset = - cardNameFont/2.0;
    }];
    CGFloat cardDetailFont = 10.0;
    UILabel *cardDetail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 8, self.frame.size.height/2.0 + 8, SCREEN_WIDTH - CGRectGetMaxX(imageView.frame) - 8 - 8 , cardDetailFont)];
    cardDetail.font = [UIFont systemFontOfSize:cardDetailFont];
    cardDetail.text = @"单笔5万,每日20万,银行客户热线:95555";
    [self addSubview:cardDetail];
    [cardDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset = 0;
        make.right.offset = 16.0;
        make.height.offset =  cardDetailFont;
        make.centerY.equalTo(self).offset = cardDetailFont/2.0+4;
    }];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
