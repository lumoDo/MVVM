//
//  BHMVVMService.h
//  BaoHeJinRong
//
//  Created by Richard on 16/9/22.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BHMVVMService <NSObject>
-(void)pushViewController:(NSString *)className;
@end
