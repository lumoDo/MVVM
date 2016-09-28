//
//  BHMyViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/21.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHMyViewController.h"
#import "BHMyViewModel.h"
#define headerViewHeight    (220 - 64) * SCREEN_PERCENT
#define headerViewLabelColor [UIColor whiteColor]
#define headerViewLabelFont 12 * SCREEN_PERCENT
#define headerViewLabelGap  8 * SCREEN_PERCENT
#define headerHeight        50 *SCREEN_PERCENT
#define centerViewHeight    60
#define footViewHeight      210
#define gap                 8
/**
 * 把按钮,图片和文本组合在一起
 */
@interface MyButton:UIButton

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name title:(NSString *)title;

@end


@implementation MyButton

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImage *image = [UIImage imageNamed:name];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2.0 - image.size.width/2.0, frame.size.height * 2.0/3.0 - image.size.height - 12.0, image.size.width, image.size.height)];
        imageView.image = image;
        [self addSubview:imageView];
        CGFloat font = 14.0 * SCREEN_PERCENT;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height * 2.0/3.0, frame.size.width, font)];
        label.font = [UIFont systemFontOfSize:font];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

@end

@interface BHMyViewController ()

@property (strong, nonatomic) UILabel *totalAsset;//总资产
@property (strong, nonatomic) UILabel *totalEarning;//累计收益
@property (strong, nonatomic) UILabel *balanceMoney;//可用余额
@property (strong, nonatomic) UIImageView *header;//用户头像
@property (strong, nonatomic) UIButton *charge;//充值
@property (strong, nonatomic) UIButton *get;//提现
@property (strong, nonatomic) BHMyViewModel *myViewModel;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@end

@implementation BHMyViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UITabBarItem* fristItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabBarImage_four_on"] tag:3];
        fristItem.selectedImage = [[UIImage imageNamed:@"tabBarImage_four_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        fristItem.image = [[UIImage imageNamed:@"tabBarImage_four_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = fristItem;
    }
    return self;
}


+ (instancetype)shareInstance
{
    static BHMyViewController *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTBNVCTitle:@"你好,**"];
    [self setTBNVCLeftBarButton];
    self.view.backgroundColor = [UIColor colorForKey:kColorBackground];
    _myViewModel = [[BHMyViewModel alloc] init];
    [self createHeaderView];
    [self createCenterView];
    [self createFootView];
    [self bindViewModel];
    // Do any additional setup after loading the view.
}


- (void)createHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerViewHeight)];
    headerView.backgroundColor = [UIColor colorForKey:kColorNaviTitle];
    [self.view addSubview:headerView];
    _header = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - headerHeight)/2, 0 , headerHeight, headerHeight)];
    _header.image = [UIImage imageNamed:@"head"];
    [headerView addSubview:_header];
    UILabel *totalAssertLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, CGRectGetMaxY(_header.frame) + headerViewLabelGap, 80, headerViewLabelFont)];
    totalAssertLabel.text = @"总资产(元)";
    totalAssertLabel.font = [UIFont systemFontOfSize:headerViewLabelFont];
    totalAssertLabel.textColor = headerViewLabelColor;
    totalAssertLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:totalAssertLabel];
    _totalAsset = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(totalAssertLabel.frame) + headerViewLabelGap, SCREEN_WIDTH, 25.0)];
    _totalAsset.font = [UIFont systemFontOfSize:25];
    _totalAsset.text = @"3046.80";
    _totalAsset.textColor = headerViewLabelColor;
    _totalAsset.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_totalAsset];
    _totalEarning = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(headerView.frame) - headerViewLabelFont - headerViewLabelGap, SCREEN_WIDTH/2.0, headerViewLabelFont)];
    _totalEarning.text = @"9999.99";
    _totalEarning.font = [UIFont systemFontOfSize:headerViewLabelFont];
    _totalEarning.textAlignment = NSTextAlignmentCenter;
    _totalEarning.textColor = headerViewLabelColor;
    [headerView addSubview:_totalEarning];
    UILabel *totalEarningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(_totalEarning.frame) - headerViewLabelGap - headerViewLabelFont, SCREEN_WIDTH/2.0, headerViewLabelFont)];
    totalEarningLabel.text = @"累计收益(元)";
    totalEarningLabel.textColor = headerViewLabelColor;
    totalEarningLabel.textAlignment = NSTextAlignmentCenter;
    totalEarningLabel.font = [UIFont systemFontOfSize:headerViewLabelFont];
    [headerView addSubview:totalEarningLabel];
    _balanceMoney = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, CGRectGetHeight(headerView.frame) - headerViewLabelFont - headerViewLabelGap, SCREEN_WIDTH/2.0, headerViewLabelFont)];
    _balanceMoney.font = [UIFont systemFontOfSize:headerViewLabelFont];
    _balanceMoney.text = @"9999.99";
    _balanceMoney.textColor = headerViewLabelColor;
    _balanceMoney.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_balanceMoney];
    UILabel *balanceMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, CGRectGetMinY(_balanceMoney.frame) - headerViewLabelGap - headerViewLabelFont, SCREEN_WIDTH/2.0, headerViewLabelFont)];
    balanceMoneyLabel.textColor = headerViewLabelColor;
    balanceMoneyLabel.font = [UIFont systemFontOfSize:headerViewLabelFont];
    balanceMoneyLabel.text = @"可用余额(元)";
    balanceMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:balanceMoneyLabel];
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, CGRectGetMinY(totalEarningLabel.frame), 1, CGRectGetMaxY(_totalEarning.frame) - CGRectGetMinY(totalEarningLabel.frame) - 2)];
    segmentView.backgroundColor = headerViewLabelColor;
    [headerView addSubview:segmentView];
}

