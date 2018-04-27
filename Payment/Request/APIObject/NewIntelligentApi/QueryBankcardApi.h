//
//  EditactiveAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/10/18.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface QueryBankcardApi : BaseAccessTokenAPIRequest
- (id)initWithCategory:(NSString *)category;
@end

