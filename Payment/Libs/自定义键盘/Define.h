//
//  Define.h
//  Xunbao2
//
//  Created by Jason on 15/7/20.
//  Copyright (c) 2015年 Jason. All rights reserved.
//

#ifndef Xunbao2_Define_h
#define Xunbao2_Define_h


#ifdef DEBUG // 调试状态, 打开LOG功能
#define YBLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define YBLog(...)
#endif

//注册
#define kRegisterNib(nibName) [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName]





// 弱引用
#define YBWeakSelf __weak typeof(self) weakSelf = self;

/**
 *  沙盒Document路径
 */
#define kDocumentPath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])

/**
 *  沙盒Cache路径
 */
#define kCachePath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])
/**
 *  屏幕高度
 */
#define kScreenH ([UIScreen mainScreen].bounds.size.height)

/**
 *  屏幕宽度
 */
#define kScreenW ([UIScreen mainScreen].bounds.size.width)


/**
 *  弧度转角度
 */
#define kRADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

/**
 *  角度转弧度
 */
#define kDEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

// 颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define KColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 随机色
#define kRandomColor kColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 是否为4inch
#define FourInch ([UIScreen mainScreen].bounds.size.height >= 568.0)

//导航栏主题颜色
//#define kNavColor KColorFromRGB(0x282e3c)
//#define kNavColor kColor(217, 62, 0)
//#define kNavColor KColorFromRGB(0x2bb8aa)
//#define kNavColor kColor(43, 184, 170)
#define kNavColor [UIColor groupTableViewBackgroundColor]
#define kNavColor2 kColor(20,118,235)
#define kGrayColor KColorFromRGB(0x007aff)
#define kOrangeColor KColorFromRGB(0xffa200)
#define kBlueColor KColorFromRGB(0x007aff)
#define kGreenColor kColor(40,208,77)
#define kYellowColor kColor(229, 155, 37)

#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
#define kBundleIdentifier [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"]

/** 表情相关 */
// 表情的最大行数
#define HMEmotionMaxRows 3
// 表情的最大列数
#define HMEmotionMaxCols 7
// 每页最多显示多少个表情
#define HMEmotionMaxCountPerPage (HMEmotionMaxRows * HMEmotionMaxCols - 1)

// 表情选中的通知
#define HMEmotionDidSelectedNotification @"HMEmotionDidSelectedNotification"
//点击发送的通知
#define HMEmotionDidSendNotification @"HMEmotionDidSendNotification"
// 点击删除按钮的通知
#define HMEmotionDidDeletedNotification @"HMEmotionDidDeletedNotification"
// 通知里面取出表情用的key
#define HMSelectedEmotion @"HMSelectedEmotion"

//每一页的数据
#define kLimit @(10)

//停止加载数据动态图（CollectionView）
#define kLoadDataHeaderEndStopForCollectionView  if([weakSelf respondsToSelector:@selector(collectionView)]){[weakSelf.view stop];[weakSelf.collectionView stop]; [weakSelf.collectionView.mj_header endRefreshing];}

#define kLoadDataHeaderEnd if([weakSelf respondsToSelector:@selector(tableView)]){[weakSelf.view stop];[weakSelf.tableView stop]; [weakSelf.tableView.mj_header endRefreshing];}
#define kloadDataFooterEnd [weakSelf.tableView.mj_footer endRefreshing];

#define kSetupMJ_footer_loadData(selectorName) weakSelf.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{\
[weakSelf selectorName];\
}];\
if (arr.count<kLimit.integerValue) {\
    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];\
} else {\
    [weakSelf.tableView.mj_footer resetNoMoreData];\
}\
\
[weakSelf.tableView reloadData];\
weakSelf.page=2;


#define kSetupMJ_footer_loadMoreData if (arr.count<kLimit.integerValue) {\
[weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];\
} else {\
    [weakSelf.tableView.mj_footer resetNoMoreData];\
}\
[weakSelf.tableView reloadData];\
weakSelf.page++;

//设置下拉刷新
#define kSetupRefreshNormalHeader self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{\
    [weakSelf loadData];\
}];

//设置返回按钮
#define kSetupBackItem UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];negativeSpacer.width = -5;self.navigationItem.leftBarButtonItems = @[negativeSpacer, [UIBarButtonItem backItemWithTarget:self action:@selector(back)]];
#define kSetupBackWhiteItem UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];negativeSpacer.width = -5;self.navigationItem.leftBarButtonItems = @[negativeSpacer, [UIBarButtonItem backWhiteItemWithTarget:self action:@selector(back)]];

//判断是否是当前的控制器  如果不是就不执行后面的逻辑了
#define kIsTopViewController if (weakSelf.navigationController.topViewController != self) return;


#define kHeightForSection 9

#define LableFont [UIFont systemFontOfSize:16.0]

//刷选大盘
#define kFilterTapeArr @"kFilterTapeArr"

