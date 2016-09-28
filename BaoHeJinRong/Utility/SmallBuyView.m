//
//  SmallBuyView.m
//  HeXunRongHeJinFu
//
//  Created by 祝敏彧 on 16/2/3.
//  Copyright © 2016年 庄小宁. All rights reserved.
//

#import "SmallBuyView.h"


#define MinValue 1
#define MaxValue 80
#define AnimateWithDurationNum 0.4

@implementation SmallBuyView
{
    UIView *buyView;
    UILabel *jeLbl;     //金额
    UISlider *slider;   //滑块
    NSNumberFormatter *numberFormatter;
    int jc;             //极差值
    UILabel *yjsyLbl;   //预计收益
    UILabel *bankTitleLbl; //银行名称
    SelectPayByView *selectView;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        jc = 1000;
        
        self.hidden = YES;
//        [self addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
        
        [self creatBuyView];
        
        [self creatSelectPayByView];
    }
    return self;
}

- (void)creatBuyView
{
    buyView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT/1.5)];
    buyView.backgroundColor = [UIColor whiteColor];
    [self addSubview:buyView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [closeBtn setImage:[UIImage imageNamed:@"user.png"] forState:UIControlStateNormal];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame=CGRectMake(5, 5, 30, 30);
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [buyView addSubview:closeBtn];
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, 30)];
    titleLbl.text = @"投资";
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor darkGrayColor];
    titleLbl.font = [UIFont systemFontOfSize:18];
    [buyView addSubview:titleLbl];
    
    UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(5, titleLbl.frame.size.height + titleLbl.frame.origin.y + 5, SCREEN_WIDTH - 10, 1)];
    xian.backgroundColor = [UIColor lightGrayColor];
    [buyView addSubview:xian];
    
    UILabel *tzjeLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLbl.frame.size.height + titleLbl.frame.origin.y + 10, SCREEN_WIDTH - 20, 20)];
    tzjeLbl.text = @"投资金额(元)";
    tzjeLbl.textAlignment = NSTextAlignmentCenter;
    tzjeLbl.textColor = [UIColor lightGrayColor];
    tzjeLbl.font = [UIFont systemFontOfSize:13];
    [buyView addSubview:tzjeLbl];
    
    //金额
    jeLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, tzjeLbl.frame.size.height + tzjeLbl.frame.origin.y + 5, SCREEN_WIDTH - 20, 25)];
    jeLbl.text = @"10000.00";
    jeLbl.textAlignment = NSTextAlignmentCenter;
    jeLbl.textColor = [UIColor orangeColor];
    jeLbl.font = [UIFont systemFontOfSize:18];
    [buyView addSubview:jeLbl];
    
    
    //滑块-开始
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:0];
    [formatter setMinimumFractionDigits:0];
    numberFormatter = formatter;
    
    UIButton *jianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jianBtn setTitle:@"-" forState:UIControlStateNormal];
    [jianBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [jianBtn addTarget:self action:@selector(onJian) forControlEvents:UIControlEventTouchUpInside];
    jianBtn.frame = CGRectMake(5, jeLbl.frame.size.height + jeLbl.frame.origin.y, 30, 30);
    jianBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [buyView addSubview:jianBtn];
    
    slider = [[UISlider alloc]initWithFrame:CGRectMake(jianBtn.frame.origin.x + jianBtn.frame.size.width + 5, jianBtn.frame.origin.y + 7, SCREEN_WIDTH - 80, 20)];
    [slider addTarget:self action:@selector(getValue) forControlEvents:UIControlEventValueChanged];
    slider.minimumValue = MinValue;
    slider.maximumValue = MaxValue;
    slider.value = 10;
    slider.continuous = YES;
    //左右轨的样式,后期需要用图片替换
    UIView *stetchLeftTrackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
    stetchLeftTrackView.backgroundColor = [UIColor redColor];
    [stetchLeftTrackView.layer setCornerRadius:4.0];
    [stetchLeftTrackView.layer setMasksToBounds:YES];
    UIView *stetchRightTrackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
    stetchRightTrackView.backgroundColor = [UIColor lightGrayColor];
    [stetchRightTrackView.layer setCornerRadius:4.0];
    [stetchRightTrackView.layer setMasksToBounds:YES];
    [slider setMinimumTrackImage:[self convertViewToImage:stetchLeftTrackView] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[self convertViewToImage:stetchRightTrackView] forState:UIControlStateNormal];
    //        //滑块的样式,后期需要用图片替换
    //        UIView *thumbImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //        thumbImage.backgroundColor = [UIColor redColor];
    //        [thumbImage.layer setCornerRadius:15.0];
    //        [thumbImage.layer setMasksToBounds:YES];
    //        //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    //        [slider setThumbImage:[self convertViewToImage:thumbImage] forState:UIControlStateHighlighted];
    //        [slider setThumbImage:[self convertViewToImage:thumbImage] forState:UIControlStateNormal];
    [buyView addSubview:slider];
    
    UIButton *jiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiaBtn setTitle:@"+" forState:UIControlStateNormal];
    [jiaBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [jiaBtn addTarget:self action:@selector(onJia) forControlEvents:UIControlEventTouchUpInside];
    jiaBtn.frame = CGRectMake(slider.frame.origin.x + slider.frame.size.width + 5, jianBtn.frame.origin.y, 30, 30);
    jiaBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [buyView addSubview:jiaBtn];
    //滑块-结束
    
    UILabel *qtLbl = [[UILabel alloc]initWithFrame:CGRectMake(jianBtn.frame.origin.x + jianBtn.frame.size.width, jiaBtn.frame.size.height + jiaBtn.frame.origin.y + 10, (SCREEN_WIDTH - jianBtn.frame.origin.x - jianBtn.frame.size.width - 5)/2, 20)];
    qtLbl.text = @"起投10000.00元";
    qtLbl.textAlignment = NSTextAlignmentLeft;
    qtLbl.textColor = [UIColor lightGrayColor];
    qtLbl.font = [UIFont systemFontOfSize:13];
    [buyView addSubview:qtLbl];
    
    UILabel *ktLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - qtLbl.frame.origin.x - qtLbl.frame.size.width, qtLbl.frame.origin.y, qtLbl.frame.size.width, qtLbl.frame.size.height)];
    ktLbl.text = @"可投80000.00元";
    ktLbl.textAlignment = NSTextAlignmentRight;
    ktLbl.textColor = [UIColor lightGrayColor];
    ktLbl.font = [UIFont systemFontOfSize:13];
    [buyView addSubview:ktLbl];
    
    
    yjsyLbl = [[UILabel alloc]initWithFrame:CGRectMake(qtLbl.frame.origin.x, qtLbl.frame.origin.y + qtLbl.frame.size.height + 10, SCREEN_WIDTH - (qtLbl.frame.origin.x * 2), 20)];
    yjsyLbl.text = @"预计收益(元):1200";
    yjsyLbl.textAlignment = NSTextAlignmentLeft;
    yjsyLbl.textColor = [UIColor lightGrayColor];
    yjsyLbl.font = [UIFont systemFontOfSize:17];
    [buyView addSubview:yjsyLbl];
    
    UIView *xian2 = [[UIView alloc]initWithFrame:CGRectMake(5, yjsyLbl.frame.size.height + yjsyLbl.frame.origin.y + 10, SCREEN_WIDTH - 10, 1)];
    xian2.backgroundColor = [UIColor lightGrayColor];
    [buyView addSubview:xian2];
    
    //支付方式-开始
    UIView *payByViewBg = [[UIView alloc]initWithFrame:CGRectMake(0, xian2.frame.size.height + xian2.frame.origin.y + 5, SCREEN_WIDTH, 60)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToSelectPayByView)];
    [payByViewBg addGestureRecognizer:tap];
    [buyView addSubview:payByViewBg];
    
    UILabel *payTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, (payByViewBg.frame.size.height - qtLbl.frame.size.height)/2, 100, qtLbl.frame.size.height)];
    payTitleLbl.text = @"支付方式:";
    payTitleLbl.textAlignment = NSTextAlignmentLeft;
    payTitleLbl.textColor = [UIColor blackColor];
    payTitleLbl.font = [UIFont systemFontOfSize:16];
    [payByViewBg addSubview:payTitleLbl];
    
    bankTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 30, payTitleLbl.frame.origin.y, qtLbl.frame.size.width, payTitleLbl.frame.size.height)];
    bankTitleLbl.text = @"光大银行(8888)";
    bankTitleLbl.textAlignment = NSTextAlignmentRight;
    bankTitleLbl.textColor = [UIColor lightGrayColor];
    bankTitleLbl.font = [UIFont systemFontOfSize:13];
    [payByViewBg addSubview:bankTitleLbl];
    //支付方式-结束
    
    UIView *xian3 = [[UIView alloc]initWithFrame:CGRectMake(5, payByViewBg.frame.size.height + payByViewBg.frame.origin.y + 5, SCREEN_WIDTH - 10, 1)];
    xian3.backgroundColor = [UIColor lightGrayColor];
    [buyView addSubview:xian3];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor = [UIColor blueColor];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(goToNextView) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.frame = CGRectMake(10, xian3.frame.size.height + xian3.frame.origin.y + 5, SCREEN_WIDTH - 20, 50);
    [nextBtn.layer setCornerRadius:4.0];
    [nextBtn.layer setMasksToBounds:YES];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [buyView addSubview:nextBtn];
    
    UILabel *protocolLbl = [[UILabel alloc]initWithFrame:CGRectMake(nextBtn.frame.origin.x, nextBtn.frame.size.height + nextBtn.frame.origin.y + 5, SCREEN_WIDTH, 20)];
    protocolLbl.text = STR_SMALLBUYPROTOCOL;
    protocolLbl.textAlignment = NSTextAlignmentLeft;
    protocolLbl.textColor = [UIColor lightGrayColor];
    protocolLbl.font = [UIFont systemFontOfSize:9];
    [buyView addSubview:protocolLbl];
}

