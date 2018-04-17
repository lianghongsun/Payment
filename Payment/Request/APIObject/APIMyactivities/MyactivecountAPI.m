//
//  MyactivecountAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/11.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "MyactivecountAPI.h"

@implementation MyactivecountAPI
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
    return @"/activemanager/myactivecount";
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
