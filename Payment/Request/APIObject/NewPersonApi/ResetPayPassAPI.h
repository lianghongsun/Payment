//
//  RefreshAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface ResetPayPassAPI : BaseAccessTokenAPIRequest

- (id)initWithUid:(NSString *)uid RealName:(NSString *)realName IdentityNo:(NSString *)identityNo Smscode:(NSString *)smscode;

@end
