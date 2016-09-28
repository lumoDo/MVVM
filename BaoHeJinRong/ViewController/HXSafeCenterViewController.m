//
//  HXSafeCenterViewController.m
//  HeXunRongHeJinFu
//
//  Created by 庄小宁 on 15/12/4.
//  Copyright © 2015年 庄小宁. All rights reserved.
//

#import "HXSafeCenterViewController.h"
#import "GestureViewController.h"
#import "GestureVerifyViewController.h"
#import "HXSettingWebViewController.h"
//#import "HXSecondViewController.h"
@interface HXSafeCenterViewController (){
    UITableView        *tableview;
    NSMutableArray     *titleArr;
    UIButton    *gestureLabelButton;
    UIButton           *loginOutBtn;
}

@end

@implementation HXSafeCenterViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
    [AppDelegate App].isCurrentVC = YES;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [super setNavigationTitleView:TITLE_SAFECENTER andBarTintColor:0x0fa8ff];
    self.view.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
    CLog(@"手势开关:%@",[AppDelegate App].isHaveGesture?@"开":@"关");
    NSString *version = [[AppDelegate App].userDic heHuoRenObjectForKey:@"version"];
    
    
    if ([AppDelegate App].isHaveGesture == YES) {
        if (version.intValue >=2) {
            titleArr = [[NSMutableArray alloc ]initWithObjects:STR_CHANGE_LOGINPASSWORD,STR_CHANGE_PASSWORD,STR_SET_GESTUREPASSWORD,STR_CHANGE_GESTUREPASSWORD, nil];
        }
        else {
            titleArr = [[NSMutableArray alloc ]initWithObjects:STR_CHANGE_LOGINPASSWORD,STR_SET_GESTUREPASSWORD,STR_CHANGE_GESTUREPASSWORD, nil];
        }
    }else{
        if (version.intValue >=2) {
            titleArr = [[NSMutableArray alloc ]initWithObjects:STR_CHANGE_LOGINPASSWORD,STR_CHANGE_PASSWORD,STR_SET_GESTUREPASSWORD, nil];
        }
        else {
            titleArr = [[NSMutableArray alloc ]initWithObjects:STR_CHANGE_LOGINPASSWORD,STR_SET_GESTUREPASSWORD, nil];
        }
        
    }
    
    tableview=[[UITableView  alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStyleGrouped];
    [tableview setBackgroundColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1]];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.showsHorizontalScrollIndicator = NO;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.delegate = self;
    tableview.scrollEnabled = YES;
    tableview.dataSource = self;
    tableview.bounces = NO;
    
    [self.view addSubview:tableview];
    
    loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginOutBtn.frame = CGRectMake(0, 400+20, SCREEN_WIDTH, 44);
    [loginOutBtn setTitle:@"安全退出" forState:UIControlStateNormal];
    loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginOutBtn setBackgroundColor:[UIColor whiteColor]];
    [loginOutBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [loginOutBtn addTarget:self action:@selector(loginOutClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginOutBtn];
}

- (void)loginOutClick:(UIButton *)sender{
    //    [self loginOut];
#pragma mark - 登出操作
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:User_Current];
    if (data != nil){
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_LOGINOUT] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:WEBVIEW_TIMEOUT];
        [webView loadRequest:request];
        [self.view addSubview:webView];
        [webView setHidden:YES];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:User_Current];
        [self doLogout];
    }
    else {
        [self doLogout];
    }
}

