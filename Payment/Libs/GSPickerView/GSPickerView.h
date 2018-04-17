//
//  GSPickerView.h
//  GSPickerView
//
//  Created by ijointoo on 2017/10/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GSPickerTypeDatePicker,//时间选择器
    GSPickerTypeOneComponentPicker,//只有一行的选择器
} GSPickerType;

@interface GSPickerView : UIView

/** pickerView
 *  title 标题
 */
- (instancetype)initWithFrame:(CGRect)frame;

/** 显示
 *  pickerType picker的Type
 *  subTitles 数据源（GSDatePicker时可以为空）
 *  selectedStr 默认选中某一行（GSDatePicker时格式yyyy年MM月dd日）
 *  sure 确定的事件(GSDatePicker时 path为-1)
 *  cancle 取消的事件
 */
- (void)appearWithTitle:(NSString *)title pickerType:(GSPickerType)pickerType minimumDate:(NSDate *)minimumDate subTitles:(NSArray *)subTitles selectedStr:(NSString *)selectedStr sureAction:(void(^)(NSInteger path,NSString *pathStr))sure cancleAction:(void(^)(void))cancle;

- (void)disAppear;
@end
