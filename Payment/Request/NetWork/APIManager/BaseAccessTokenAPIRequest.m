//
//  BaseAccessTokenAPIRequest.m
//  Qoros_v3
//
//  Created by Techistoner on 15/12/4.
//  Copyright © 2015年 unimker. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"
#import "RequestRelyManager.h"

@implementation BaseAccessTokenAPIRequest
{
    NSString *_token;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //        _accesstoken = [[UserInfo shareObject] getAccessToken];
        _token = [[UserInfo shareObject] datatoken];
        _isGetResponse = NO;
    }
    return self;
}


- (NSTimeInterval)requestTimeoutInterval{
    return 60.f;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    UserInfo *info = [UserInfo shareObject];
    if (info.datatoken&&info.datatoken.length>0) {
        _token = info.datatoken;
    }
    return @{
             @"token":_token?:@""
             };
}

- (void)requestCompleteFilter {//code 为成功时 才可能缓存
    [super requestCompleteFilter];
    if ([[(NSDictionary *)[super responseJSONObject] objectForKey:@"retcode"] integerValue]==RequestStatusSuccess) {
        [self saveJsonResponseToCacheFile:[super responseJSONObject]];
    }
    
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(YTKBaseRequest *request))success failure:(void (^)(YTKBaseRequest *request))failure{
    
        if (self.succcop == nil) {
            self.succcop = success;
            self.failcop = failure;
        }

        succes succ = ^(YTKBaseRequest *request){
            if ([[(NSDictionary *)[request responseJSONObject] objectForKey:@"retcode"] integerValue] == TOKEN_EXPIRE_CODE) {
                NSLog(@"%@token过期",NSStringFromClass([self class]));
                UserInfo *user = [UserInfo shareObject];
                user.isLogin = NO;
            }
            
            if (self.succcop) {
                self.succcop(request);
            }
            self.succcop = nil;
            self.failcop = nil;
            
        };
        failur fail = ^(YTKBaseRequest *request){
            LxPrintf(@"failprint%@",request.responseString);
            if (self.failcop) {
                self.failcop(request);
                
//                [MBProgressHUD showMessag:@"Network_failure" toView:nil];
            }
            self.succcop = nil;
            self.failcop = nil;
        };
        [super startWithCompletionBlockWithSuccess:succ failure:fail];
    
    
    //    }
}

//一个时间距现在的时间
- (NSTimeInterval)intervalSinceNow: (NSDate *) theDate
{
    NSTimeInterval late=[theDate timeIntervalSince1970]*1;
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSTimeInterval cha= now -late;
    //    NSLog(@"时间差%f",cha);
    return cha;
}

@end
