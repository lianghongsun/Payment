//
//  MyactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "MyactiveAPI.h"

@implementation MyactiveAPI

{
    NSString *_uid;
    NSString *_type;
}

- (id)initWithUid:(NSString *)uid Type:(NSString *)type{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _type = type?type:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/activemanager/myactive";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"type":_type
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGet;
}

@end