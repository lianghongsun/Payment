//
//  XNBUtility.m
//  CarWash
//
//  Created by Trinstan on 19/5/15.
//  Copyright (c) 2015 Xiao Niu Bang. All rights reserved.
//

#import "JCAUtility.h"
#import <AVFoundation/AVFoundation.h>

@implementation JCAUtility

+ (UIImage *)resetImage:(UIImage *)image
{
    CGFloat height = (image.size.height > image.size.width) ? image.size.width :image.size.height;
    CGFloat x = (image.size.height > image.size.width) ? 0 : image.size.width/2 - image.size.height/2;
    CGFloat y = (image.size.height > image.size.width) ? image.size.height/2 - image.size.width/2 :0;
    CGRect rect = CGRectMake(x, y, height, height);//创建矩形框
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
}

//生成m5 的字符串
+ (NSString *)generateM5StringWithDictionary:(NSMutableDictionary *)dict withAPI:(NSString *)api
{
    NSMutableString *contentString  =[NSMutableString string];
    [contentString appendFormat:@"%@?", api];
    
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if ( ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //删除最后一个 & 字符
    NSString *contentStr  = [contentString substringToIndex:contentString.length-1];
    
    contentString = [NSMutableString stringWithString:contentStr];
    //添加 _2014hofysoft_ios
    [contentString appendFormat:@"_2014hofysoft_ios"];
    
    //得到MD5 sign签名
    NSString *md5Sign =[JUtility md5:contentString];
    
    NSLog(@"md5Sign===%@",contentString);
    
    return [md5Sign lowercaseString];
}

+ (NSMutableDictionary *)baseDictionary
{
//    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   // NSDate *datenow=[NSDate date];
   // NSString *timeSp =[NSString stringWithFormat:@"%ld",(long)[datenow timeIntervalSince1970]];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"testBase" forKey:@"appVersion"];
    [dic setObject:@"eclipse" forKey:@"phoneModel"];
    [dic setObject:@"Java" forKey:@"platformType"];
    [dic setObject:@"" forKey:@"accessToken"];
//    [dic setObject:[XNBUtility versionCode] forKey:@"appVersion"];
//    [dic setObject:[XNBUtility getIOSVersion] forKey:@"sysVersion"];
//    [dic setObject:del.sessionid?del.sessionid:@"" forKey:@"sessionId"];
    
    return dic;
}

+ (NSString *)getIOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}




#pragma mark - 放大图片
static CGRect oldframe;
+(void)showBigImage:(UIButton *)avatarImageView{
    UIImage *image=avatarImageView.currentImage;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

+(void)showMJPhoto:(NSArray *)slideImages index:(NSInteger)index
{
   

}

#pragma mark - 不备份数据
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}


+ (NSString *)getUserFilePath{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *paths=[path objectAtIndex:0];
    NSString *filename=[paths stringByAppendingPathComponent:@"user.plist"];
    return filename;
}

#pragma mark - 微信授权数据
+ (void)saveWechatDictionary:(NSDictionary *)wechatDic
{
    [[NSUserDefaults standardUserDefaults] setObject:wechatDic forKey:@"wechatDic"];
}

+ (NSDictionary *)getWechatDictionary
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"wechatDic"];
    
    return dic;
}

#pragma mark - 根据16进制来获取颜色
+ (UIColor *)getColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

+ (NSString *)isFirstFilePath{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *paths=[path objectAtIndex:0];
    NSString *filename=[paths stringByAppendingPathComponent:@"isnewFirst.plist"];
    return filename;
}

#pragma mark - 获取版本号
+ (NSString *)versionCode
{
    NSDictionary *infoDict = nil;
    infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *strBundleName = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return strBundleName;
}


#pragma mark - 设置配置的UI色调

+ (UIColor *)themeColor
{
    //红#df3031
    return [JCAUtility getColor:@"5a8cdc"];
   
}
+ (UIColor *)themetextColor
{
    //字体的主颜色
    return [JCAUtility getColor:@"ea3232"];
    
}

+ (UIColor *)themeLineColor
{
    //分隔线#d7d7d7
    return [JCAUtility getColor:@"e5e5e5"];
}

+ (UIColor *)themePlaceholderColor
{
    //未输入字符#c7c7cc
    return [JCAUtility getColor:@"c7c7cc"];
}

+ (UIColor *)themeTextDarkColor
{
    //黑色#222222
    return [JCAUtility getColor:@"333333"];
}

+ (UIColor *)themeTextLightColor
{
    //深灰#898989
    return [JCAUtility getColor:@"969696"];
}

+ (UIColor *)themebgColor
{
    return [JCAUtility getColor:@"f7f7f7"];;

}

//排序选中字体颜色
+ (UIColor *)themesortBtnColor
{
    return [self themeColor];
}

//排序未选中字体颜色
+ (UIColor *)themesortUnBtnColor
{
    return [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1];
}

//打折标签的背景颜色
+ (UIColor *)shopDiscountBgColor
{
    return [UIColor colorWithRed:194.0/255.0 green:90.0/255.0 blue:253.0/255.0 alpha:1];
}

