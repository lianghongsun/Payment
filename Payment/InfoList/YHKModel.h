//
//  HomeActivesModel.h
//  SpendTime
//
//  Created by mini14 on 2016/10/11.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHKModel : NSObject

@property (copy,nonatomic) NSString *bankId;
@property (copy,nonatomic) NSString *uid;
@property (copy,nonatomic) NSString *category;
@property (copy,nonatomic) NSString *bankNo;
@property (copy,nonatomic) NSString *realname;
@property (copy,nonatomic) NSString *bankName;
@property (copy,nonatomic) NSString *cardType;
@property (copy,nonatomic) NSString *isDefault;
@property (copy,nonatomic) NSString *state;
@property (copy,nonatomic) NSString *createDate;

@end

@interface TodayBillFirstModel : NSObject

@property (copy,nonatomic) NSString *totalAmount;
@property (copy,nonatomic) NSString *totalRow;
@property (copy,nonatomic) NSString *platformId;

@end

@interface YearlistBillFirstModel : NSObject

@property (assign,nonatomic) double totalAmount;
@property (assign,nonatomic) NSInteger totalCount;
@property (copy,nonatomic) NSString *monthDate;

@end

@interface TodayBilldetailModel : NSObject

@property (copy,nonatomic) NSString *logType;
@property (copy,nonatomic) NSString *uid;
@property (copy,nonatomic) NSString *totalAmount;
@property (copy,nonatomic) NSString *orderNo;
@property (copy,nonatomic) NSString *arrivalAmount;
@property (copy,nonatomic) NSString *platOrderNo;
@property (copy,nonatomic) NSString *create;
@property (copy,nonatomic) NSString *cashierId;
@property (copy,nonatomic) NSString *remark;
@property (copy,nonatomic) NSString *platformId;
@property (copy,nonatomic) NSString *cashierName;
@property (copy,nonatomic) NSString *dateSum;
@end