- (void) doLogout
{
    [AppDelegate App].isLogin = NO;
    [AppDelegate App].isHaveGesture = NO;
    [AppDelegate App].userDic = NULL;
    [self showTips:@"登出成功"];
    [self.navigationController popToRootViewControllerAnimated:YES];
#pragma mark - 清除webCookies
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* heXunCookies = [storage cookiesForURL:[NSURL URLWithString:H5HEADURL]];
    for (NSHTTPCookie *cookie in heXunCookies)
    {
        [storage deleteCookie:cookie];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArr count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UserCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 260, 30)];
    labelTitle.font = [UIFont systemFontOfSize:15];
    labelTitle.textColor = [UIColor colorWithHexString:@"#4e4e4e"];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.tag = 1002;
    [cell.contentView addSubview:labelTitle];
    //    if (gestureLabelButton.isSelected && [labelTitle.text isEqualToString:STR_CHANGE_GESTUREPASSWORD]) {
    //        labelTitle.textColor = [UIColor colorWithHexString:@"#4e4e4e"];
    //    }
    labelTitle.text=titleArr[indexPath.row];
    if ([labelTitle.text isEqualToString:STR_SET_GESTUREPASSWORD]) {
        
        UIImage *on = [UIImage imageNamed:@"switch_on"];
        UIImage *off = [UIImage imageNamed:@"switch_off"];
        gestureLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        gestureLabelButton.frame = CGRectMake(SCREEN_WIDTH - on.size.width-20, 15, on.size.width, on.size.height);
        gestureLabelButton.layer.masksToBounds=YES;
        [gestureLabelButton setContentMode:UIViewContentModeCenter];
        [gestureLabelButton setExclusiveTouch:YES];
        [gestureLabelButton setImage:off forState:UIControlStateNormal];
        [gestureLabelButton setImage:on forState:UIControlStateSelected];
        [cell.contentView addSubview:gestureLabelButton];
        [gestureLabelButton addTarget:self action:@selector(onGestureOnOff:) forControlEvents:UIControlEventTouchUpInside];
        
        [gestureLabelButton setSelected:[AppDelegate App].isHaveGesture];
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell= [_tableView cellForRowAtIndexPath:indexPath]; // 获取cell 对象
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:1002]; // 获取昵称
//    HXSecondViewController *setWebView=[[HXSecondViewController alloc]init];
    if ([name.text isEqualToString:STR_CHANGE_LOGINPASSWORD]) {
        
//        setWebView.urlStr=URL_LOGIN_CHANGE;
//        [self.navigationController pushViewController:setWebView animated:YES];
        
    }
    //    else if ([name.text isEqualToString:STR_SET_PASSWORD]){
    //        
    //        setWebView.urlStr=URL_MYBANKCARD;
    //        [self.navigationController pushViewController:setWebView animated:YES];
    //        
    //    }
    else if ([name.text isEqualToString:STR_CHANGE_PASSWORD]){
//        setWebView.urlStr=URL_SETBUYPASSWORD;
//        [self.navigationController pushViewController:setWebView animated:YES];
    }else if ([name.text isEqualToString:STR_CHANGE_LOGINPASSWORD]) {
        [self onGestureOnOff:gestureLabelButton];
        
    }else if ([name.text isEqualToString:STR_CHANGE_GESTUREPASSWORD]) {
        GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
        gestureVerifyVc.isToSetNewGesture = YES;
        gestureVerifyVc.delegate = self;
        [self.navigationController pushViewController:gestureVerifyVc animated:YES];
    }
    
}

#pragma mark - 实现UISwitch监听的方法

- (void)onGestureOnOff:(UIButton *) sender {
    if (gestureLabelButton.selected == YES) {
        
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:STR_HINT message:STR_HINT_MESSAGE delegate:self cancelButtonTitle:STR_CANCEL otherButtonTitles:STR_SURE, nil];
        alerView.tag = 401;
        [alerView show];
        
    }
    else {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:STR_HINT message:STR_HINT_OPENGESSTURE delegate:self cancelButtonTitle:nil otherButtonTitles:STR_KNOW, nil];
        [alerView show];
        alerView.tag = 402;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 401) {
        if (buttonIndex==1) {
            GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
            
            gestureVerifyVc.delegate = self;
            [self.navigationController pushViewController:gestureVerifyVc animated:YES];
        }
    }else if (alertView.tag ==402){
        GestureViewController *gestureVc = [[GestureViewController alloc] init];
        gestureVc.type = GestureViewControllerTypeSetting;
        //        gestureVc.title = @"设置手势密码";
        gestureVc.delegate = self;
        [self.navigationController pushViewController:gestureVc animated:YES];
    }
    
}

- (void)gestureSuccess{
    [self performSelector:@selector(delayGestureSuccess) withObject:nil afterDelay:0.5];
}
- (void)gestureVerifySuccess{
    [self performSelector:@selector(delayGestureVerifySuccess) withObject:nil afterDelay:0.5];
}
- (void)delayGestureSuccess{
    [gestureLabelButton setSelected:YES];
    [titleArr addObject:STR_CHANGE_GESTUREPASSWORD];
    [AppDelegate App].isHaveGesture = YES;
    [tableview reloadData];
}
- (void)delayGestureVerifySuccess{
    [gestureLabelButton setSelected:NO];
    if([[NSUserDefaults standardUserDefaults]stringForKey:@"lastDate"]){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lastDate"];
    }
    if ([titleArr containsObject:STR_CHANGE_GESTUREPASSWORD]) {
        [titleArr removeObject:STR_CHANGE_GESTUREPASSWORD];
    }
    [AppDelegate App].isHaveGesture = NO;
    [tableview reloadData];
}

@end
