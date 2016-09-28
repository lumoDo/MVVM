//
//  BHFirstViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/21.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHFirstViewController.h"

@interface BHFirstViewController ()

@end

@implementation BHFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem* fristItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabBarImage_one_on"] tag:0];
        fristItem.selectedImage = [[UIImage imageNamed:@"tabBarImage_one_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        fristItem.image = [[UIImage imageNamed:@"tabBarImage_one_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = fristItem;
    }
    return self;
}

+ (instancetype)shareInstance
{
    static BHFirstViewController *_instance = nil;
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
    // Do any additional setup after loading the view.
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