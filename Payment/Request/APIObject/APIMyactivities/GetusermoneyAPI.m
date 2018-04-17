//
//  GetusermoneyAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/12.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "GetusermoneyAPI.h"

@implementation GetusermoneyAPI
{
    NSString *_uid;
}

- (id)initWithUid:(NSString *)uid {
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/auth/getusermoney";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGet;
}

@end
