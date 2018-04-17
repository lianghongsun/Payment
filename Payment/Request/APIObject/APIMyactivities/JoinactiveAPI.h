//
//  JoinactiveAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface JoinactiveAPI : BaseAPIRequest

- (id)initWithUid:(NSString *)uid Active_id:(NSString *)active_id Pay_status:(NSString *)pay_status;

@end
