//
//  BaseAPIRequest.m
//  Qoros_v3
//
//  Created by Techistoner on 15/11/30.
//  Copyright © 2015年 unimker. All rights reserved.
//

#import "BaseAPIRequest.h"

@implementation BaseAPIRequest

- (NSTimeInterval)requestTimeoutInterval{
    return 60.f;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

@end
