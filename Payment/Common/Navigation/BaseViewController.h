//
//  BaseViewController.h
//  dzm
//
//  Created by dzmmac on 14-9-25.
//  Copyright (c) 2014年 dzmmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    MBProgressHUD   *HUD;

}
@property (nonatomic, strong) UIButton * cancelButton;
@property (nonatomic, strong) UIButton * sendButton;




/** 获取当前的时间 */
+ (NSString *)currentDateString;

/**
 *  获取内容高度
 */

+ (CGFloat)heightForString:(NSString *)string fontOfSize:(CGFloat)font lineSpace:(CGFloat)space forWidth:(CGFloat)width;

/**
 *  改变视图的约束
 *
 *  @param view           需要改变的视图
 *  @param constraintHeight 约束的尺寸
 */
-(void)changeConstraintWithView:(UIView *)view constraintHeight:(float)constraintHeight;

/**
 *  改变视图的约束
 *
 *  @param view           需要改变的视图
 *  @param constraintWidth 约束的尺寸
 */
-(void)changeConstraintWithView:(UIView *)view constraintWidth:(float)constraintWidth;
//设置吐槽页面左侧按钮
-(void)setVomitSoltLeftBtn;

//设置吐槽页面右侧按钮
-(void)setVomitSoltRightBtn;

/**
 * @brief  左侧返回按钮
 */
-(void)setLeftBtnItem;



/**
 *  设置侧边栏左侧按钮
 */
-(void)setIndexLeftBtn;

/*
 * 自定义导航左右侧按钮
 */

-(void)setCustomLeftBtnItemWithImgName:(NSString *)imgName withTitle:(NSString *)title;

-(void)setCustomRightBtnItemWithImgName:(NSString *)imgName withTitle:(NSString *)title;


// 隐藏额外的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView;

// 提示框
-(void)showTipViewWithMessage:(NSString *)message andTitles:(NSString *)title;

/**
 *  返回指定的vc
 *
 *  @param viewControllerName  viewControllerName
 */
-(void)backCustomViewController:(NSString *)viewControllerName;


// 递归调用移除键盘
- (void)resignKeyBoardInView:(UIView *)view;

#pragma mark-- 判断手机号是否合法
-(BOOL)phoneisMatchWith:(NSString*)phonenum;

#pragma mark-- 判断身份证号码是否合法
-(BOOL)checkUserID:(NSString *)userID;
#pragma mark 合成语音
- (void)syntheticVoice:(NSString *)string;
//MD5加密
+ (NSString *)md5:(NSString *)str;

#pragma mark - Hub
-(void)showLoding:(NSString *)loadContent;
-(void)showWinLoding:(NSString *)loadContent;
-(void)closeLoding;
-(void)showMessage:(NSString*)message viewHeight:(float)height;
- (void)showWinMessage:(NSString*)message viewHeight:(float)height;

- (void)goimageImagePicker;
@end
