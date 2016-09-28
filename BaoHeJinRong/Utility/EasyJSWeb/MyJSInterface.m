//
//  MyJSInterface.m
//  EasyJSWebViewSample
//
//  Created by Lau Alex on 19/1/13.
//  Copyright (c) 2013 Dukeland. All rights reserved.
//

#import "MyJSInterface.h"
#import "AppDelegate.h"
@implementation MyJSInterface
@synthesize uploadStr;
- (void) test{
	NSLog(@"test called");
}
//本地上传数据
- (void) testWithParam: (NSString*) param{
	NSLog(@"test with param: %@", param);
}

- (void) testWithTwoParam: (NSString*) param AndParam2: (NSString*) param2{
	NSLog(@"test with param: %@ and param2: %@", param, param2);
}

- (void) testWithFuncParam: (EasyJSDataFunction*) param{
	NSLog(@"test with func");
	
	param.removeAfterExecute = YES;
	NSString* ret = [param executeWithParam:uploadStr];
/*    TradeView_Controller * vc=[[TradeView_Controller alloc]init];
    [[AppDelegate App].navi pushViewController:vc animated:YES];
    [vc release];*/
    
	NSLog(@"Return value from callback: %@", ret);
}

- (void) testWithFuncParam2: (EasyJSDataFunction*) param{
	NSLog(@"test with func 2 but not removing callback after invocation");
	
	param.removeAfterExecute = NO;
//	[param executeWithParam:@"data 111111"];
//	[param executeWithParam:@"data 222222"];
    
}

- (NSString*) testWithRet{
	NSString* ret = @"js";
	return ret;
}

@end
