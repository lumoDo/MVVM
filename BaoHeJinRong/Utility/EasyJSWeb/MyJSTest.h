//
//  MyTest.h
//  HeXunRongHeJinFu
//
//  Created by 庄小宁 on 15/12/29.
//  Copyright © 2015年 庄小宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol MyJSTestDelegate<JSExport>
- (void)JSWithType:(NSString*)type AndJsonString:(NSString *)string;
@end

@interface MyJSTest : NSObject<MyJSTestDelegate>
@property (nonatomic, assign) id<MyJSTestDelegate> delegate;
@end
