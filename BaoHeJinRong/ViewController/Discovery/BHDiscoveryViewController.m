//
//  BHDiscoveryViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/21.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHDiscoveryViewController.h"
#import <WebKit/WebKit.h>

@interface BHDiscoveryViewController ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation BHDiscoveryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem* fristItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"tabBarImage_three_on"] tag:2];
        fristItem.selectedImage = [[UIImage imageNamed:@"tabBarImage_three_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        fristItem.image = [[UIImage imageNamed:@"tabBarImage_three_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = fristItem;
    }
    return self;
}

+ (instancetype)shareInstance
{
    static BHDiscoveryViewController *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    webView.backgroundColor = [UIColor colorForKey:kColorBackground];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:H5_URL_Discovery]]];
    [self.view  addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
