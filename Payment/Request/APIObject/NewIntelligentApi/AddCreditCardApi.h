//
//  ActivedetailAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface AddCreditCardApi : BaseAccessTokenAPIRequest
- (id)initWithRealname:(NSString *)realname BankNo:(NSString *)bankNo BankName:(NSString *)bankName;
@end
