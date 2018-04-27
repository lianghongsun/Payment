//
//  CollectlistAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/10/12.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface AddDebitcardApi : BaseAccessTokenAPIRequest
- (id)initWithRealname:(NSString *)realname BankNo:(NSString *)bankNo BankName:(NSString *)bankName CardType:(NSString *)cardType Smscode:(NSString *)smscode;
@end
