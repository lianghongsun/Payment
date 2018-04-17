//
//  GSPickerView.m
//  GSPickerView
//
//  Created by ijointoo on 2017/10/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "GSPickerView.h"

@interface GSPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,assign)GSPickerType pickerType;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSArray *subTitles;
@property (nonatomic,strong)void(^sure)(NSInteger path,NSString *pathStr);
@property (nonatomic,strong)void(^cancle)(void);


@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)UIPickerView *picker;
@property (nonatomic,assign)NSInteger selectedRow;

@property (nonatomic,strong)NSDate *minimumDate;

@end

# define GSLog(fmt, ...) NSLog((@"[方法:%s____" "行:%d]\n " fmt),  __FUNCTION__, __LINE__, ##__VA_ARGS__);
/** 宽高*/
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/** window*/
#define kWindow [UIApplication sharedApplication].keyWindow

@implementation GSPickerView

- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 0, 60, 40);
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
- (void)cancleBtnAction{
    if (self.cancle) {
        self.cancle();
    }
    [self disAppear];
}
- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(kScreenWidth - 70, 0, 60, 40);
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (void)sureBtnAction{
    if (self.sure) {
        if (_pickerType != GSPickerTypeDatePicker) {
            self.sure(_selectedRow, _subTitles[_selectedRow]);
        }
        else{
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy年MM月dd日"];
            NSString *str = [formatter stringFromDate: _datePicker.date];
            
            self.sure(-1, str);
        }
    }
    [self disAppear];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, kScreenWidth - 140, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 200)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker.minimumDate = self.minimumDate;
        NSDate *currentDate = [NSDate date];
        _datePicker.maximumDate = currentDate;
    }
    return _datePicker;
}
- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 200)];
        _picker.backgroundColor = [UIColor whiteColor];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 240, kScreenWidth, 240)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.cancleBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sureBtn];
        [self addSingleTapGestures];
        
    }
    return self;
}
- (void)appearWithTitle:(NSString *)title pickerType:(GSPickerType)pickerType minimumDate:(NSDate *)minimumDate subTitles:(NSArray *)subTitles selectedStr:(NSString *)selectedStr sureAction:(void(^)(NSInteger path,NSString *pathStr))sure cancleAction:(void(^)(void))cancle{
    _titleLabel.text = title;
    _minimumDate = minimumDate;
    _pickerType = pickerType;
    _subTitles = subTitles;
    _sure = sure;
    _cancle = cancle;
    if (_pickerType != GSPickerTypeDatePicker) {
        if (_subTitles.count == 0)GSLog(@"GSPickerView数据源不可为空");
        if ([_subTitles containsObject:selectedStr]) {
            _selectedRow = [_subTitles indexOfObject:selectedStr];
            [self.picker selectRow:_selectedRow inComponent:0 animated:YES];
        }
        [self.contentView addSubview:self.picker];
        if ([self.contentView.subviews containsObject:self.datePicker]) {
            [self.datePicker removeFromSuperview];
        }
    }
    else{
        if (selectedStr) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy年MM月dd日"];
            NSDate *date = [formatter dateFromString:selectedStr];
            [self.datePicker setDate:date];
        }
        [self.contentView addSubview:self.datePicker];
        if ([self.contentView.subviews containsObject:self.picker]) {
            [self.picker removeFromSuperview];
        }
    }
    [kWindow addSubview:self];
}
- (void)disAppear{
    [self removeFromSuperview];
}

- (void)addSingleTapGestures {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:singleTap];
}

- (void)singleTap:(UITapGestureRecognizer *)sender {
    [self disAppear];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _subTitles.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _subTitles[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedRow = row;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
