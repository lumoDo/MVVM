//
//  BHRiskAssessmentTableViewCell.h
//  BaoHeJinRong
//
//  Created by Richard on 16/9/23.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHRiskAssessmentTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UIImageView *radioImageView;
- (void)setSelectedItem:(BOOL)selected;
@end