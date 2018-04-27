//
//  ActivitesSearchApi.h
//  SpendTime
//
//  Created by mini14 on 2016/10/13.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface DetailMinthBillApi : BaseAccessTokenAPIRequest
- (id)initWithUid:(NSString *)uid PageNum:(NSInteger)pageNum PageSize:(NSInteger)pageSize  PlatformId:(NSString *)platformId ;
@end
