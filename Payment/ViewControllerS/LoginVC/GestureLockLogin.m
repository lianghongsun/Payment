//
//  SetGestureLockViewController.m
//  app
//
//  Created by 余钦 on 16/5/4.
//
//

#import "GestureLockLogin.h"
#import "GestureLockView.h"
#import "BaseinfoAPI.h"
#import "LoginAPI.h"
#import "LoginVC.h"
#import "HcdGuideView.h"

#define tipLabelFontSize 15

#define MarginY 10

#define TextColor [UIColor darkGrayColor]

@interface GestureLockLogin ()<GestureLockViewDelegate>
{
    UserInfo *user;
    NSString*isLockPath;
}
@property(nonatomic, weak)UIImageView *lockViewShotView;
@property(nonatomic, weak)UILabel *tipLabel;
@property(nonatomic, weak)GestureLockView *gestureLockView;
@property(nonatomic, strong)UIButton *resetButton;

@end

@implementation GestureLockLogin

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    isLockPath = [userDefault objectForKey:@"LockPath"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势密码解锁";
    self.view.backgroundColor = [UIColor whiteColor];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSMutableArray *images = [NSMutableArray new];
        
        [images addObject:[UIImage imageNamed:@"欢迎页1"]];
        [images addObject:[UIImage imageNamed:@"欢迎页2"]];
        [images addObject:[UIImage imageNamed:@"欢迎页3"]];
        
        [[HcdGuideViewManager sharedInstance] showGuideViewWithImages:images
                                                       andButtonTitle:@"立即体验"
                                                  andButtonTitleColor:ThemeColor
                                                     andButtonBGColor:[UIColor clearColor]
                                                 andButtonBorderColor:ThemeColor];
        
    }
    
    [self SetupSubviews];
    user = [UserInfo shareObject];
}

- (void)SetupSubviews{
    CGFloat mainViewW = self.view.frame.size.width;
    
    
    CGFloat smallLockViewW = 60.0f;
    CGFloat smallLockViewH = 60.0f;
    CGFloat smallLockViewX = (mainViewW - smallLockViewW)/2.0f;
    CGFloat smallLockViewY = 20.0f;
    UIImageView *lockViewShotView = [[UIImageView alloc] init];
    lockViewShotView.frame = CGRectMake(smallLockViewX, smallLockViewY, smallLockViewW, smallLockViewH);
    [self.view addSubview:lockViewShotView];
    self.lockViewShotView = lockViewShotView;
    
    CGFloat tipLabelH = 20.0f;
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lockViewShotView.frame) + MarginY, mainViewW, tipLabelH)];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.text = @"手势密码解锁";
    tipLabel.textColor = TextColor;
    tipLabel.font = [UIFont systemFontOfSize:tipLabelFontSize];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    NSInteger  withnum;
    if (iPhone6Plus_6sPlus) {
        withnum = 400;
    }
    else if (IsiPhoneX){
        withnum = 350;
    }
    else{
        withnum =  250;
    }
    CGFloat lockViewW = self.view.frame.size.width;
    GestureLockView *lockView = [[GestureLockView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.tipLabel.frame) + MarginY, lockViewW-20, withnum)];
    lockView.delegate = self;
    [self.view addSubview:lockView];
    self.gestureLockView = lockView;
    self.resetButton = [[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.tipLabel.frame) + MarginY*2+withnum+20,lockViewW-80 , 30)];
    [self.resetButton addTarget:self action:@selector(ForgetPassAction) forControlEvents:UIControlEventTouchUpInside];
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"切换密码登录"];
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    [tncString addAttribute:NSForegroundColorAttributeName value:ThemeColor  range:NSMakeRange(0,[tncString length])];
    [tncString addAttribute:NSUnderlineColorAttributeName value:ThemeColor range:(NSRange){0,[tncString length]}];
    [self.resetButton setAttributedTitle:tncString forState:UIControlStateNormal];
    [self.view addSubview:self.resetButton];
    
    
    [self GetLockViewShot];
}

