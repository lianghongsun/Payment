//
//  XNBUtility.h
//  CarWash
//
//  Created by Trinstan on 19/5/15.
//  Copyright (c) 2015 Xiao Niu Bang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
@interface JCAUtility : NSObject

#define wordOrangeColor [UIColor colorWithRed:252.0/255.0 green:98.0/255.0 blue:32.0/255.0 alpha:1.0]
#define wordlightGrayColor [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1.0]


+ (UIImage *)resetImage:(UIImage *)image;

//生成m5 的字符串
+ (NSString *)generateM5StringWithDictionary:(NSMutableDictionary *)dic withAPI:(NSString *)api;

//生成固定的  字典
+ (NSMutableDictionary *)baseDictionary;







#pragma mark - 微信授权数据
+ (void)saveWechatDictionary:(NSDictionary *)wechatDic;
+ (NSDictionary *)getWechatDictionary;

#pragma mark - 放大图片
+ (void)showBigImage:(UIButton *)avatarImageView;
+(void)showMJPhoto:(NSArray *)slideImages index:(NSInteger)index;

#pragma mark - 不备份数据
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

+ (NSString *)getUserFilePath;

#pragma mark - 根据16进制来获取颜色
+ (UIColor *)getColor:(NSString *)hexColor;

+ (NSString *)isFirstFilePath;

#pragma mark - 获取版本号
+ (NSString *)versionCode;

#pragma mark- 订单状态里面时间戳的转化
+ (NSString *)timeTranferInDictionary:(NSDictionary *)item withStatus:(NSString *)status;

#pragma mark - 设置配置的UI色调
+ (UIColor *)themeColor;
+ (UIColor *)themeLineColor;
+ (UIColor *)themePlaceholderColor;
+ (UIColor *)themeTextDarkColor;
+ (UIColor *)themeTextLightColor;
+ (UIColor *)themebgColor;
+ (UIColor *)themetextColor;
+ (UIColor *)themesortBtnColor;
+ (UIColor *)themesortUnBtnColor;
//送标签的背景颜色
+ (UIColor *)deliverBgColor;
//抵用券标签的背景颜色
+ (UIColor *)couponBgColor;
//立减标签的背景颜色
+ (UIColor *)discountBgColor;
//打折标签的背景颜色
+ (UIColor *)shopDiscountBgColor;
//不进行四舍五入（到小数点后面两位）
+(NSString *)notRounding:(double)price;

// 时间戳转字符串
+(NSString *)stringWithTime:(double)time formatStr:(NSString *)formatstr;
// 字符串转Data
+(NSDate *)DataWithTimestr:(NSString *)time formatStr:(NSString *)formatstr;
// Data转字符串
+(NSString *)stringWithData:(NSDate *)data formatStr:(NSString *)formatstr;
// 根据Data获取星期几
+(NSString *)weeksWithData:(NSDate *)data;
// 时间戳转字符串
+(NSString *)stringWithTimeInterval:(NSString *)time;

// string的时间分段成为时分格式
+(NSString *)stringWithHoursandmintues:(NSString *)time;

// 获取当前时间
+(NSString *)stringWithCurrentTime:(NSString *)formatstr;

// 获取当前时间前一天
+(NSString *)stringLastWithCurrentTime:(NSString *)formatstr;

// 获取当前月份第一天
+(NSString *)getMonthBeginAndEndWith:(NSString *)dateStr;
// 获取上个月第一天
+ (NSString *)getLastMonthBeginWith:(NSString *)dateStr Formatstr:(NSString *)formatstr;
// 获取上个月最后一天
+ (NSString *)getLastMonthEndWith:(NSString *)dateStr Formatstr:(NSString *)formatstr;

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;

//判断是否为空
+ (BOOL)isBlankString:(id)object;

+(NSMutableArray *)setNullDic:(NSArray *)arr;
+(NSString *)changeJsonString:(NSArray *)servicesList andServiceId:(NSString *)service_id;
+(NSString*)convertDateFromString:(NSString*)uiDate;

+(NSString *)getBalance:(NSString *)total andOrderPrice:(NSString *)orderPrice;

+(UILabel *)configSubsidy:(UILabel *)label andText:(NSString *)labelText;
+(BOOL)SystemVideoJurisdiction;
+ (BOOL)deptNumInputShouldNumber:(NSString*)string;
+(BOOL)deptNumInputNum:(NSString *)stringNo;
+(NSString *)addCardNoSpace:(NSString *)cardNo;
+(NSString*)URLDecodedString:(NSString*)str;
+(NSString *)jsonString:(NSString *)str_Json;
@end
