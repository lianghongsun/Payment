//
//  ThendVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/18.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThendVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *backgrview;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIButton *timeBtn1;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn2;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn3;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn4;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn5;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn6;
- (IBAction)timeBtn1Action:(id)sender;
- (IBAction)timeBtn2Action:(id)sender;
- (IBAction)timeBtn3Action:(id)sender;
- (IBAction)timeBtn4Action:(id)sender;
- (IBAction)timeBtn5Action:(id)sender;
- (IBAction)timeBtn6Action:(id)sender;


@end
