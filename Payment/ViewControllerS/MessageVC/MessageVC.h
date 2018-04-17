//
//  MessageVC.h
//  Payment
//
//  Created by 噗噗 on 2018/3/31.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *systemmes;
@property (weak, nonatomic) IBOutlet UILabel *activitymes;
- (IBAction)systemAction:(id)sender;
- (IBAction)activityAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *newtableview;

@end
