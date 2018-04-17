//
//  AllActivesApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/11.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "AllActivesApi.h"

@implementation AllActivesApi{
    NSInteger _pageNum;
}
- (id)initWithPage:(NSInteger )pageNum{
    self = [super init];
    if (self) {
        _pageNum = pageNum;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (NSString *)requestUrl {
    return @"/active/allactive";
}

- (id)requestArgument {
    return  @{
                @"page":@(_pageNum),
              };
}

- (BOOL)statusCodeValidator {
    if ([[(NSDictionary *)[super responseJSONObject] objectForKey:@"status"] integerValue]==1) {
        return YES;
    }
    return NO;
}


@end
