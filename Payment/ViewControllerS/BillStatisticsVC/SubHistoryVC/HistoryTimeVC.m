//
//  ChooseTimeVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/3.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "HistoryTimeVC.h"
#import "ITDatePickerController.h"

@interface HistoryTimeVC ()<ITDatePickerControllerDelegate>

@property (strong, nonatomic) NSDate *startDate;

@end

@implementation HistoryTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"历史账单";
    self.starttimeLab.text = self.choosetime;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)startAction:(id)sender {
    ITDatePickerController *datePickerController = [[ITDatePickerController alloc] init];
    datePickerController.tag = 100;                    // Tag, which may be used in delegate methods
    datePickerController.delegate = self;               // Set the callback object
    datePickerController.showToday = NO;                // Whether to show "today", default is yes
    datePickerController.defaultDate = self.startDate;  // Default date
    datePickerController.maximumDate = [NSDate date];    // maxinum date
    
    [self presentViewController:datePickerController animated:YES completion:nil];
    

}

- (IBAction)queryAction:(id)sender {
    if (self.choosetimeBlock) {
        self.choosetimeBlock(self.starttimeLab.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ITDatePickerControllerDelegate

- (void)datePickerController:(ITDatePickerController *)datePickerController didSelectedDate:(NSDate *)date dateString:(NSString *)dateString {
    self.starttimeLab.text = dateString;
    self.startDate = date;
}

@end
