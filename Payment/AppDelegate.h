//
//  AppDelegate.h
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UINavigationController *intelligentNavController;
@property (strong,nonatomic) UINavigationController *billStatisticsNavController;
@property (strong,nonatomic) UINavigationController *messageNavController;
@property (strong,nonatomic) UINavigationController *personalCenterNavController;

/**
 *  自定义的 tabbar
 */
@property (nonatomic, strong) UITabBarController *tabController;

+ (AppDelegate*)App;

@end

