//
//  CollectActivityApi.h
//  SpendTime
//
//  Created by mini14 on 2016/10/13.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface VerifyPayPassApi : BaseAccessTokenAPIRequest
- (id)initWithUid:(NSString *)uid PayPasswd:(NSString *)payPasswd;
@end
