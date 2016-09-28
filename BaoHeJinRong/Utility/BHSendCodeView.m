//
//  BHSendCodeButton.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/27.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHSendCodeView.h"
#import "MZTimerLabel.h"


@interface BHSendCodeView () <MZTimerLabelDelegate>

@end

@implementation BHSendCodeView
{
    UILabel *label;
    MZTimerLabel *timerLabel;
}
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0.0;
        make.bottom.offset = 0.0;
        make.left.offset = 0.0;
        make.right.offset = 0.0;
    }];
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"发送验证码";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0.0;
        make.bottom.offset = 0.0;
        make.left.offset = 0.0;
        make.right.offset = 0.0;
    }];
}



- (void)buttonAction
{
    if (timerLabel.counting)
    {
        return;
    }
    timerLabel = [[MZTimerLabel alloc] initWithLabel:label];
    timerLabel.timerType = MZTimerLabelTypeTimer;
    timerLabel.timeFormat = @"mm:ss";
    [timerLabel setCountDownTime:60];
    [timerLabel startWithEndingBlock:^(NSTimeInterval countTime) {
        label.text = @"重新发送";
    }];
}


@end