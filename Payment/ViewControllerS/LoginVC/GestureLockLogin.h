//
//  SetGestureLockViewController.h
//  app
//
//  Created by 余钦 on 16/5/4.
//
//

#import <UIKit/UIKit.h>

@class GestureLockLogin;
typedef void (^SetpassBlock) (GestureLockLogin *);

typedef void (^NoticeSwitchOffBlock)(BOOL isCancel);

@interface GestureLockLogin : BaseViewController
@property(nonatomic, copy)NoticeSwitchOffBlock noticBlock;
@property (nonatomic,assign)BOOL isloginout;
@property(nonatomic, copy) SetpassBlock serpassBlock;

@end
