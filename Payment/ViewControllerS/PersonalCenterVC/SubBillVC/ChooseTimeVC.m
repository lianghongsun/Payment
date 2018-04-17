//
//  ChooseTimeVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/3.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "ChooseTimeVC.h"
#import "GSPickerView.h"

@interface ChooseTimeVC ()

@property (nonatomic,strong)GSPickerView *pickerView;

@end

@implementation ChooseTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"我的账单";
    self.starttimeLab.text = self.begintime;
    self.endtimeLab.text = self.enttime;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)startAction:(id)sender {
    LRWeakSelf(self);
    NSDate *mindata;
    
    if (self.ismonth) {
        mindata = [JCAUtility DataWithTimestr:self.begintime formatStr:@"yyyy年MM月dd日"];
    }
    else{
        mindata = nil;
    }
    [self.pickerView appearWithTitle:@"开始时间" pickerType:GSPickerTypeDatePicker minimumDate:mindata subTitles:nil selectedStr:self.begintime sureAction:^(NSInteger path, NSString *pathStr) {
        weakself.starttimeLab.text = pathStr;
        weakself.begintime = pathStr;
    } cancleAction:^{
        
    }];

}

- (IBAction)endtimeAction:(id)sender {
     LRWeakSelf(self);
    NSDate *mindata;
    
    if (self.ismonth) {
        mindata = [JCAUtility DataWithTimestr:self.begintime formatStr:@"yyyy年MM月dd日"];
    }
    else{
        mindata = nil;
    }
    [self.pickerView appearWithTitle:@"结束时间" pickerType:GSPickerTypeDatePicker minimumDate:mindata subTitles:nil selectedStr:self.enttime sureAction:^(NSInteger path, NSString *pathStr) {
        weakself.endtimeLab.text = pathStr;
        weakself.enttime = pathStr;
    } cancleAction:^{
        
    }];
    
}

- (IBAction)queryAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.view.bounds];
    }
    return _pickerView;
}

@end
