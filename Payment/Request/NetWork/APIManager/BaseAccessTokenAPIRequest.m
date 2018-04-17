//
//  BaseAccessTokenAPIRequest.m
//  Qoros_v3
//
//  Created by Techistoner on 15/12/4.
//  Copyright © 2015年 unimker. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

#import "RefreshTokenAPI.h"
#import "LoginAPI.h"

#import "RequestRelyManager.h"

static NSInteger refreshNum = 0;

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
    if ([[(NSDictionary *)[super responseJSONObject] objectForKey:@"Code"] integerValue]==RequestStatusSuccess) {
        [self saveJsonResponseToCacheFile:[super responseJSONObject]];
    }
    
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(YTKBaseRequest *request))success failure:(void (^)(YTKBaseRequest *request))failure{
    if ([self.requestUrl isEqualToString:REFRESH_TOKEN_FIELD]) {//当前请求为刷新token请求时
        //        [super startWithCompletionBlockWithSuccess:success failure:failure];
        
        [super startWithCompletionBlockWithSuccess:success failure:failure];
    }
    else{
        if (self.succcop == nil) {
            self.succcop = success;
            self.failcop = failure;
        }

        succes succ = ^(YTKBaseRequest *request){
            UserInfo *info = [UserInfo shareObject];
//            BOOL isGetUsefulDataAPI = NO;
            NSInteger getUsefulStatus = 0;
            //特殊接口处理
//            if ([request isKindOfClass:NSClassFromString(@"GetUsefulDataAPI")]) {
//                getUsefulStatus = [[(NSDictionary *)[request responseJSONObject] objectForKey:@"GetUsefulData"][@"Code"] integerValue];
//            }
            
            if ([[(NSDictionary *)[request responseJSONObject] objectForKey:@"Code"] integerValue] != 0) {
                LxPrintf(@"Errorprint:%@%@",NSStringFromClass([self class]),(NSDictionary *)[request responseJSONObject]);
            }
            if (getUsefulStatus == TOKEN_EXPIRE_CODE||[[(NSDictionary *)[request responseJSONObject] objectForKey:@"Code"] integerValue] == TOKEN_EXPIRE_CODE) {
                NSLog(@"%@token过期",NSStringFromClass([self class]));
                if (!self.succcop) {
                    NSLog(@"block为nil了");
                }
                if ([[request.requestOperation.request valueForHTTPHeaderField:ACCESSTOKEN_HEAD_FIELD] isEqualToString:info.datatoken]) {
                    if (refreshNum == 0) {
                        if ([RequestRelyManager sharedInstance].isStartRefresh == NO) {
                            [[RequestRelyManager sharedInstance] clearRequest];//清除请求
                            [RequestRelyManager sharedInstance].isStartRefresh = YES;
                            [self refreshTokenRequestSuccess:self.succcop failure:self.failcop];
                        }else{//已经开始刷新请求了，其他请求导致的刷新，请暂停，入队等候
                            [[RequestRelyManager sharedInstance] addRequest:self success:self.succcop fail:self.failcop];
                        }

                        
                    }else if (refreshNum == 1){
                        [[RequestRelyManager sharedInstance] stopRequest];
                        [self loginRequestSuccess:self.succcop failure:self.failcop];
                    }else{
                        refreshNum = 0;
                    }
                }else{//不等于 代表token更新过
                    refreshNum = 0;
                    [super startWithCompletionBlockWithSuccess:self.succcop failure:self.failcop];
                }
                
            }
            else if (getUsefulStatus == TOKEN_ILLEGAL||[[(NSDictionary *)[request responseJSONObject] objectForKey:@"Code"] integerValue] == TOKEN_ILLEGAL ){
                NSLog(@"token非法");
                
                refreshNum = 0;
                //                    [DataCenter goBackToLoginVC];//需求需要登录过一次就不退出
                if ([[request.requestOperation.request valueForHTTPHeaderField:@"AccessToken"] isEqualToString:info.datatoken]) {
                    NSLog(@"token非法,后台登录---%@",NSStringFromClass([self class]));
                    if ([RequestRelyManager sharedInstance].isStartLogin == NO) {
                        [[RequestRelyManager sharedInstance] clearRequest];//清除请求
                        [RequestRelyManager sharedInstance].isStartLogin = YES;
                        [self loginRequestSuccess:self.succcop failure:self.failcop];
                    }else{
                        //增加到请求的数组
                        [[RequestRelyManager sharedInstance] addRequest:self success:self.succcop fail:self.failcop];
                    }

                }else{
                    [super startWithCompletionBlockWithSuccess:self.succcop failure:self.failcop];
                }
                
            }
            else{
                if ([[(NSDictionary *)[request responseJSONObject] objectForKey:@"Code"] integerValue] == SERVER_ERROR) {
//                    [MBProgressHUD showError:@"服务器错误" toView:nil];
                }
                refreshNum =0;
                if (self.succcop) {
                    self.succcop(request);
                } 
                self.succcop = nil;
                self.failcop = nil;
            }
        };
        failur fail = ^(YTKBaseRequest *request){
            LxPrintf(@"failprint%@",request.responseString);

            refreshNum =0;
            if (self.failcop) {
                self.failcop(request);
                
//                [MBProgressHUD showMessag:@"Network_failure" toView:nil];
            }
            self.succcop = nil;
            self.failcop = nil;
        };
        [super startWithCompletionBlockWithSuccess:succ failure:fail];
    }
    
    //    }
}

