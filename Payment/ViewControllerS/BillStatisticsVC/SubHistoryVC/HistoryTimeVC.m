//
//  ChooseTimeVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/3.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "HistoryTimeVC.h"

@interface HistoryTimeVC ()

@end

@implementation HistoryTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"历史账单";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)startAction:(id)sender {
    LRWeakSelf(self);

}



- (IBAction)queryAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
