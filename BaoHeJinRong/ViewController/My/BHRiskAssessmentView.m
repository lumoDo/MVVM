//
//  BHRiskAssessmentView.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/23.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHRiskAssessmentView.h"
#import "BHRiskAssessmentTableViewCell.h"

#define FONT_OF_SIZE                15.0
#define BUTTON_HEIGHT               40
#define RISK_ANSWER_ARRAY           @[@"A",@"A",@"A",@"A",@"A",@"A",@"A",@"A",@"A",@"A",@"A"]
#define MARGIN_LEFT                 15

@interface BHRiskAssessmentView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BHRiskAssessmentView
{
    UITableView *_tableView;
    NSMutableArray *riskQuestionArray;
    NSMutableArray *riskAnswerArray;
    NSMutableDictionary *riskAnswerDic;
    NSString *importantPrompt;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initViews];
        [self initRiskAnswerDictionary];
    }
    return self;
}

-(void) initViews
{
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"BHJR" ofType:@"plist"];
    NSDictionary *rootDictionary = [[NSDictionary alloc] initWithContentsOfFile:plist];
    riskQuestionArray = [rootDictionary objectForKey:@"riskQuestion"];
    importantPrompt = [rootDictionary objectForKey:@"importantPrompt"];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, rect.origin.y, rect.size.width - 2 * MARGIN_LEFT, rect.size.height)];
    promptLabel.text = importantPrompt;
    promptLabel.font = [UIFont systemFontOfSize:FONT_OF_SIZE];
    promptLabel.numberOfLines = 0;
    [promptLabel sizeToFit];
    promptLabel.textColor = [UIColor lightGrayColor];
    promptLabel.backgroundColor = [UIColor whiteColor];
    NSLog(@"%f",promptLabel.frame.size.height);
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, promptLabel.frame.size.height)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:promptLabel];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - BUTTON_HEIGHT - 20, rect.size.width, BUTTON_HEIGHT + 20)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lbLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lbLine.backgroundColor = [UIColor colorForKey:kColorBackground];
    [footerView addSubview:lbLine];
    
    CGFloat originX    = MARGIN_LEFT;
    CGFloat originY    = 10;
    CGFloat width      = self.frame.size.width - 2 * MARGIN_LEFT;
    CGFloat height     =  BUTTON_HEIGHT;
    
    UIButton *sureSubmitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureSubmitButton addTarget:self action:@selector(sureSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
    sureSubmitButton.frame = CGRectMake(originX, originY, width, height);
    [sureSubmitButton setTitle:@"提交" forState:UIControlStateNormal];
    [sureSubmitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sureSubmitButton.userInteractionEnabled = YES;
    sureSubmitButton.selected = YES;
    [footerView addSubview:sureSubmitButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height - BUTTON_HEIGHT - 20) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (promptLabel.text.length != 0)
    {
        _tableView.tableHeaderView = headerView;
    }
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:_tableView];
    [self addSubview:footerView];
    
}

-(void)initRiskAnswerDictionary
{
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *riskAnswerDic = [defaults objectForKey:[NSString stringWithFormat:@"%@-%@",NS_DEFAULTS_RISKANSWERDIC,[JRCommon customerNo]]];
    riskAnswerArray = [[NSMutableArray alloc] initWithArray:RISK_ANSWER_ARRAY];
    
    //    if ([JRUserUtils readRiskAnswerDic])
    //    {
    //        riskAnswerDic = [[NSMutableDictionary alloc] initWithDictionary:[JRUserUtils readRiskAnswerDic]];
    //    }
    //    else
    {
        riskAnswerDic = [NSMutableDictionary dictionary];
        [riskAnswerDic setValue:@"0" forKey:@"0"];
        [riskAnswerDic setValue:@"0" forKey:@"1"];
        [riskAnswerDic setValue:@"0" forKey:@"2"];
        [riskAnswerDic setValue:@"0" forKey:@"3"];
        [riskAnswerDic setValue:@"0" forKey:@"4"];
        [riskAnswerDic setValue:@"0" forKey:@"5"];
        [riskAnswerDic setValue:@"0" forKey:@"6"];
        [riskAnswerDic setValue:@"0" forKey:@"7"];
        [riskAnswerDic setValue:@"0" forKey:@"8"];
        [riskAnswerDic setValue:@"0" forKey:@"9"];
        [riskAnswerDic setValue:@"0" forKey:@"10"];
    }
    
}
/**
 确认提交
 */
-(void)sureSubmitAction:(UIButton *)sender
{
    //[JRUserUtils saveRiskAnswerDic:riskAnswerDic];
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitRiskAssessmentWithAnswerArray:)])
    {
        [self.delegate submitRiskAssessmentWithAnswerArray:riskAnswerArray];
    }
}
/**
 自适应高度
 */
-(CGFloat)autoHeight:(NSString *)sender

{
    UIFont *Labelfont = [UIFont systemFontOfSize:FONT_OF_SIZE];
    NSString *message = sender;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:Labelfont, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize LabelSize = [message boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    if (LabelSize.height + 5 > 20)
    {
        return LabelSize.height + 20;
        
    } else{
        return 20 ;
    }
}
#pragma  mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    
    NSMutableDictionary *everyQuestion = riskQuestionArray[section];
    NSString *question =[everyQuestion objectForKey:@"question"];
    label.frame = CGRectMake(MARGIN_LEFT, 0, self.frame.size.width - MARGIN_LEFT * 2, [self autoHeight:question]);
    label.text = [NSString stringWithFormat:@"%@",question];
    label.font = [UIFont systemFontOfSize:FONT_OF_SIZE];
    label.numberOfLines = 0;
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSMutableDictionary *everyQuestion = riskQuestionArray[section];
    NSString *question = [everyQuestion objectForKey:@"question"];
    return  [self autoHeight:question];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *scoreArray = [[riskQuestionArray objectAtIndex:indexPath.section] objectForKey:@"scoreArray"];
    [riskAnswerArray setObject:[scoreArray objectAtIndex:indexPath.row] atIndexedSubscript:indexPath.section];
    
    [riskAnswerDic setObject:[NSString stringWithFormat:@"%zi", indexPath.row] forKey:[NSString stringWithFormat:@"%zi", indexPath.section]];
    
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
    [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary *everyQuestion = riskQuestionArray[section];
    NSArray *answerArray = [everyQuestion objectForKey:@"answerArray"];
    return answerArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return riskQuestionArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BHRiskAssessmentTableViewCell *cell = [[BHRiskAssessmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"riskAssessmentCell"];
    NSMutableDictionary *everyQuestion = riskQuestionArray[indexPath.section];
    NSArray *answerArray = [everyQuestion objectForKey:@"answerArray"];
    NSString *answerString = [answerArray objectAtIndex:indexPath.row];
    cell.questionLabel.text = answerString;
    
    NSString *selectCell = [riskAnswerDic objectForKey:[NSString stringWithFormat:@"%zi", indexPath.section]];
    if([[NSString stringWithFormat:@"%zi", indexPath.row] isEqualToString:selectCell]) {
        [cell setSelectedItem:YES];
    } else {
        [cell setSelectedItem:NO];
    }
    
    return cell;
}

//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat sectionHeaderHeight = 100;
//    
//    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
//        
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        
//    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//        
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//    
//}
@end

