//
//  HXSettingWebViewController.h
//  HeXunRongHeJinFu
//
//  Created by 庄小宁 on 15/12/10.
//  Copyright © 2015年 庄小宁. All rights reserved.
//

#import "HXWebBasicViewController.h"

@interface HXSettingWebViewController : HXWebBasicViewController
@property (nonatomic, strong) NSURL *loadUrl;
- (id)initWithUrl:(NSString *)url;
@end
