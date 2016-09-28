//
//  BHRiskAssessmentViewController.m
//  BaoHeJinRong
//
//  Created by Richard on 16/9/23.
//  Copyright © 2016年 JuXin. All rights reserved.
//

#import "BHRiskAssessmentViewController.h"
#import "BHRiskAssessmentView.h"

@interface BHRiskAssessmentViewController ()

@end

@implementation BHRiskAssessmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"风险测评";
    BHRiskAssessmentView *riskAssessmentView = [[BHRiskAssessmentView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:riskAssessmentView];
    
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
