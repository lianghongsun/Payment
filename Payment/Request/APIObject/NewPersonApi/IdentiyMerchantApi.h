//
//  ActivecountAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/10/10.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface IdentiyMerchantApi : BaseAccessTokenAPIRequest
- (id)initWithType:(NSString *)type MerName:(NSString *)merName ProvinceId:(NSString *)provinceId CityId:(NSString *)cityId District:(NSString *)district Address:(NSString *)address MerContent:(NSString *)merContent BizCode:(NSString *)bizCode BizCodeFile:(UIImage *)bizCodeFile BizHeadFile:(UIImage *)bizHeadFile BizInnerFile:(UIImage *)bizInnerFile;
@end
