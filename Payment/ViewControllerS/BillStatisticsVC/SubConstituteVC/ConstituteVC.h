//
//  ConstituteVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/8.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConstituteVC : UIViewController

- (IBAction)choosetimeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *totalrevenueLab;
@property (weak, nonatomic) IBOutlet UIView *backgrView;
@property (weak, nonatomic) IBOutlet UILabel *weixinincomeLab;
@property (weak, nonatomic) IBOutlet UILabel *ailpayincomeLab;
@end
