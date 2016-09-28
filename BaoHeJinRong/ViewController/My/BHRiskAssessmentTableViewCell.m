//
//  BHRiskAssessmentTableViewCell.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/23.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHRiskAssessmentTableViewCell.h"

#define FONT_OF_SIZE            14.0
#define MARGIN_LEFT             15


@implementation BHRiskAssessmentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initViews];
    }
    return self;
}

-(void) initViews
{
    UIImage *image = [UIImage imageNamed:@"radio_false"];
    CGSize size = image.size;
    
    CGFloat originX = MARGIN_LEFT;
    CGFloat originY = (self.contentView.frame.size.height - size.height)/2;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    [self setTintColor:[UIColor blackColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    self.radioImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radio_false"] highlightedImage:[UIImage imageNamed:@"radio_true"]];
    self.radioImageView.frame = CGRectMake(originX, originY, width, height);
    self.radioImageView.backgroundColor = [UIColor clearColor];
    
    originX = CGRectGetMaxX(self.radioImageView.frame) + MARGIN_LEFT;
    originY = self.contentView.frame.origin.y;
    width = [UIScreen mainScreen].bounds.size.width - (3 * MARGIN_LEFT + self.radioImageView.frame.size.width);
    height = self.contentView.frame.size.height;
    self.questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
    self.questionLabel.font = [UIFont systemFontOfSize:FONT_OF_SIZE];
    [self.questionLabel setNumberOfLines:0];
    self.questionLabel.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.radioImageView];
    [self.contentView addSubview:self.questionLabel];
    
    UILabel *lbLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lbLine.backgroundColor = [UIColor colorForKey:kColorBackground];
    [self.contentView addSubview:lbLine];
}

/**
 选中状态
 */
- (void)setSelectedItem:(BOOL)selected
{
    if (selected)
    {
        self.radioImageView.highlighted = YES;
    } else {
        self.radioImageView.highlighted = NO;
    }
}
@end
