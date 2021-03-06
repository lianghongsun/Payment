//
//  ChooseTimeVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/3.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HistoryTimeVC;
typedef void (^ChoosetimeBlock) (NSString *begintime,NSDate * choosedata);

@interface HistoryTimeVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *starttimeLab;
@property (copy, nonatomic) NSString *choosetime;
@property (strong, nonatomic) NSDate *startDate;

- (IBAction)startAction:(id)sender;
- (IBAction)queryAction:(id)sender;

//选中的回调
@property(nonatomic,copy)ChoosetimeBlock choosetimeBlock;

@end
