
/****UI常量***/
#define SCREEN_WIDTH                ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT               ([UIScreen mainScreen].bounds.size.height) - 64.0
#define SCREEN_PERCENT              SCREEN_WIDTH/375.0
#define STATUS_BAR_HEIGHT           20
#define NAVI_BAR_HEIGHT             44
#define HEADER_TABBAR_HEIGHT        44
#define NAVI_BAR_TITLE_WIDTH        200
#define TOOL_BAR_HEIGHT             44
#define MARQUEEVIEW_HEIGHT          26
#define title_header_hight          35
//webview超时时间
#define WEBVIEW_TIMEOUT             20

#define NAV_ITEM_BORDER             10
#define NAV_ITEM_WIDTH              30
#define NAV_ITEM_HEIGHT             30


#define NAV_CONTENT_HEIGHT        (SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NAVI_BAR_HEIGHT-HEADER_TABBAR_HEIGHT)


#define WS __weak typeof(self) weakSelf = self;
#define APP (AppDelegate*)[[UIApplication sharedApplication] delegate]

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Time_BACKGROUND             10.0

#define User_Current                @"HXUserAccount"
#define User_History                @"HXUserHistory"

//#define PushToLoginView             @"PushToLoginView"


/****URL****/
#define KNOWCHANNEL                 @"RHJF_APP_IOS_KC"
#define APPVERSION                  @"2"
#define PARAMETERSTRING             [NSString stringWithFormat:@"knowChannel=%@&appVersion=%@",KNOWCHANNEL,APPVERSION]
#define IsTest 1    //1测试,0正式

#define H5HEADURL                   (IsTest?@"http://10.1.110.45:8080":@"https://h5.rhjf.com.cn")

//****H5_URL****
//首页
#define H5_URL_FIRST        [NSString stringWithFormat:@"%@/BaoHeJinRong/H5/html/index.html",H5HEADURL]
//理财
#define URL_Product         [NSString stringWithFormat:@"%@/BaoHeJinRong/H5/html/licai.html",H5HEADURL]
//发现
#define H5_URL_Discovery    [NSString stringWithFormat:@"%@/BaoHeJinRong/H5/html/faxian.html",H5HEADURL]


/****文字内容***/
#define CUTI            @"Helvetica-Bold"
#define CHANGGUI        @"Helvetica"

#define TITLE_FIRST                  @"融和金服"
#define TITLE_PRODUCTLIST            @"产品"
#define TITLE_DISCOVERY              @"发现"
#define TITLE_ACCOUNT                @"账户"
#define TITLE_PERSONAL               @"我"
#define TITLE_SAFECENTER             @"安全中心"
#define TITLE_NAME                   @"实名认证"
#define TITLE_FEEDBACK               @"意见反馈"
#define TITLE_ABOUT                  @"关于我们"


#define STATUS_AM                    @"上午好"
#define STATUS_PM                    @"下午好"
#define STATUS_NIGHT                 @"晚上好"
#define STR_NOLOGIN                  @"您还未登录,请先登录"
#define STR_LOGIN                    @"请先登录"

#define STR_HINT                     @"提示"
#define STR_CANCEL                   @"取消"
#define STR_SURE                     @"确定"
#define STR_KNOW                     @"我知道了"
#define STR_HINT_MESSAGE             @"是否选择关闭手势密码?"
#define STR_HINT_OPENGESSTURE        @"只有在进入资产界面时,需要手势密码"
#define STR_GESSTURE_ERROR           @"密码错误，次数已达5次，请重新登录"


#define STR_CHANGE_LOGINPASSWORD     @"修改登陆密码"
//#define STR_SET_PASSWORD             @"设置支付密码"
#define STR_CHANGE_PASSWORD          @"修改支付密码"
#define STR_SET_GESTUREPASSWORD      @"手势密码"
#define STR_CHANGE_GESTUREPASSWORD   @"修改手势密码"

#define STR_SAFECENTER              @"安全中心"
#define STR_MYCARD                  @"我的银行卡"
#define STR_NAME                    @"实名认证"
#define STR_GUARANTEE               @"安全保障"
#define STR_FEEDBACK                @"意见反馈"
#define STR_ABOUT                   @"关于我们"

#define STR_SMALLBUYPROTOCOL        @"点击\"下一步\",即表示您已阅读并同意《融和金服小额理财用户服务协议》"
/*
 手势逻辑:
 首先在我们首页的需要用户登录的H5页面入口处添加JS方法type=4,并且带url参数;
 当原生接收到后
 if (type == 4) {
 设置全局手势BOOL = YES;  //需要登录的界面BOOL控制
 if (用户登录 == YES && 用户有手势密码 && 满足手势开启要求 && 全局手势BOOL == YES) {
 弹出手势界面->校验成功后->进入JS带入的url地址页面同;
 }
 else {
 直接打开传过来的url连接;
 }
 }
 else {
 设置全局手势BOOL = NO;
 直接打开传过来的url连接;
 }
 当用户回到非登录页面时全局手势BOOL = NO;
 */
