//
//  RefreshTokenBatchRequest.m
//  Qoros_v3
//
//  Created by youyuanjim on 16/7/15.
//  Copyright © 2016年 unimker. All rights reserved.
//

#import "RefreshTokenBatchRequest.h"

#import "YTKBatchRequestAgent.h"
#import "YTKNetworkPrivate.h"
#import "BaseAccessTokenAPIRequest.h"

@implementation RefreshTokenBatchRequest
- (void)start{
    id ss = [self valueForKeyPath:@"finishedCount"];
    if ([ss integerValue]>0) {
        
        return;
    }
    [[YTKBatchRequestAgent sharedInstance] addBatchRequest:self];
    [self toggleAccessoriesWillStartCallBack];
    for (YTKRequest * req in self.requestArray) {
//        req.delegate = self;
        if ([req isKindOfClass:[BaseAccessTokenAPIRequest class]]) {
            [req startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//                if ([[(NSDictionary *)[request responseJSONObject] objectForKey:@"Code"] integerValue]==0) {
//                    
//                }
//                NSLog(@"来没来过%@",request.requestUrl);
//                NSLog(@"多少个request：%d",self.requestArray.count);
                NSInteger getUsefulStatus = 0;
                //特殊接口处理
//                if ([request isKindOfClass:NSClassFromString(@"GetUsefulDataAPI")]) {
//                    getUsefulStatus = [[(NSDictionary *)[request responseJSONObject] objectForKey:@"GetUsefulData"][@"Code"] integerValue];
//                }
                
                if (getUsefulStatus == TOKEN_EXPIRE_CODE||[[(NSDictionary *)[request responseJSONObject] objectForKey:@"retcode"] integerValue] == TOKEN_EXPIRE_CODE) {
//                    NSLog(@"%@过期",request.requestUrl);
                    
                }else if (getUsefulStatus == TOKEN_ILLEGAL||[[(NSDictionary *)[request responseJSONObject] objectForKey:@"retcode"] integerValue] == TOKEN_ILLEGAL){
//                    NSLog(@"%@非法",request.requestUrl);
                    
                }else{
                    NSInteger finishedCount = [[self valueForKeyPath:@"finishedCount"] integerValue];
                    [self setValue:[NSNumber numberWithInteger:finishedCount+1] forKeyPath:@"finishedCount"];
                }
                NSInteger xx = [[self valueForKeyPath:@"finishedCount"] integerValue];
                if (xx == self.requestArray.count) {
                    [self toggleAccessoriesWillStopCallBack];
                    if ([self.delegate respondsToSelector:@selector(batchRequestFinished:)]) {
                        [self.delegate batchRequestFinished:self];
                    }
                    if (self.successCompletionBlock) {
                        self.successCompletionBlock(self);
                    }
                    [self clearCompletionBlock];
                    [self toggleAccessoriesDidStopCallBack];
                }
            } failure:^(YTKBaseRequest *request) {
//                NSLog(@"batch 失败了");
                [self toggleAccessoriesWillStopCallBack];
                // Stop
                for (YTKRequest *req in self.requestArray) {
                    [req stop];
                }
                // Callback
                if ([self.delegate respondsToSelector:@selector(batchRequestFailed:)]) {
                    [self.delegate batchRequestFailed:self];
                }
                if (self.failureCompletionBlock) {
                    self.failureCompletionBlock(self);
                }
                // Clear
                [self clearCompletionBlock];
                
                [self toggleAccessoriesDidStopCallBack];
                [[YTKBatchRequestAgent sharedInstance] removeBatchRequest:self]; 
            }];
        }else{
            NSLog(@"还有不需要token的请求");
            [req start];
        }
    }
}
@end