//立减标签的背景颜色
+ (UIColor *)discountBgColor
{
    return [UIColor colorWithRed:231.0/255.0 green:121.0/255.0 blue:170.0/255.0 alpha:1];
}

//抵用券标签的背景颜色
+ (UIColor *)couponBgColor
{
    return [UIColor colorWithRed:106.0/255.0 green:173.0/255.0 blue:249.0/255.0 alpha:1];
}

//送标签的背景颜色
+ (UIColor *)deliverBgColor
{
    return [UIColor colorWithRed:236.0/255.0 green:137.0/255.0 blue:66.0/255.0 alpha:1];
}
//不进行四舍五入（到小数点后面两位）
+(NSString *)notRounding:(double)price
{
    NSString *doubleString = [NSString stringWithFormat:@"%lf", price];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [NSString stringWithFormat:@"%.2f",[decNumber doubleValue]];
//    return [NSString stringWithFormat:@"%.2f",floor(price * 100)/100];
}

// 时间戳转字符串
+(NSString *)stringWithTime:(double)time formatStr:(NSString *)formatstr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:formatstr];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSTimeInterval newTime = time/1000 ;//13位转10位方法（／1000）
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:newTime];
    
    return [formatter stringFromDate:confromTimesp];
}

// 字符串转Data
+(NSDate *)DataWithTimestr:(NSString *)time formatStr:(NSString *)formatstr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:formatstr];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    return [formatter dateFromString:time];
    
}
// Data转字符串
+(NSString *)stringWithData:(NSDate *)data formatStr:(NSString *)formatstr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatstr];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    return [formatter stringFromDate:data];
}

// 根据Data获取星期几
+(NSString *)weeksWithData:(NSDate *)data{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:data];
    NSInteger weekday = [componets weekday];
     NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSString *weekStr = weekArray[weekday-1];
    return weekStr;
}


// 时间戳转字符串
+(NSString *)stringWithTimeInterval:(NSString *)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSTimeInterval newTime=[time doubleValue]/1000;//13位转10位方法（／1000）
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:newTime];
    
    return [formatter stringFromDate:confromTimesp];
}

// string的时间分段成为时分格式
+(NSString *)stringWithHoursandmintues:(NSString *)time {
    NSArray *arr = [time componentsSeparatedByString:@":"];
    NSString *hourstr = [NSString stringWithFormat:@"%@",[arr firstObject]];
    NSString *mintuestr = [NSString stringWithFormat:@"%@",[arr lastObject]];
    
    if ([hourstr isEqualToString:@"00"]&&[mintuestr isEqualToString:@"00"]) {
        return [NSString stringWithFormat:@"%@",@"暂无时间"];
    }
    else if ([hourstr isEqualToString:@"00"]&&![mintuestr isEqualToString:@"00"])
    {
        if ([[mintuestr substringToIndex:1]isEqualToString:@"0"]) {
            mintuestr = [mintuestr substringFromIndex:1];
        }
        return [NSString stringWithFormat:@"%@m",mintuestr];
    }
    else if (![hourstr isEqualToString:@"00"]&&[mintuestr isEqualToString:@"00"])
    {
        if ([[hourstr substringToIndex:1]isEqualToString:@"0"]) {
            hourstr = [hourstr substringFromIndex:1];
        }
        return [NSString stringWithFormat:@"%@h",hourstr];
    }
    else{
        if ([[hourstr substringToIndex:1]isEqualToString:@"0"]) {
            hourstr = [hourstr substringFromIndex:1];
        }
        if ([[mintuestr substringToIndex:1]isEqualToString:@"0"]) {
            mintuestr = [mintuestr substringFromIndex:1];
        }
        return [NSString stringWithFormat:@"%@h%@m",hourstr,mintuestr];
    }
}

// 获取当前时间
+(NSString *)stringWithCurrentTime:(NSString *)formatstr{
    //转换当前时间的格式为 XXXX-XX-XX
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatstr];
    NSString *dateStr = [formatter stringFromDate:dateNow];
    return dateStr;
}

// 获取当前月份第一天
+(NSString *)getMonthBeginAndEndWith:(NSString *)dateStr {
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY年MM月dd日"];
     return  [myDateFormatter stringFromDate:beginDate];
}

+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    
    
    NSInteger aa=0;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *dta = [formatter dateFromString:aDate];
    NSDate *dtb = [formatter dateFromString:bDate];
    
    
    
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //        相等
        aa=0;
    }else if (result==NSOrderedAscending)
    {
        //aDate比date大
        aa=1;
    }else if (result==NSOrderedDescending)
    {
        //aDate比date小
        aa=-1;
        
    }
    
    return aa;
    
}


//判断是否为空
+ (BOOL)isBlankString:(id)object
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}


