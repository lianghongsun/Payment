//
//  SetGestureLockViewController.h
//  app
//
//  Created by 余钦 on 16/5/4.
//
//

#import <UIKit/UIKit.h>

@class SetGestureLockViewController;
typedef void (^SetpassBlock) (SetGestureLockViewController *);

typedef void (^NoticeSwitchOffBlock)(BOOL isCancel);

@interface SetGestureLockViewController : BaseViewController
@property(nonatomic, copy)NoticeSwitchOffBlock noticBlock;

@property(nonatomic, copy) SetpassBlock serpassBlock;

@end