- (void)creatSelectPayByView
{
    selectView = [[SelectPayByView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2) style:UITableViewStyleGrouped];
    [selectView setBackgroundColor:[UIColor whiteColor]];
    selectView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    selectView.selectDelegate = self;
    selectView.hidden = YES;
    [self addSubview:selectView];
}

- (void)goToSelectPayByView
{
    selectView.hidden = NO;
    buyView.alpha = 1;
    [UIView animateWithDuration:AnimateWithDurationNum animations:^{
        CGRect rect = selectView.frame;
        rect.origin.x = 0;
        selectView.frame = rect;
        buyView.alpha = 0;
    } completion:^(BOOL finished) {
        buyView.hidden = YES;
    }];
    
}

- (void)goToNextView
{
    
}

- (void)onJian
{
    slider.value = slider.value - MinValue;
    [self getValue];
}

- (void)onJia
{
    slider.value = slider.value + MinValue;
    [self getValue];
}

-(void)getValue{
    if (slider.value <= 10) {
        slider.value = 10;
    }
    int num = [[numberFormatter stringFromNumber:@(slider.value)]intValue] * jc;
    jeLbl.text = [NSString stringWithFormat:@"%d.00",num];
    NSMutableAttributedString *numberStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"预计收益(元):%0.2f",(num * 0.012)]];
    [numberStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666) range:NSMakeRange(0, 8)];
    [numberStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(8, numberStr.length-8)];
    yjsyLbl.attributedText = numberStr;
    
}

