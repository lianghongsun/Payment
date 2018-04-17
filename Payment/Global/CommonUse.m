//
//  CommonUse.m
//  SpendTime
//
//  Created by mini14 on 16/9/21.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "CommonUse.h"

@interface CommonUse(){
    
}

@end

@implementation CommonUse

static CommonUse *sharedInstance = nil;

+ (CommonUse *)shareObject
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (id)init{
    self= [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        _currentTemperature = @"";
        [_dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        _userLocation= CLLocationCoordinate2DMake(39.91474, 116.396713);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        _uploadImageFormat = formatter;
    }
    return self;
}
#pragma mark - 压缩图片
+ (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}
//截图
+ ( UIImage *)getImageByCuttingImage:( UIImage *)image Rect:( CGRect )rect{
    
    // 大图 bigImage
    
    // 定义 myImageRect ，截图的区域
    
    CGRect myImageRect = rect;
    
    UIImage * bigImage= image;
    
    CGImageRef imageRef = bigImage. CGImage ;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect (imageRef, myImageRect);
    
    CGSize size;
    
    size. width = rect. size . width ;
    
    size. height = rect. size . height ;
    
    UIGraphicsBeginImageContext (size);
    
    CGContextRef context = UIGraphicsGetCurrentContext ();
    
    CGContextDrawImage (context, myImageRect, subImageRef);
    
    UIImage * smallImage = [ UIImage imageWithCGImage :subImageRef];
    
    UIGraphicsEndImageContext ();
    
    return smallImage;
    
}
//居中切图
+ ( UIImage *)getImageByCuttingMidImage:( UIImage *)image Rect:( CGRect )rect{
    // 大图 bigImage
    
    // 定义 myImageRect ，截图的区域
    
    CGRect myImageRect = rect;
    
    UIImage * bigImage= image;
    
    CGImageRef imageRef = bigImage. CGImage ;
    
    
    
    CGSize size;
    
    size. width = rect. size . width ;
    
    size. height = rect. size . height ;
    
    CGSize imageSize;
    imageSize.width = image.size.width;
    imageSize.height = image.size.width*size.height/size.width;
    if (imageSize.height>image.size.height) {
        imageSize.height = image.size.height;
    }
    
    myImageRect.size.width = imageSize.width;
    myImageRect.size.height = imageSize.height;
    myImageRect.origin.y = (image.size.height-imageSize.height)/2;
    
    UIGraphicsBeginImageContext (imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext ();
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect (imageRef, myImageRect);
    CGContextDrawImage (context, myImageRect, subImageRef);
    
    UIImage * smallImage = [ UIImage imageWithCGImage :subImageRef];
    
    UIGraphicsEndImageContext ();
    
    return smallImage;
}


@end
