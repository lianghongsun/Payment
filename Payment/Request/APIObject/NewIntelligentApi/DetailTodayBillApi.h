//
//  GetusermoneyAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/10/12.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface DetailTodayBillApi : BaseAccessTokenAPIRequest
- (id)initWithUid:(NSString *)uid PageNum:(NSInteger)pageNum PageSize:(NSInteger)pageSize StartDate:(NSString *)startDate PlatformId:(NSString *)platformId ;
@end
