//
//  EditactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/18.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "QueryBankcardApi.h"

@implementation QueryBankcardApi {
     NSString *_category;
}
- (id)initWithCategory:(NSString *)category{
    self = [super init];
    if (self) {
        _category = category?category:@"";;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/passport/bankcard/query";
}

- (id)requestArgument {
    
    return  @{
              @"category":_category,
              };
}


-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}
@end
