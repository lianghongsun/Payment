//
//  HoemfirstCell.h
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HoemfirstCell;
typedef void (^scanBlock) (HoemfirstCell *);
typedef void (^smartBlock) (HoemfirstCell *);
typedef void (^paymentBlock) (HoemfirstCell *);

@interface HoemfirstCell : UITableViewCell

- (IBAction)scanAction:(id)sender;
- (IBAction)smartCodeAction:(id)sender;
- (IBAction)paymentCodeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UIButton *smartBtn;
@property (weak, nonatomic) IBOutlet UIButton *paymentBtn;

@property (weak, nonatomic) IBOutlet UILabel *navititleLab;

@property(nonatomic, copy) scanBlock scantoBlock;
@property(nonatomic, copy) smartBlock smarttoBlock;
@property(nonatomic, copy) paymentBlock paymenttoBlock;

@end