- (void)loginRequestSuccess:(void (^)(YTKBaseRequest *request))success failure:(void (^)(YTKBaseRequest *request))failure{
    UserInfo *person = [UserInfo shareObject];
    
    LoginAPI *login = [[LoginAPI alloc]initWithUsername:@"" password:@""];
    [login startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = (NSDictionary *)request.responseJSONObject;
        NSString *codestring = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Code"]];
        NSInteger responseCode = [codestring integerValue];
        if (responseCode == RequestStatusSuccess) {
            NSDictionary *userinfo = [dic objectForKey:@"UserInfo"];
            UserInfo *infof = [UserInfo shareObject];
            infof = [UserInfo mj_objectWithKeyValues:userinfo];
            refreshNum = 0;
            [RequestRelyManager sharedInstance].isStartLogin = NO;
            [[RequestRelyManager sharedInstance] resumeRequest];
            [super startWithCompletionBlockWithSuccess:success failure:failure];
//            //缓存userid
//            [[DataCenter KeyValueStore]putNumber:[NSNumber numberWithInteger:person.UserId] withId:@"currentUserID" intoTable:qDBTableName];
//            //缓存userinfo
//            [[DataCenter KeyValueStore]putObject:userinfo.mj_keyValues withId:[NSString stringWithFormat:@"userinfo%li",(long)person.UserId] intoTable:qDBTableName];
            
        }
        else  if (responseCode == RequestStatusUsernameOrPasswdError) {//后台刷新过程中账户密码不匹配
//             [DataCenter goBackToLoginVC];
            //跳转到登录界面
        }
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"后台登录都失败了,请跳转到登录界面吧");
        refreshNum = 0;
//        [DataCenter goBackToLoginVC];
        return;//登录界面跳转
        
    }];
    
}

- (void)refreshTokenRequestSuccess:(void (^)(YTKBaseRequest *request))success failure:(void (^)(YTKBaseRequest *request))failure{
    UserInfo *user = [UserInfo shareObject];
    RefreshTokenAPI *refreshToken = [[RefreshTokenAPI alloc]initWithUserId:@"" AccessToken:@""];
    succes succ = ^(YTKBaseRequest *request){
        NSDictionary *dic  = (NSDictionary *) request.responseJSONObject;
        if ([[dic objectForKey:@"AccessToken"] length]>0) {
//            NSDate *lastDate = [NSDate date];
//            [[NSUserDefaults standardUserDefaults]setObject:lastDate forKey:@"lastdate"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
            user.datatoken = [dic objectForKey:@"AccessToken"];
            NSLog(@"token刷新了");
            refreshNum++;
            [RequestRelyManager sharedInstance].isStartRefresh = NO;
            [[RequestRelyManager sharedInstance] resumeRequest];
            [self startWithCompletionBlockWithSuccess:self.succcop failure:self.failcop];
//            //缓存userid
//            [[DataCenter KeyValueStore]putNumber:[NSNumber numberWithInteger:user.UserId] withId:@"currentUserID" intoTable:qDBTableName];
//            
//            //缓存userinfo
//            [[DataCenter KeyValueStore]putObject:user.mj_keyValues withId:[NSString stringWithFormat:@"userinfo%li",(long)user.UserId] intoTable:qDBTableName];
        }
        else {
            NSLog(@"succ里面刷新失败,重新请求");
            [self loginRequestSuccess:self.succcop failure:self.failcop];
        }
    };
    failur fail = ^(YTKBaseRequest *request){
        NSLog(@"failu里面刷新失败,重新请求");
        [self loginRequestSuccess:self.succcop failure:self.failcop];
    };
    [refreshToken startWithCompletionBlockWithSuccess:succ failure:fail];
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
