//
//  ActivelistsAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "QueryApplyAPI.h"

@implementation QueryApplyAPI
{
    
}

- (id)initWith{
    self = [super init];
    if (self) {

    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/passport/identity/apply/query";
}


- (id)requestArgument {
    
    return  @{
             
              };
}


@end
