//
//  BHRiskAssessmentView.h
//  BaoHeJinRong
//
//  Created by Richard on 16/9/23.
//  Copyright © 2016年 JuXin. All rights reserved.
//


#import <UIKit/UIKit.h>
@class BHRiskAssessmentView;
@protocol BHRiskAssessmentViewDelegate <NSObject>

@optional
-(void)goBack;

@required
/**
 *  提交问卷
 *
 *  @param answerArray  答案数组
 */
- (void)submitRiskAssessmentWithAnswerArray:(NSMutableArray *)answerArray;

@end

@interface BHRiskAssessmentView : UIView

@property id<BHRiskAssessmentViewDelegate>delegate;

@end
