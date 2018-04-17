//
//  BindingYHKVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/2.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindingYHKVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *addYHKbtn;
- (IBAction)addYHKAction:(id)sender;

- (IBAction)setdefaultAction:(id)sender;
- (IBAction)bindingAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
