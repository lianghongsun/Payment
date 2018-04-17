//
//  CommonUse.h
//  SpendTime
//
//  Created by mini14 on 16/9/21.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define CHINESE_DATE @"yyyy年MM月dd日 HH:mm"
#define PARAM_DATE @"yyyy-MM-dd HH:mm:ss"

@interface CommonUse : NSObject

@property (nonatomic, strong) NSDateFormatter * uploadImageFormat;
@property (nonatomic, strong) NSDateFormatter * dateFormatter;

@property (nonatomic, strong) NSString *currentCityName;
@property (nonatomic, assign) CLLocationCoordinate2D userLocation;
@property (nonatomic, copy) NSString *currentTemperature;
@property (nonatomic, copy) NSString *currentWeather; //!< 天气现象


+ (CommonUse *)shareObject;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
//截图
+ ( UIImage *)getImageByCuttingImage:( UIImage *)image Rect:( CGRect )rect;
//居中切图
+ ( UIImage *)getImageByCuttingMidImage:( UIImage *)image Rect:( CGRect )rect;

+ (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

@end
