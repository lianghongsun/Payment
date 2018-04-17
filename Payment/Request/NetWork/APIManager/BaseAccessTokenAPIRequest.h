//
//  BaseAccessTokenAPIRequest.h
//  Qoros_v3
//
//  Created by Techistoner on 15/12/4.
//  Copyright © 2015年 unimker. All rights reserved.
//

#import "YTKRequest.h"
/**
 *  带Token的API请求的基类
 */

typedef void (^succes)(YTKBaseRequest *);
typedef void (^failur)(YTKBaseRequest *);
@interface BaseAccessTokenAPIRequest : YTKRequest

@property (copy,nonatomic) succes succcop;
@property (copy,nonatomic) failur failcop;

@property (assign, nonatomic) BOOL isGetResponse;

- (void)startWithCompletionBlockWithSuccess:(void (^)(YTKBaseRequest *request))success failure:(void (^)(YTKBaseRequest *request))failure;

@end
