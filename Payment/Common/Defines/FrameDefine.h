//
//  FrameDefine.h
//  RuiTuEBusiness
//
//  Created by Naive on 2016/11/21.
//  Copyright © 2016年 Naive. All rights reserved.
//

//当前屏幕大小
#define SCREEN_SIZE   [[UIScreen mainScreen] bounds].size

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#define NAV_H  64.0f
#define XNAV_H  88.0f
#define cellHeight  40
#define TAbcell_H  50.0f

//底部Tab高度
#define TABBAR_HEIGHT  49.0f
#define XTABBAR_HEIGHT 83.0f
#define NewTABBAR_HEIGHT 0

#define kBaseLine(a) (CGFloat)a * SCREEN_W / 375.0

#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;

#define isIphone4sFor35 ([[UIScreen mainScreen] bounds].size.height <= 480)?YES:NO

#define isPhone5        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define isRetina        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(ScreenSize, [[UIScreen mainScreen] currentMode].size) : NO)
#define ISOS7           ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0?YES:NO)
#define ISOS8           (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))

// 判断是否为 iPhone 5
#define iPhone5 [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
