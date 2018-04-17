//
//  UserupdateAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/10/12.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface UserupdateAPI : BaseAPIRequest

- (id)initWithUid:(NSString *)uid field:(NSString *)Field;
@end
