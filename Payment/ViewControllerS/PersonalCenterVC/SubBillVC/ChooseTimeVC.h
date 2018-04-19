//
//  ChooseTimeVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/3.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseTimeVC;
typedef void (^ChoosetimeBlock) (NSString *begintime ,NSString *enttime);

@interface ChooseTimeVC : BaseViewController
@property (nonatomic,copy)NSString *begintime;
@property (nonatomic,copy)NSString *enttime;
@property (nonatomic,assign)BOOL ismonth;

@property (weak, nonatomic) IBOutlet UILabel *starttimeLab;
@property (weak, nonatomic) IBOutlet UILabel *endtimeLab;

- (IBAction)startAction:(id)sender;
- (IBAction)endtimeAction:(id)sender;
- (IBAction)queryAction:(id)sender;

//选中的回调
@property(nonatomic,copy)ChoosetimeBlock choosetimeBlock;

@end
