//
//  AppDelegate.m
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//


#import "AppDelegate.h"
#import "IntelligentCashierVC.h"
#import "BillStatisticsVC.h"
#import "MessageVC.h"
#import "PersonalCenterVC.h"
#import "ColorDefine.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "YTKNetworkConfig.h"
#import "TBCityIconFont.h"

#import "AFNetworkReachabilityManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "BaseinfoAPI.h"
#import "LoginAPI.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [TBCityIconFont setFontName:@"iconfont"];
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = NO; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:15]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    [[YTKNetworkConfig sharedInstance]setBaseUrl:HTTPHEAD];//设置api 头域名
   
    AFNetworkReachabilityManager * netManager = [AFNetworkReachabilityManager sharedManager];
    
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您可能断网了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
        }
    }];
    [netManager startMonitoring];
    
    AFNetworkActivityIndicatorManager *indicMa = [AFNetworkActivityIndicatorManager sharedManager];
    [indicMa setEnabled:YES];//设置状态栏网络指示器可见
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if ([name length]>0) {
        [self LoginAPI];
    }
    
    
    /**
     *  初始化底部导航框架
     *
     */
    _tabController=[[UITabBarController alloc] init];
    self.window.rootViewController=_tabController;
    
    IntelligentCashierVC *cashierVC = [[IntelligentCashierVC alloc] initWithNibName:@"IntelligentCashierVC" bundle:nil];
    cashierVC.tabBarItem.title=@"智能收银";
    cashierVC.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e601", 30, RGB(153, 153, 153))] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cashierVC.tabBarItem.selectedImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e601", 30, ThemeColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [cashierVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeBackgroundColor} forState:UIControlStateSelected];
    [cashierVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(153, 153, 153)} forState:UIControlStateNormal];
    
    
    BillStatisticsVC *bllVC = [[BillStatisticsVC alloc] initWithNibName:@"BillStatisticsVC" bundle:nil];
    bllVC.tabBarItem.title=@"账单统计";
    bllVC.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e605", 30, RGB(153, 153, 153))] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bllVC.tabBarItem.selectedImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e605", 30, ThemeColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [bllVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeBackgroundColor} forState:UIControlStateSelected];
    [bllVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(153, 153, 153)} forState:UIControlStateNormal];
    
    MessageVC *messageVC = [[MessageVC alloc] initWithNibName:@"MessageVC" bundle:nil];
    messageVC.tabBarItem.title=@"通知消息";
    messageVC.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e609", 30, RGB(153, 153, 153))] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageVC.tabBarItem.selectedImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e609", 30, ThemeColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [messageVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeBackgroundColor} forState:UIControlStateSelected];
    [messageVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(153, 153, 153)} forState:UIControlStateNormal];
    
    PersonalCenterVC *personVC = [[PersonalCenterVC alloc] initWithNibName:@"PersonalCenterVC" bundle:nil];
    personVC.tabBarItem.title=@"个人中心";
    personVC.tabBarItem.image = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e606", 30, RGB(153, 153, 153))] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    personVC.tabBarItem.selectedImage = [[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e606", 30, ThemeColor)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [personVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeBackgroundColor} forState:UIControlStateSelected];
    [personVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(153, 153, 153)} forState:UIControlStateNormal];
    
    
    self.intelligentNavController = [[UINavigationController alloc] initWithRootViewController:cashierVC];
    self.billStatisticsNavController = [[UINavigationController alloc] initWithRootViewController:bllVC];
    self.messageNavController = [[UINavigationController alloc] initWithRootViewController:messageVC];
    self.personalCenterNavController = [[UINavigationController alloc] initWithRootViewController:personVC];
    
    _tabController.viewControllers=@[self.intelligentNavController,self.billStatisticsNavController,self.messageNavController,self.personalCenterNavController];
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate*)App {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}



- (void) LoginAPI {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *password = [userDefault objectForKey:@"password"];
    
    LoginAPI *login = [[LoginAPI alloc]initWithUsername:name password:[JUtility md5:password]];
    [login startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    UserInfo *user = [UserInfo shareObject];
                    user.datatoken = [NSString stringWithFormat:@"%@",[dic objectForKey:@"token"]];
                    user.type = [[dic objectForKey:@"type"]integerValue];
                    [self BaseinfoAPI];
                    
                }
                    break;
                default:
                {
                    
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
        
        
    }];
    
}

- (void)BaseinfoAPI {
    BaseinfoAPI *basein = [[BaseinfoAPI alloc]initWith];
    [basein startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    UserInfo *user = [UserInfo shareObject];
                    [user mj_setKeyValues:dic];
                    user.isLogin = YES;
                   
                    
                }
                    break;
                default:
                {
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
        
    }];
    
    
}

@end
