//
//  RequestRelyManager.h
//  Qoros_v3
//
//  Created by youyuanjim on 16/4/28.
//  Copyright © 2016年 unimker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKBaseRequest.h"

typedef void (^requestBlock)(YTKBaseRequest *request);

@interface RequestRelyManager : NSObject


@property (assign, nonatomic) BOOL isStartLogin;
@property (assign, nonatomic) BOOL isStartRefresh; //防止多个请求都发送刷新token请求
//@property (assign, nonatomic) BOOL isResume;//重新发送请求
@property (strong, nonatomic) NSMutableArray *resumeRequestArr;

+ (RequestRelyManager *)sharedInstance;

- (void)addRequest:(YTKBaseRequest *)request success:(void (^)(YTKBaseRequest *request))success fail:(void (^)(YTKBaseRequest *request))fail;
- (void)stopRequest;
- (void)clearRequest;
- (void)resumeRequest;

@end
