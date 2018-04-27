//
//  ActivecountAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/10.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "IdentiyMerchantApi.h"

@implementation IdentiyMerchantApi

{
    NSString *_type;
    NSString *_merName;
    NSString *_provinceId;
    NSString *_cityId;
    NSString *_district;
    NSString *_address;
    NSString *_merContent;
    NSString *_bizCode;
    UIImage *_bizCodeFile;
    UIImage *_bizHeadFile;
    UIImage *_bizInnerFile;
}

- (id)initWithType:(NSString *)type MerName:(NSString *)merName ProvinceId:(NSString *)provinceId CityId:(NSString *)cityId District:(NSString *)district Address:(NSString *)address MerContent:(NSString *)merContent BizCode:(NSString *)bizCode BizCodeFile:(UIImage *)bizCodeFile BizHeadFile:(UIImage *)bizHeadFile BizInnerFile:(UIImage *)bizInnerFile {
    self = [super init];
    if (self) {
        _type = type?type:@"";
        _merName = merName?merName:@"";
        _provinceId = provinceId?provinceId:@"";
        _cityId = cityId?cityId:@"";
        _district = district?district:@"";
        _address = address?address:@"";
        _merContent = merContent?merContent:@"";
        _bizCode = bizCode?bizCode:@"";
        _bizCodeFile = bizCodeFile;
        _bizHeadFile = bizHeadFile;
        _bizInnerFile = bizInnerFile;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl {
    return @"/api/merchant/identity/apply";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data1 = UIImageJPEGRepresentation(_bizCodeFile, 0.9);
        NSData *data2 = UIImageJPEGRepresentation(_bizHeadFile, 0.9);
        NSData *data3 = UIImageJPEGRepresentation(_bizInnerFile, 0.9);
        NSString *str = [[CommonUse shareObject].uploadImageFormat stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data1 name:@"bizCodeFile" fileName:fileName mimeType:type];
        [formData appendPartWithFileData:data2 name:@"bizHeadFile" fileName:fileName mimeType:type];
        [formData appendPartWithFileData:data3 name:@"bizInnerFile" fileName:fileName mimeType:type];
    };
}


- (id)requestArgument {
    
    return  @{
              @"type":_type,
              @"merName":_merName,
              @"provinceId":_provinceId,
              @"cityId":_cityId,
              @"district":_district,
              @"address":_address,
              @"merContent":_merContent,
              @"bizCode":_bizCode
              };
}

@end
