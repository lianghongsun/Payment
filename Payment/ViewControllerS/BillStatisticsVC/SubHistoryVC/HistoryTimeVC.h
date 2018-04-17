//
//  ChooseTimeVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/3.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTimeVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *starttimeLab;
@property (copy, nonatomic) NSString *choosetime;

- (IBAction)startAction:(id)sender;
- (IBAction)queryAction:(id)sender;
@end
