//
//  SetGestureLockViewController.h
//  app
//
//  Created by 余钦 on 16/5/4.
//
//

#import <UIKit/UIKit.h>
@class ChangeGestureLockViewController;
typedef void (^SetnewpassBlock) (ChangeGestureLockViewController *);
typedef void (^NoticeSwitchOffBlock)(BOOL isCancel);

@interface ChangeGestureLockViewController : BaseViewController
@property(nonatomic, copy)NoticeSwitchOffBlock noticBlock;
@property(nonatomic, copy) SetnewpassBlock serpassBlock;
@end
