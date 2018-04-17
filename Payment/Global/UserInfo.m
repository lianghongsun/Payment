//
//  UserInfo.m
//  Qoros_v3
//
//  Created by Techistoner on 15/11/25.
//  Copyright © 2015年 unimker. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo


static UserInfo *sharedAccountManagerInstance = nil;

+ (UserInfo *)shareObject
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}


@end
