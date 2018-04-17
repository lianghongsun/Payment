//
//  BaseViewController.m
//  dzm
//
//  Created by dzmmac on 14-9-25.
//  Copyright (c) 2014年 dzmmac. All rights reserved.
//

#import "BaseViewController.h"
 #import<AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航栏设置

    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:ThemeColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];//返回按钮只留<
    self.navigationController.navigationBar.tintColor = RGB(255, 255, 255);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :RGB(255, 255, 255)}];
}




/**
 *  设置侧边栏左侧按钮
 */
-(void)setIndexLeftBtn
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets inset   = UIEdgeInsetsMake(0, -15, 0, 0);
    leftButton.contentEdgeInsets = inset;
    leftButton.frame = CGRectMake(0, 0, 34, 34);
    [leftButton setImage:[UIImage imageNamed:@"ico_navigation_menu_nomal"] forState:UIControlStateNormal];
//    [leftButton setImage:[UIImage imageNamed:@"ico_navigation_menu_pressed"] forState:UIControlStateSelected];
    
    [leftButton addTarget:self action:@selector(indexLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc ] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
    
}

#pragma mark - 获取当前的时间
+ (NSString *)currentDateString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark - 按指定格式获取当前的时间
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr {
    // 获取系统当前时间
    NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}


#pragma mark - 横竖屏
-(BOOL)shouldAutorotate{//处理横屏播放
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
};

#pragma mark - 获取内容高度
+ (CGFloat)heightForString:(NSString *)string fontOfSize:(CGFloat)font lineSpace:(CGFloat)space forWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];//行间距5.f
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragraphStyle};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0)
                                       options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil];
    return rect.size.height;
}

#pragma mark ----------------左侧菜单按钮----------------------


- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)indexLeftBtnAction
{
   
}

/*
 * NavigationBar左侧返回按钮
 */
-(void)setLeftBtnItem
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets inset   = UIEdgeInsetsMake(5, -5, 5, 23);//0 -15 0 0
    leftButton.contentEdgeInsets = inset;
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//    [leftButton setImage:[UIImage imageNamed:@"ico_navigation_back_pressed"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc ] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
}


-(void)backCustomViewController:(NSString *)viewControllerName
{
//    for (UIViewController *controller in self.navigationController.viewControllers)
//    {
//        if ([controller isKindOfClass:NSClassFromString(viewControllerName)]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
}