//把为null的字段设为@“”空
+(NSMutableArray *)setNullDic:(NSArray *)arr
{
    NSMutableArray *array = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj];
        [dic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[dic objectForKey:[dic.allKeys objectAtIndex:idx]] isEqual:[NSNull null]]) {
                [dic setObject:@"" forKey:[dic.allKeys objectAtIndex:idx]];
            }else if ([[dic objectForKey:[dic.allKeys objectAtIndex:idx]] isKindOfClass:[NSArray class]])
            {
                [dic setObject:[self setNullDic:[dic objectForKey:[dic.allKeys objectAtIndex:idx]]] forKey:[dic.allKeys objectAtIndex:idx]];
            }
        }];
        [array addObject:dic];
    }];
    return array;
}

//集成服务id
+(NSString *)changeJsonString:(NSArray *)servicesList andServiceId:(NSString *)service_id{
    @try {
        NSMutableString *jsonStr=[NSMutableString string];
        [jsonStr appendString:@"["];
        for(int i=0;i<[servicesList count];i++){
            NSDictionary *dic=[servicesList objectAtIndex:i];
            [jsonStr appendString:[NSString stringWithFormat:@"{\"service_id\":\"%@\",\"count\":\"1\"}",[dic objectForKey:service_id]]];
            if (i<=[servicesList count]-2&&[servicesList count]>=2) {
                [jsonStr appendString:@","];
            }
        }
        //        [jsonStr appendString:[NSString stringWithFormat:@"{\"service_id\":\"%@\",\"count\":\"1\"}",@"4"]];
        
        [jsonStr appendString:@"]"];
        
        return jsonStr;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

//把yyyy-MM-dd HH:mm:ss格式的时间转换成yyyy-MM-dd格式
+(NSString*)convertDateFromString:(NSString*)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:uiDate];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

//计算尾款，再在尾款中添加","符号
//total:总价
//orderPrice:订金
+(NSString *)getBalance:(NSString *)total andOrderPrice:(NSString *)orderPrice
{
    total = [total stringByReplacingOccurrencesOfString:@"," withString:@""];
    orderPrice = [orderPrice stringByReplacingOccurrencesOfString:@"," withString:@""];
    float balance = [total floatValue] - [orderPrice floatValue];
    NSString *balanceString = [NSString stringWithFormat:@"%.2f",balance];
    NSRange range = [balanceString rangeOfString:@"."];
    NSString *tag1 = [[NSMutableString stringWithString:balanceString] substringFromIndex:range.location];
    NSString *tag2 = [[NSMutableString stringWithString:balanceString] substringToIndex:range.location];
    tag2 = [self countNumAndChangeformat:tag2];
    if ([tag1 isEqualToString:@".00"])
        return [NSString stringWithFormat:@"%@",tag2];
    
    return [NSString stringWithFormat:@"%@%@",tag2,tag1];
}

+(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

//补贴标志
+(UILabel *)configSubsidy:(UILabel *)label andText:(NSString *)labelText
{
    
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 2;
    [label setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:152.0/255.0 blue:0/255.0 alpha:1]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@" %@   ",labelText];
    return label;
}


+(BOOL)SystemVideoJurisdiction
{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"JurisdictionIndext"]) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
         UIAlertView *alert = nil;
        switch (status) {
            case AVAuthorizationStatusNotDetermined:{
                // 许可对话没有出现，发起授权许可
                __block BOOL _granted = YES;
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    _granted = granted;
                    if (granted) {
                        //第一次用户接受
                    }else{
                        //用户拒绝
                        NSLog(@"用户拒绝");

                    }
                }];
                return _granted;
                break;
            }
            case AVAuthorizationStatusAuthorized:{
                // 已经开启授权，可继续
                
                break;
            }
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                // 用户明确地拒绝授权，或者相机设备无法访问
                NSLog(@"用户明确地拒绝授权，或者相机设备无法访问");
                alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在“设置——>隐私——>相机”里面给予相机的访问权限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return NO;
                break;
            default:
                break;
        }
    }else
        [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"JurisdictionIndext"];;
    
    return YES;
}

//字符串是否为数字
+ (BOOL)deptNumInputShouldNumber:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//字符串是否为整数或者小数
+(BOOL)deptNumInputNum:(NSString *)stringNo
{
    NSScanner* scan = [NSScanner scannerWithString:stringNo];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//银行卡每四个数做一下空格处理
+(NSString *)addCardNoSpace:(NSString *)cardNo
{
    NSString *newString = @"";
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"*0123456789\b"];
    while (cardNo.length > 0) {
        NSString *subString = [cardNo substringToIndex:MIN(cardNo.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        cardNo = [cardNo substringFromIndex:MIN(cardNo.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    return newString;
}

//编译中文/特殊字符
+(NSString*)URLDecodedString:(NSString*)str
{
    
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
    
}

//处理json中的回车键“\n”
+(NSString *)jsonString:(NSString *)str_Json
{
    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"    " withString:@""];
    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"(\\\\)"
                                                   withString:@"\\\\\\\\" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [str_Json length])];
    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"(\r)"
                                                   withString:@"\\\\r" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [str_Json length])];
    str_Json = [str_Json stringByReplacingOccurrencesOfString:@"(\n)"
                                                   withString:@"\\\\n" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [str_Json length])];
    return str_Json;
}




@end
