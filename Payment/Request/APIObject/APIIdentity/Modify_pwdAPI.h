//
//  Modify_pwdAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface Modify_pwdAPI : BaseAPIRequest

- (id)initWithNewPwd:(NSString *)newPwd Uid:(NSString *)uid  ;

@end