// 要获取返回的Action需重写该方法
-(void)backAction
{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

/*
 *自定义导航左侧侧按钮
 */

-(void)setCustomLeftBtnItemWithImgName:(NSString *)imgName withTitle:(NSString *)title{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    leftButton.imageEdgeInsets = inset;
    
    if (imgName == nil){
        [leftButton setTitle:title forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
        [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -18, 0, 0)];
        leftButton.frame = CGRectMake(0, 0, 50, 35);
    }else
    {
        if (title&&title.length>0) {
            leftButton.frame = CGRectMake(0, 0, 34, 34);
            [leftButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        }else{
            leftButton.frame = CGRectMake(0, 0, 20, 20);
            [leftButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
            [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 16)];
        }
        
        
    }
    [leftButton addTarget:self action:@selector(leftItemAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left = [[UIBarButtonItem alloc ] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
}

-(void)leftItemAction
{
    
}


/*
 * 自定义导航右侧按钮
 */
-(void)setCustomRightBtnItemWithImgName:(NSString *)imgName withTitle:(NSString *)title
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    rightButton.imageEdgeInsets = inset;
    
    if (imgName == nil){
        [rightButton setTitle:title forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
        [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -18)];
         rightButton.frame = CGRectMake(0, 0, 50, 35);
    }else
    {
        rightButton.frame = CGRectMake(0, 0, 34, 34);
        [rightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];

    }
    [rightButton addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *right = [[UIBarButtonItem alloc ] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
}

-(void)rightItemAction
{
   
}

//设置吐槽页面左侧按钮
-(void)setVomitSoltLeftBtn
{
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets inset1 = UIEdgeInsetsMake(0, 0, 0, 0);
    self.cancelButton.contentEdgeInsets = inset1;
    self.cancelButton.frame = CGRectMake(0, 0, 30, 30);
    [self.cancelButton setImage:[UIImage imageNamed:@"ico_navigation_clean_nomal"] forState:UIControlStateNormal];
    [self.cancelButton setImage:[UIImage imageNamed:@"ico_navigation_clean_pressed"] forState:UIControlStateSelected];
    [self.cancelButton addTarget:self action:@selector(didClcikCancelItemButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc ] initWithCustomView:self.cancelButton];
    self.navigationItem.leftBarButtonItem = left;
    
}

//设置吐槽页面右侧按钮
-(void)setVomitSoltRightBtn
{
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.sendButton.contentEdgeInsets = inset;
    self.sendButton.frame = CGRectMake(0, 0, 30, 30);
    [self.sendButton setImage:[UIImage imageNamed:@"ico_navigation_done_nomal"] forState:UIControlStateNormal];
    [self.sendButton setImage:[UIImage imageNamed:@"ico_navigation_done_pressed"] forState:UIControlStateSelected];
    [self.sendButton addTarget:self action:@selector(didClickSendItemButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc ] initWithCustomView:self.sendButton];
    self.navigationItem.rightBarButtonItem = right;
    
}
- (void)didClickSendItemButton:(UIButton *)button
{
    
}

- (void)didClcikCancelItemButton:(UIButton *)button
{
    
}


// 隐藏额外的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


// 提示框
-(void)showTipViewWithMessage:(NSString *)message andTitles:(NSString *)title
{
    if (!title) {
        title = @"";
    }
    [[[UIAlertView alloc ] initWithTitle:title
                                 message:message
                                delegate:nil
                       cancelButtonTitle:@"确定"
                       otherButtonTitles:nil, nil]  show];
}


// 递归调用移除键盘
- (void)resignKeyBoardInView:(UIView *)view{
    for (UIView *v in view.subviews) {
        if ([v.subviews count] > 0){
            [self resignKeyBoardInView:v];
        }
        if ([v isKindOfClass:[UITextView class]] || [v isKindOfClass:[UITextField class]]){
            [v resignFirstResponder];
        }
    }
}

/**
 *  改变视图的约束
 *
 *  @param view           需要改变的视图
 *  @param constraintHeight 约束的尺寸
 */
-(void)changeConstraintWithView:(UIView *)view constraintHeight:(float)constraintHeight
{
    NSArray* constrains = view.constraints;
    for (NSLayoutConstraint* constraint in constrains) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = constraintHeight;
        }
    }
}
/**
 *  改变视图的约束
 *
 *  @param view           需要改变的视图
 *  @param constraintHeight 约束的尺寸
 */
-(void)changeConstraintWithView:(UIView *)view constraintWidth:(float)constraintWidth
{
    NSArray* constrains = view.constraints;
    for (NSLayoutConstraint* constraint in constrains) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            constraint.constant = constraintWidth;
        }
    }
}


#pragma mark-- 判断手机号是否合法
-(BOOL)phoneisMatchWith:(NSString*)phonenum
{
    if(phonenum==nil||[phonenum length]<=0){
        [self showTipViewWithMessage:nil andTitles:@"请输入手机号码"];
        return NO;
    }
    
    NSString *rule=@"^1(3|5|7|8|4)\\d{9}";
    NSPredicate* pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule];
    BOOL isMatch=[pred evaluateWithObject:phonenum];
    if (!isMatch) {
        //手机号码不正确
        [self showTipViewWithMessage:nil andTitles:@"请输入正确的手机号码"];
        return NO;
    }
    return YES;
}

#pragma mark 合成语音
- (void)syntheticVoice:(NSString *)string {
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  // 震动
    AudioServicesPlaySystemSound(1007);
    
    //  语音合成
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *speechUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
    //设置语言类别（不能被识别，返回值为nil）
    speechUtterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    //设置语速快慢
    speechUtterance.rate = 0.5;
    //语音合成器会生成音频
    [ synthesizer speakUtterance:speechUtterance];
}

- (void)showMessage:(NSString*)message viewHeight:(float)height;
{
    if(self)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        //        hud.dimBackground = YES;
        hud.detailsLabelText = message;
        hud.margin = 20.f;
        hud.yOffset = height;
        hud.opacity = 0.3;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}

-(void)showLoding:(NSString *)loadContent{
    
    if (HUD) {
        HUD.labelText = loadContent;
    }
    else{
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        //    HUD.dimBackground = YES;
        
        HUD.opacity = 0.3;
        
        
        [self.view addSubview:HUD];
        HUD.labelText = loadContent;
        [HUD show:YES];
    }
}


- (void)showWinMessage:(NSString*)message viewHeight:(float)height;
{
    if(self)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[AppDelegate App].window animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        //        hud.dimBackground = YES;
        hud.detailsLabelText = message;
        hud.margin = 20.f;
        hud.yOffset = height;
        hud.opacity = 0.3;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}

-(void)showWinLoding:(NSString *)loadContent{
    
    if (HUD) {
        HUD.labelText = loadContent;
    }
    else{
        
        HUD = [[MBProgressHUD alloc] initWithWindow:[AppDelegate App].window];
        //    HUD.dimBackground = YES;
        
        HUD.opacity = 0.3;
        
        
        [[AppDelegate App].window addSubview:HUD];
        HUD.labelText = loadContent;
        [HUD show:YES];
    }
}

-(void)closeLoding{
    if (HUD) {
        [HUD removeFromSuperview];
        HUD = nil;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}



@end
