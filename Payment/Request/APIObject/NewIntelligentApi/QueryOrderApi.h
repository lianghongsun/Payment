//
//  MyactivecountAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/10/11.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface QueryOrderApi : BaseAccessTokenAPIRequest
- (id)initWithOrderNo:(NSString *)orderNo;
@end
