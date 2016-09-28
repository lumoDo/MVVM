//
//  BHMyViewModel.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/22.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHMyViewModel.h"
@interface BHMyViewModel ()

@property (weak, nonatomic) id<BHMVVMService> service;

@end

@implementation BHMyViewModel


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.service = (id)[AppDelegate App].impl;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    WS;
    self.excuteSignal = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input)
    {
        return [weakSelf executeSearchSignal:input];
    }];
}

-(RACSignal *)executeSearchSignal:(id)input
{
    WS;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
    {
        NSString *vc = @"BHUserInfoViewController";
        if ([input isKindOfClass:[UIButton class]])
        {
            UIButton *button = input;
            NSString *path = [[NSBundle mainBundle] pathForResource:@"myVC" ofType:@"plist"];
            NSArray *array = [NSArray arrayWithContentsOfFile:path];
            if (button.tag < array.count)
            {
                NSDictionary *dictionary = array[button.tag];
                vc =  dictionary[@"viewController"];
            }
        }
        else if ([input isKindOfClass:[NSString class]])
        {
            if ([input isEqualToString:@"充值"])
            {
                vc = @"BHChargeViewController";
            }else if ([input isEqualToString:@"提现"])
            {
                vc = @"BHGetViewController";
            }else
            {
                vc = nil;
            }
        }
        if (vc && vc.length > 0)
        {
            [weakSelf.service pushViewController:vc];
        }
        [subscriber sendCompleted];
        return nil;
    }];
}

@end
