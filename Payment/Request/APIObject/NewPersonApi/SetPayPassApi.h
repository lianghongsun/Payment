//
//  ActivityDetailApi.h
//  SpendTime
//
//  Created by mini14 on 2016/10/14.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface SetPayPassApi : BaseAccessTokenAPIRequest
- (id)initWithUid:(NSString *)uid PayPasswd:(NSString *)payPasswd NewSecondPassword:(NSString *)newSecondPassword;
@end
