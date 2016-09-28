//
//  BHMessageCenterTableViewCell.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/26.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHMessageCenterTableViewCell.h"
@interface BHMessageCenterTableViewCell()

@property (nonatomic, strong) UIView *pointView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *cardName;

@end

@implementation BHMessageCenterTableViewCell
{
    CGFloat timeLabelFont;
    CGFloat timeLabelWidth;
    CGFloat cardNameFont;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
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
    timeLabelFont = 15.0 * SCREEN_PERCENT;
    timeLabelWidth = 160.0 * SCREEN_PERCENT;
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"2016-08-12 16:16:36";
    self.timeLabel.font = [UIFont systemFontOfSize:timeLabelFont];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self).offset = - timeLabelFont/2.0;
       make.right.offset = -8;
       make.height.offset = timeLabelFont;
       make.width.offset = timeLabelWidth;
    }];
    
    cardNameFont = 15.0 * SCREEN_PERCENT;
    self.pointView = [[UIView alloc] init];
    self.pointView.backgroundColor = [UIColor redColor];
    self.pointView.layer.cornerRadius = cardNameFont/2.0;
    [self addSubview:self.pointView];
    [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 8;
        make.width.offset = cardNameFont;
        make.height.offset =  cardNameFont;
        make.centerY.equalTo(self).offset = - cardNameFont/2.0;

    }];
    self.cardName = [[UILabel alloc] initWithFrame:CGRectMake( 8, self.frame.size.height/2.0 - cardNameFont - 8, SCREEN_WIDTH  - 8 - 8 , cardNameFont)];
    self.cardName.font = [UIFont systemFontOfSize:cardNameFont];
    self.cardName.text = @"注册获取红包";
    [self addSubview:self.cardName];
    [self.cardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pointView.mas_right).offset = 8;
        make.right.equalTo(self.timeLabel).offset = -8;
        make.height.offset =  cardNameFont;
        make.centerY.equalTo(self).offset = - cardNameFont/2.0;
    }];
    CGFloat cardDetailFont = 15.0 *SCREEN_PERCENT;
    UILabel *cardDetail = [[UILabel alloc] initWithFrame:CGRectMake(8, self.frame.size.height/2.0 + 8, SCREEN_WIDTH  - 8 - 8 , cardDetailFont)];
    cardDetail.font = [UIFont systemFontOfSize:cardDetailFont];
    cardDetail.text = @"恭喜您获得68元红包,恭喜您获得68元红包,宝和金融宝和金融";
    [self addSubview:cardDetail];
    [cardDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 8.0;
        make.right.offset = -8.0;
        make.height.offset =  cardDetailFont;
        make.centerY.equalTo(self).offset = cardDetailFont/2.0+4;
    }];

}

- (void)messageRead:(BOOL)isread
{
    self.pointView.hidden = isread;
    [self.pointView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 8;
        if (isread)
        {
            make.width.offset = 0;
            make.height.offset =  0;
        }else
        {
            make.width.offset = cardNameFont;
            make.height.offset =  cardNameFont;
        }
        
        make.centerY.equalTo(self).offset = - cardNameFont/2.0;
        
    }];
    [self.cardName mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (isread)
        {
           make.left.equalTo(self.pointView.mas_right).offset = 0;
        }else
        {
            make.left.equalTo(self.pointView.mas_right).offset = 8;
        }
        make.right.equalTo(self.timeLabel).offset = -8;
        make.height.offset =  cardNameFont;
        make.centerY.equalTo(self).offset = - cardNameFont/2.0;
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
