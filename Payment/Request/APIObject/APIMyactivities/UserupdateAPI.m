//
//  UserupdateAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/10/12.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "UserupdateAPI.h"

@implementation UserupdateAPI
{
    NSString *_uid;
    NSString *_Field;
}

- (id)initWithUid:(NSString *)uid field:(NSString *)Field{
    self = [super init];
    if (self) {
        _uid = uid?uid:@"";
        _Field = Field;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/auth/userupdate";
}


- (id)requestArgument {
    
    return  @{
              @"uid":_uid,
              @"Field":_Field
              };
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPut;
}

@end
