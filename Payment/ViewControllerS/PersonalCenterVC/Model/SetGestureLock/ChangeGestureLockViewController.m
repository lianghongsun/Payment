//
//  SetGestureLockViewController.m
//  app
//
//  Created by 余钦 on 16/5/4.
//
//

#import "ChangeGestureLockViewController.h"
#import "GestureLockView.h"
#import "ForgetGesturesPassVC.h"

#define tipLabelFontSize 15

#define MarginY 10

#define TextColor [UIColor darkGrayColor]

@interface ChangeGestureLockViewController ()<GestureLockViewDelegate>
{
    UserInfo *user;
}

@property(nonatomic, weak)UILabel *tipLabel;
@property(nonatomic, weak)GestureLockView *gestureLockView;
@property(nonatomic, strong)UIButton *resetButton;
@property(nonatomic, copy)NSString *oldLockPath;
@property(nonatomic, copy)NSString *firstLockPath;
@property(nonatomic, copy)NSString *secondLockPath;
@end

@implementation ChangeGestureLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改手势密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self SetupSubviews];
    user = [UserInfo shareObject];
}

- (void)SetupSubviews{
    CGFloat mainViewW = self.view.frame.size.width;
    CGFloat mainViewH = self.view.frame.size.height;
    
    CGFloat smallLockViewW = 100.0f;
    CGFloat smallLockViewH = 100.0f;
    CGFloat smallLockViewX = (mainViewW - smallLockViewW)/2.0f;
    CGFloat smallLockViewY = 40.0f;
    
    
    CGFloat tipLabelH = 20.0f;
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, mainViewW, tipLabelH)];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.text = @"请绘制旧的解锁图案";
    tipLabel.textColor = TextColor;
    tipLabel.font = [UIFont systemFontOfSize:tipLabelFontSize];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    CGFloat lockViewW = self.view.frame.size.width;
    GestureLockView *lockView = [[GestureLockView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame) + MarginY, lockViewW, lockViewW)];
    lockView.delegate = self;
    [self.view addSubview:lockView];
    
    self.resetButton = [[UIButton alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(self.tipLabel.frame) + MarginY*2+lockViewW,lockViewW-200 , 30)];
   [self.resetButton addTarget:self action:@selector(ForgetPassAction) forControlEvents:UIControlEventTouchUpInside];
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"忘记手势密码"];
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    [tncString addAttribute:NSForegroundColorAttributeName value:ThemeColor  range:NSMakeRange(0,[tncString length])];
    [tncString addAttribute:NSUnderlineColorAttributeName value:ThemeColor range:(NSRange){0,[tncString length]}];
    [self.resetButton setAttributedTitle:tncString forState:UIControlStateNormal];
    [self.view addSubview:self.resetButton];
    self.gestureLockView = lockView;
    [self GetLockViewShot];
}

- (void)GetLockViewShot{
    //截图
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.gestureLockView.frame.size.width, self.gestureLockView.frame.size.height), YES, 0);     //设置截屏大小
    [[self.gestureLockView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
}

- (void)ClickCancelButton{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_noticBlock) {
        _noticBlock(YES);
    }
}

- (void)ClickResetButton{
    self.firstLockPath = @"";
    self.tipLabel.textColor = TextColor;
    self.tipLabel.text = @"请设置解锁图案";
    [self GetLockViewShot];
}

#pragma mark ----- GestureLockView delegate
- (void)lockView:(GestureLockView *)lockView BeganTouch:(NSSet *)touchs
{
    self.tipLabel.textColor = TextColor;
    if (self.oldLockPath) {
        if (self.firstLockPath) {
           self.tipLabel.text = @"请再次设置解锁图案";
        }
        else{
          self.tipLabel.text = @"请设置解锁图案";
        }
        
    }
    else{
       self.tipLabel.text = @"请绘制旧的解锁图案";
    }
}

- (void)lockView:(GestureLockView *)lockView didFinishPath:(NSString *)path shotImage:(UIImage *)shotImage
{
    if (path.length < 4) {
        self.tipLabel.textColor = [UIColor redColor];
        self.tipLabel.text = @"请连接至少4个点";
        return ;
    }
    if (self.oldLockPath) {
        if (self.firstLockPath.length) {
            if ([path isEqualToString:self.firstLockPath]) {
                self.tipLabel.textColor = TextColor;
                self.tipLabel.text = @"手势密码设置成功";
                [self SaveLockPath:path];
                user.oldgestures = path;
                if (self.serpassBlock) {
                    self.serpassBlock(self);
                }
                [self.navigationController popViewControllerAnimated:YES];
                if (_noticBlock) {
                    _noticBlock(NO);
                }
            }else{
                LRWeakSelf(self)
                self.tipLabel.textColor = [UIColor redColor];;
                self.tipLabel.text = @"两次图案绘制不一致";
                double delayInSeconds = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [weakself ClickResetButton];
                    
                });
            }
        }else{
            self.firstLockPath = [path copy];
            self.tipLabel.textColor = TextColor;
            self.tipLabel.text = @"请再次设置解锁图案";
        }
    }
    else{
        if (![[path copy]isEqualToString:user.oldgestures]) {
            self.tipLabel.textColor = [UIColor redColor];;
            self.tipLabel.text = @"与旧密码不一致";
            return ;
        }
        else{
         self.oldLockPath = [path copy];
            self.tipLabel.textColor = TextColor;
            self.tipLabel.text = @"请设置解锁图案";
        }
        
    }
}

- (void)ForgetPassAction {
    ForgetGesturesPassVC *vc = [[ForgetGesturesPassVC alloc]initWithNibName:@"ForgetGesturesPassVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)SaveLockPath:(NSString *)path{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:path forKey:@"LockPath"];
    [userDef synchronize];
}
@end