- (void)onClose
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [UIView animateWithDuration:AnimateWithDurationNum animations:^{
        CGRect rect=buyView.frame;
        rect.origin.y=SCREEN_HEIGHT;
        buyView.frame=rect;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)showBuyView
{
    self.hidden = NO;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6f];
    [UIView animateWithDuration:AnimateWithDurationNum animations:^{
        CGRect rect=buyView.frame;
        rect.origin.y=SCREEN_HEIGHT - SCREEN_HEIGHT/1.5;
        buyView.frame=rect;
    } completion:^(BOOL finished) {
    }];
}

-(UIImage*)convertViewToImage:(UIView*)v{
    
    UIGraphicsBeginImageContext(v.bounds.size);
    
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

#pragma mark - SelectPayByViewDelegate
-(void)SelectBankName:(NSString *)nameStr andBankCode:(NSString *)codeStr {
    bankTitleLbl.text = nameStr;
    buyView.hidden = NO;
    buyView.alpha = 0;
    [UIView animateWithDuration:AnimateWithDurationNum animations:^{
        CGRect rect = selectView.frame;
        rect.origin.x = SCREEN_WIDTH;
        selectView.frame = rect;
        buyView.alpha = 1;
    } completion:^(BOOL finished) {
        selectView.hidden = YES;
    }];
}

@end
