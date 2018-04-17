//
//  AilpaybillVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/4.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AilpaybillVC : BaseViewController
@property (nonatomic,copy)NSString *titleStr;
@property (weak, nonatomic) IBOutlet UIView *backgrView;
@property (weak, nonatomic) IBOutlet UILabel *allgetLab;
@property (weak, nonatomic) IBOutlet UILabel *allgetnumLab;
@property (weak, nonatomic) IBOutlet UILabel *allgetpriceLab;
@property (weak, nonatomic) IBOutlet UILabel *billnumLab;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *navititle;

@end
