//
//  PayApi.h
//  SpendTime
//
//  Created by mini14 on 2016/10/19.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface EverydayBillApi : BaseAccessTokenAPIRequest
- (id)initWithUid:(NSString *)uid StartDate:(NSString *)startDate EndDate:(NSString *)endDate;
@end
