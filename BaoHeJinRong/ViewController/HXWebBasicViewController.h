//
//  HXWebBasicViewController.h
//  HeXunRongHeJinFu
//
//  Created by 庄小宁 on 15/12/5.
//  Copyright © 2015年 庄小宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXErrorView.h"
#import "EasyJSWebView.h"
#import "UMSocialControllerService.h"
#import "MyJSTest.h"
#import "HXBasicViewController.h"
#import "PCCircleViewConst.h"

@class HXWebBasicViewController;
//@protocol HXWebLoginVcDelegate  <NSObject>
//@optional
//-(void)HXWebLoginSuccess:(HXWebBasicViewController *)HXWebLoginVC;
//
//-(void)HXWebLogoutSuccess:(HXWebBasicViewController *)HXWebLoginVC;
//@end

@interface HXWebBasicViewController : HXBasicViewController<UMSocialUIDelegate,MyJSTestDelegate,UIWebViewDelegate,HXErrorViewDelegate,UIAlertViewDelegate>{
    NSString *tel;
}
@property (nonatomic, strong) EasyJSWebView* myWebView;
@property (nonatomic, strong) MyJSTest* mySetting;
@property (nonatomic, strong) HXErrorView *errorView;
@property (nonatomic, strong) UIButton *backBtn;

- (void)makeTelephone:(NSString *)telephoneNum;
- (NSString *)setTelephoneNum:(NSString *)phoneNum;
- (void)UMShreWithText:(NSString *)shareText andShareImage:(UIImage *)shareImage andTitle:(NSString *)title andShareUrl:(NSString *)shareUrl;
- (void)startRequest:(UIButton *)btn;
-(UIImage *) getImageFromURL:(NSString *)fileURL;
@end