- (void)createCenterView
{
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, headerViewHeight + gap, SCREEN_WIDTH, centerViewHeight)];
    centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerView];
    CGFloat width = 100.0 * SCREEN_PERCENT;
    CGFloat height = 30.0 * SCREEN_PERCENT;
    CGFloat font = 16 * SCREEN_PERCENT;
    _charge = [UIButton buttonWithType:UIButtonTypeCustom];
    _charge.frame = CGRectMake((SCREEN_WIDTH/2.0 - width)/2.0, CGRectGetHeight(centerView.frame)/2.0 - height/2.0, width, height);
    [_charge setTitle:@"充值" forState:UIControlStateNormal];
    _charge.titleLabel.font = [UIFont systemFontOfSize:font];
    [_charge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _charge.layer.cornerRadius = _charge.frame.size.height/2.0;
    _charge.backgroundColor = [UIColor colorForKey:kColorNaviTitle];
    [centerView addSubview:_charge];
    _get = [UIButton buttonWithType:UIButtonTypeCustom];
    _get.frame = CGRectMake(SCREEN_WIDTH/2.0 + (SCREEN_WIDTH/2.0 - width)/2.0, CGRectGetHeight(centerView.frame)/2.0 - height/2.0, width, height);
    [_get setTitle:@"提现" forState:UIControlStateNormal];
    [_get setTitleColor:[UIColor colorForKey:kColorNaviTitle] forState:UIControlStateNormal];
    _get.layer.borderColor = [UIColor colorForKey:kColorNaviTitle].CGColor;
    _get.layer.borderWidth = 1.0;
    _get.layer.cornerRadius = _get.frame.size.height/2.0;
    _get.titleLabel.font = [UIFont systemFontOfSize:font];
    [centerView addSubview:_get];
}

- (void)createFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, (headerViewHeight + gap)  + centerViewHeight + gap, SCREEN_WIDTH, footViewHeight)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"myVC" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    self.buttonArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++)
    {
        NSDictionary *dictionary = array[i];
        CGFloat originX = i%3 * (SCREEN_WIDTH/3.0);
        CGFloat originY = (i/3) * footViewHeight/2.0;
        MyButton *button = [[MyButton alloc] initWithFrame:CGRectMake(originX, originY, SCREEN_WIDTH/3.0, CGRectGetHeight(footView.frame)/2.0) imageName:dictionary[@"icon"] title:dictionary[@"title"]];
        button.tag = i;
        [self.buttonArray addObject:button];
        [footView addSubview:button];
    }
    UIView *rowSegmentView = [[UIView alloc] initWithFrame:CGRectMake(0, footViewHeight/2.0, SCREEN_WIDTH, 1)];
    rowSegmentView.backgroundColor = self.view.backgroundColor;
    [footView addSubview:rowSegmentView];
    UIView *columnSegmentView1 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3.0, 0, 2.0, footViewHeight)];
    columnSegmentView1.backgroundColor = self.view.backgroundColor;
    [footView addSubview:columnSegmentView1];
    UIView *columnSegment2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2.0/3.0, 0, 2.0, footViewHeight)];
    columnSegment2.backgroundColor = self.view.backgroundColor;
    [footView addSubview:columnSegment2];
}

- (void)bindViewModel
{
    WS;
    [[self.tabBarController.navigationItem.leftBarButtonItem.customView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x)
    {
        [weakSelf.myViewModel.excuteSignal execute:nil];
    }];
    for (int i = 0; i < self.buttonArray.count; i ++)
    {
        UIButton *button = self.buttonArray[i];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [weakSelf.myViewModel.excuteSignal execute:x];
        }];
    }
    [[self.charge rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf.myViewModel.excuteSignal execute:weakSelf.charge.titleLabel.text];
    }];
    [[self.get rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf.myViewModel.excuteSignal execute:weakSelf.get.titleLabel.text];
    }];
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

