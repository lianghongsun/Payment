//
//  RequestRelyManager.m
//  Qoros_v3
//
//  Created by youyuanjim on 16/4/28.
//  Copyright © 2016年 unimker. All rights reserved.
//

#import "RequestRelyManager.h"
#import "RefreshTokenAPI.h"
#import "LoginAPI.h"



@interface RequestRelyManager()<YTKRequestDelegate>
@end

@implementation RequestRelyManager{
    LoginAPI *_loginAPI;
    RefreshTokenAPI *_refreshTokenAPI;
    NSInteger _finishNum;
}

+ (RequestRelyManager *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init{
    if (self = [super init]) {
        self.isStartLogin = NO;
        self.isStartRefresh = NO;
        _finishNum = 0;
        self.resumeRequestArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)addRequest:(YTKBaseRequest *)request success:(void (^)(YTKBaseRequest *request))success fail:(void (^)(YTKBaseRequest *request))fail{
    request.successCompletionBlock = success;
    request.failureCompletionBlock = fail;
    [self.resumeRequestArr addObject:request];
}

- (void)resumeRequest{
    if (self.resumeRequestArr.count>0) {
        [self.resumeRequestArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BaseAccessTokenAPIRequest *ob = (BaseAccessTokenAPIRequest *)obj;
            ob.delegate = self;
            ob.successCompletionBlock = ob.succcop;
            ob.failureCompletionBlock = ob.failcop;
            [ob start];
        }];
    }
}

- (void)stopRequest{
    if (self.resumeRequestArr.count>0) {
        [self.resumeRequestArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BaseAccessTokenAPIRequest *ob = (BaseAccessTokenAPIRequest *)obj;
            requestBlock ss = ob.succcop;
            requestBlock ff = ob.failcop;
            [ob stop];
            ob.successCompletionBlock = ss;
            ob.failureCompletionBlock = ff;
            ob.delegate = self;
        }];
    }
}

- (void)clearRequest{
    if (self.resumeRequestArr.count>0) {
        [self.resumeRequestArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YTKBaseRequest *ob = (YTKBaseRequest *)obj;
            [ob stop];
        }];
        [self.resumeRequestArr removeAllObjects];
    }
}

#pragma mark - YTKRequestDelegate 
- (void)requestFinished:(YTKBaseRequest *)request{
    ++_finishNum;
    if (self.resumeRequestArr.count== _finishNum) {
        [self.resumeRequestArr removeAllObjects];
        _finishNum = 0;
    }
}
- (void)requestFailed:(YTKBaseRequest *)request{
    ++_finishNum;
    if (self.resumeRequestArr.count== _finishNum) {
        [self.resumeRequestArr removeAllObjects];
        _finishNum = 0;
    }
}


@end
