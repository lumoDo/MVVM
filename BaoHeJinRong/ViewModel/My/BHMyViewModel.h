//
//  BHMyViewModel.h
//  BaoHeJinRong
//
//  Created by Richard on 16/9/22.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHMyViewModel : NSObject
@property (strong, nonatomic) RACCommand *excuteSignal;
@property (strong, nonatomic) NSMutableArray *buttonSignalArray;
@end
