//
//  ActivedetailAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "ActivedetailAPI.h"

@implementation ActivedetailAPI
{
    NSString *_Id;
}

- (id)initWithid:(NSString *)Id {
    self = [super init];
    if (self) {
        _Id = Id?Id:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/activemanager/activedetail";
}


- (id)requestArgument {
    
    return  @{
              @"id":_Id,
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGet;
}

@end
