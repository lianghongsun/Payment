//
//  WithdrpriceCell.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WithdrpriceCell;
typedef void (^TomoBlock) (WithdrpriceCell *);
typedef void (^TodayBlock) (WithdrpriceCell *);

@interface WithdrpriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backgroview;

@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UITextField *priceTx;
@property (weak, nonatomic) IBOutlet UIButton *tomoBtn;
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
- (IBAction)tomoAction:(id)sender;
- (IBAction)todayAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *poundageLab;

@property(nonatomic, copy) TomoBlock tomotoBlock;
@property(nonatomic, copy) TodayBlock todaytoBlock;

@end
