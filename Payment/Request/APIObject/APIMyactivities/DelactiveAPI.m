//
//  DelactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/11.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "DelactiveAPI.h"

@implementation DelactiveAPI
{
    NSString *_uid;
    NSString *_ID;
}

- (id)initWithUid:(NSString *)uid Id:(NSString *)ID{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _ID = ID?ID:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/activemanager/delactive";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"id":_ID
              };
}

@end
