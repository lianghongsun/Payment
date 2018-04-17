//
//  RefreshTokenAPI.h
//  Qoros_v3
//
//  Created by 亮哥 on 15/12/10.
//  Copyright © 2015年 unimker. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface RefreshTokenAPI : BaseAccessTokenAPIRequest

- (id)initWithUserId:(NSInteger )userID AccessToken:(NSString *)accessToken;

@end
