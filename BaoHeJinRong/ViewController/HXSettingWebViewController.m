//
//  HXSettingWebViewController.m
//  HeXunRongHeJinFu
//
//  Created by 庄小宁 on 15/12/10.
//  Copyright © 2015年 庄小宁. All rights reserved.
//  不需要手势验证的H5

#import "HXSettingWebViewController.h"
#import "SBJsonParser.h"

@interface HXSettingWebViewController ()

@end

@implementation HXSettingWebViewController

- (id)initWithUrl:(NSString *)url{
    
    self = [super init];
    
    if (self) {
        self.loadUrl = [NSURL URLWithString:url];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [AppDelegate App].isCurrentVC = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myWebView.frame = CGRectMake(0,20, SCREEN_WIDTH, SCREEN_HEIGHT-20);
//    self.myWebView.scalesPageToFit = YES;
//    self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:_loadUrl cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:WEBVIEW_TIMEOUT]];
    
    self.view.userInteractionEnabled = YES;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    CLog(@"HXSettingWebViewController -> %@",request.URL.absoluteString);
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"onSetKnowChannel('RHJF_APP_IOS_KC');"];
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"onSetAppVersion('2');"];
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [self.errorView performSelectorOnMainThread:@selector(EVstopAnimating) withObject:nil waitUntilDone:YES];
    [self.errorView setHidden:YES];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    CLog(@"load page error:%@", [error description]);
    if (error.code == NSURLErrorCancelled) {
        return;
    }
    [self.errorView performSelectorOnMainThread:@selector(EVstopAnimatingWithError) withObject:nil waitUntilDone:YES];
    [self.errorView setHidden:NO];
    
}
- (void)startRequest:(UIButton *)btn{
    
    [self.errorView performSelectorOnMainThread:@selector(EVstartAnimating) withObject:nil waitUntilDone:YES];
    [self.myWebView stopLoading];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:_loadUrl cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:WEBVIEW_TIMEOUT]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