- (void)GetLockViewShot{
    //截图
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.gestureLockView.frame.size.width, self.gestureLockView.frame.size.height), YES, 0);     //设置截屏大小
    [[self.gestureLockView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.lockViewShotView.image = shotImage;
}

- (void)ClickCancelButton{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_noticBlock) {
        _noticBlock(YES);
    }
}

- (void)ForgetPassAction {
    LoginVC *vc = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
    UINavigationController *naiv = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:naiv animated:YES completion:nil];
    
}
- (void)ClickResetButton{
    self.tipLabel.textColor = TextColor;
    self.tipLabel.text = @"手势密码解锁";
    [self GetLockViewShot];
}

#pragma mark ----- GestureLockView delegate
- (void)lockView:(GestureLockView *)lockView BeganTouch:(NSSet *)touchs
{
    self.tipLabel.textColor = TextColor;
    self.tipLabel.text = @"手势密码解锁";
}

- (void)lockView:(GestureLockView *)lockView didFinishPath:(NSString *)path shotImage:(UIImage *)shotImage
{
    if (path.length < 4) {
        self.tipLabel.textColor = [UIColor redColor];
        self.tipLabel.text = @"请连接至少4个点";
        return ;
    }
    
    
    if ([path isEqualToString:isLockPath]) {
            self.tipLabel.textColor = TextColor;
            self.tipLabel.text = @"手势密码正确";
            [self LoginAPI];
            if (self.serpassBlock) {
                self.serpassBlock(self);
            }
            if (_noticBlock) {
                _noticBlock(NO);
            }
        }else{
            LRWeakSelf(self)
            self.tipLabel.textColor = [UIColor redColor];;
            self.tipLabel.text = @"手势密码不正确";
            double delayInSeconds = 0.5;
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 [weakself ClickResetButton];
                
            });
        }
    
    
    
}

- (void)SaveLockPath:(NSString *)path{
    
    
}

- (void) LoginAPI {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *password = [userDefault objectForKey:@"password"];
    
    [self showLoding:@"正在登录"];
    LoginAPI *login = [[LoginAPI alloc]initWithUsername:name password:[JUtility md5:password]];
    [login startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseJSONObject;
            NSInteger responseCode = [[dic objectForKey:@"retcode"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    NSInteger Code = [[datadic objectForKey:@"code"] integerValue];
                    
                    switch (Code) {
                        case SubRequestStatusSuccess:
                        {
                            UserInfo *user = [UserInfo shareObject];
                            user.datatoken = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"token"]];
                            user.type = [[datadic objectForKey:@"type"]integerValue];
                            [self BaseinfoAPI];
                        }
                        break;
                            
                        default:
                        {
                            NSString *mesgStr = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]];
                            [self showMessage:mesgStr viewHeight:0];
                        }
                            break;
                    }
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self closeLoding];
        
        
    }];
    
}

- (void)BaseinfoAPI {
    BaseinfoAPI *basein = [[BaseinfoAPI alloc]initWith];
    [basein startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseJSONObject;
            NSInteger responseCode = [[dic objectForKey:@"retcode"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    NSDictionary *datadic = [dic objectForKey:@"data"];
                    NSInteger Code = [[datadic objectForKey:@"code"] integerValue];
                    switch (Code) {
                        case SubRequestStatusSuccess:
                        {
                            UserInfo *user = [UserInfo shareObject];
                            [user mj_setKeyValues:datadic];
                            user.isLogin = YES;
                            
                            if (self.isloginout) {
                                [self dismissViewControllerAnimated:YES completion:nil];
                            }
                            else{
                                APPDELEGATE;
                                [self presentViewController:del.tabController animated:YES completion:nil];
                            }
                        }
                            break;
                            
                        default:
                        {
                            NSString *mesgStr = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]];
                            [self showMessage:mesgStr viewHeight:0];
                        }
                            break;
                    }
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:100];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
        
    }];
    
    
}

@end
