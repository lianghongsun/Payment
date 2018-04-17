//
//  MyactiveAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface MyactiveAPI : BaseAPIRequest
- (id)initWithUid:(NSString *)uid Type:(NSString *)type;
@end
