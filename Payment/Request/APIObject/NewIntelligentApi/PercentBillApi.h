//
//  PayStatusApi.h
//  SpendTime
//
//  Created by mini14 on 2016/10/20.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface PercentBillApi : BaseAccessTokenAPIRequest
- (id)initWithUid:(NSString *)uid MonthDate:(NSString *)monthDate;
@end