#define kPaySuccessNotification @"kPaySuccessNotification"//支付宝支付成功
#define kPayFailureNotification @"kPayFailureNotification"//支付宝支付失败
#define kPayCancelNotification @"kPayCancelNotification"//支付宝支付取消
#define kLoginSuccessNotification @"kLoginSuccessNotification"//登录成功
#define kLogoutNotification @"kLogoutNotification"//登出
#define kReceiveRemoteNotification @"kReceiveRemoteNotification"//收到推送
#define kIAPSuccessNotification @"kIAPSuccessNotification"//内购成功

#define kJPushRegistrationID @"kJPushRegistrationID"

#define kCustomer_Service_Phone @"0755-23226548" //客服电话

#define kShowColourBackImage    @"showColourBackImage"     //换肤自定义纯色图片
#define kUseStateForImage       @"useStateForImage"        //自定义纯色皮肤状态
#define kPeculiarityPhoto       @"PeculiarityPhoto"        //换肤自定义个性图片
#define kPeculiarityPhotoStante @"PeculiarityPhotoStante"  //自定义个性图片状态

//我要交流时间段
#define kExchangeStartTime1 (9*3600 + 30*60)
#define kExchangeEndTime1 (11*3600 + 30*60)
#define kExchangeStartTime2 (13*3600)
#define kExchangeEndTime2 (15*3600)

#define kShareImageURL @"http://yy-img.iswcc.com/ysh/180x180.png"//分享的图片地址


//巡回人转发标记
#define kDD_MESSAGE_TEXT_ITINERATE_PREFIX @"&$#@~%^&$#^(^&^@[{:"
#define kDD_MESSAGE_TEXT_ITINERATE_SUFFIX @":}]&$~*&^%#%@&%^$$#"

//分享团队转发标记
#define kDD_MESSAGE_TEXT_SHARE_TEAM_PREFIX @"&&*#(@SDAD(*ASD)(@$%"
#define kDD_MESSAGE_TEXT_SHARE_TEAM_SUFFIX @"()@*#&!@HASDASD(@*@#"

//用户进来看直播标记
#define kDD_MESSAGE_TEXT_SEE_LIVE_PREFIX @"*(&*%$&^&**(%%^$"
#define kDD_MESSAGE_TEXT_SEE_LIVE_SUFFIX @"#$&^%&(*)(*(_)^%"

//机器人发弹幕的标记
#define kDD_MESSAGE_TEXT_ROBOT_SEND_PREFIX @"~#@.@..@^%*$V<>!"
#define kDD_MESSAGE_TEXT_ROBOT_SEND_SUFFIX @"#@m@p;l@^**%*$!"

//互动小工具标记
#define kDD_MESSAGE_TEXT_Interaction_PREFIX @"$#%$^(_*^&@!$)&&&(*"
#define kDD_MESSAGE_TEXT_Interaction_SUFFIX @"H!@$@#^&%^&)G^(&*^$"

//礼物标记
#define kDD_MESSAGE_TEXT_GIFT_PREFIX @"---**#22%^&++()()..."
#define kDD_MESSAGE_TEXT_GIFT_SUFFIX @".%..!#@&&&))))(((("

//直播弹幕群标记
#define kDD_SESSION_NAME_PREFIX @"#-*!.~"
#define kDD_SESSION_NAME_SUFFIX @"++-*!%"

#define kAPPID @"1153938790"

#define kNOFirstTimeKey @"kNOFirstTimeKey"
#define kVersionKey @"kVersionKey"
#define kLoginBgImgUrl @"http://swimgs.iswcc.cn/tgimage/bg/loginbg.png"


#define kFirAutoCheckUpdateEnabel 0//1表示需要检测 0表示不需要检测内部更新

#if 0 //0表示测试环境 1表示正式环境
#define kAPI_URL @"http://appapi.iswcc.com/"   //接口
#define kAPI_BACK_URL @"http://swpay.iswcc.com/"//支付回调
#define kHTML_URL @"http://appweb.iswcc.com/"   //html  wap页面
#define SERVER_ADDR @"http://im.iswcc.com:7080/msg_server" //IM服务器
#else
#define kAPI_URL @"http://appapi.iswcc.cn/"  //外网接口
//#define kAPI_URL @"http://192.168.1.155:8081/api/" //本地
#define kAPI_BACK_URL @"http://swpay.iswcc.cn/"//支付回调
#define kHTML_URL @"http://appweb.iswcc.cn/"  //html WAP页面
#define SERVER_ADDR @"http://120.25.240.146:8080/msg_server" //IM服务器

#endif

/******邮轮活动*****/
#define kYLHD_PAY_API_URL @"http://swpay.iswcc.com/" //邮轮活动支付API
#define kYLHD_API_URL @"http://wxapi.iswcc.com/"//邮轮活动API
//#define kYLHD_API_URL @"http://10.16.72.11:8081/wechat/"



#endif
