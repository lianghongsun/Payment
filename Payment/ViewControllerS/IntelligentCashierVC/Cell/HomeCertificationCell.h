//
//  HomeCertificationCell.h
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeCertificationCell;
typedef void (^reimbursemenBlock) (HomeCertificationCell *);
typedef void (^realnameBlock) (HomeCertificationCell *);
typedef void (^storeBlock) (HomeCertificationCell *);
typedef void (^todayBlock) (HomeCertificationCell *);

@interface HomeCertificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;

- (IBAction)reimbursementAction:(id)sender;
- (IBAction)realnameAction:(id)sender;
- (IBAction)storeAction:(id)sender;

- (IBAction)todayAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reimburBtn;
@property (weak, nonatomic) IBOutlet UIButton *relanBtn;

@property (weak, nonatomic) IBOutlet UIButton *storeBtn;

@property(nonatomic, copy) reimbursemenBlock reimbursementoBlock;
@property(nonatomic, copy) realnameBlock realnametoBlock;
@property(nonatomic, copy) storeBlock storetolock;
@property(nonatomic, copy) todayBlock todaytoBlock;

@property (weak, nonatomic) IBOutlet UIImageView *logimage;


@end
