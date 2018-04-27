//
//  OrderModel.h
//  Payment
//
//  Created by iMac_1 on 2018/4/26.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (copy,nonatomic) NSString *orderId;
@property (copy,nonatomic) NSString *orderNo;
@property (copy,nonatomic) NSString *platOrderNo;
@property (copy,nonatomic) NSString *mid;
@property (copy,nonatomic) NSString *uid;
@property (copy,nonatomic) NSString *cashierName;
@property (copy,nonatomic) NSString *productName;
@property (copy,nonatomic) NSString *totalAmount;
@property (copy,nonatomic) NSString *arrivalAmount;
@property (copy,nonatomic) NSString *rateAmount;
@property (copy,nonatomic) NSString *rate;
@property (copy,nonatomic) NSString *platformId;
@property (copy,nonatomic) NSString *payType;
@property (copy,nonatomic) NSString *authcode;
@property (copy,nonatomic) NSString *payState;
@property (copy,nonatomic) NSString *orderState;
@property (copy,nonatomic) NSString *createDate;
@property (copy,nonatomic) NSString *completed;
@property (copy,nonatomic) NSString *remark;
@end
