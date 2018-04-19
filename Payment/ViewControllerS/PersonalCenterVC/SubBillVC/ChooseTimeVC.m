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
    NSDate *maxdata;
    if (self.ismonth) {
        NSString *datastr = [JCAUtility getMonthBeginAndEndWith:[JCAUtility stringLastWithCurrentTime:@"yyyy年MM月dd日"]];
        
        mindata = [JCAUtility DataWithTimestr:datastr formatStr:@"yyyy年MM月dd日"];
        maxdata = [JCAUtility DataWithTimestr:[JCAUtility stringLastWithCurrentTime:@"yyyy年MM月dd日"] formatStr:@"yyyy年MM月dd日"];
    }
    else{
        mindata = nil;
        maxdata = [NSDate date];
    }
    [self.pickerView appearWithTitle:@"开始时间" pickerType:GSPickerTypeDatePicker minimumDate:mindata maxmumDate:maxdata subTitles:nil selectedStr:self.begintime sureAction:^(NSInteger path, NSString *pathStr) {
        weakself.starttimeLab.text = pathStr;
        weakself.begintime = pathStr;
    } cancleAction:^{
        
    }];

}

- (IBAction)endtimeAction:(id)sender {
     LRWeakSelf(self);
    
    NSDate *mindata;
    NSDate *maxdata;
    if (self.ismonth) {
        NSString *datastr = [JCAUtility getMonthBeginAndEndWith:[JCAUtility stringLastWithCurrentTime:@"yyyy年MM月dd日"]];
        
        mindata = [JCAUtility DataWithTimestr:datastr formatStr:@"yyyy年MM月dd日"];
        maxdata = [JCAUtility DataWithTimestr:[JCAUtility stringLastWithCurrentTime:@"yyyy年MM月dd日"] formatStr:@"yyyy年MM月dd日"];
    }
    else{
        mindata = nil;
        maxdata = [NSDate date];
    }
    [self.pickerView appearWithTitle:@"开始时间" pickerType:GSPickerTypeDatePicker minimumDate:mindata maxmumDate:maxdata subTitles:nil selectedStr:self.enttime sureAction:^(NSInteger path, NSString *pathStr) {
        weakself.endtimeLab.text = pathStr;
        weakself.enttime = pathStr;
    } cancleAction:^{
        
    }];
    
    
    
}

- (IBAction)queryAction:(id)sender {
    if ([JCAUtility compareDate:self.begintime withDate:self.enttime Formatstr:@"yyyy年MM月dd日"]==-1) {
        [self showTipViewWithMessage:@"开始时间不能大于结束时间，请重新选择" andTitles:@"温馨提示"];
        return;
    }
    
    if (self.choosetimeBlock) {
        self.choosetimeBlock(self.begintime, self.enttime);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.view.bounds];
    }
    return _pickerView;
}

@end
