//
//  AddactiveAPI.h
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface AddactiveAPI : BaseAPIRequest

- (id)initWithTitle:(NSString *)title Uid:(NSString *)uid Piclist:(NSString *)piclist Address:(NSString *)address Content:(NSString *)content Price:(NSString *)price Longitude:(NSString *)longitude Latitude:(NSString *)latitude Num:(NSString *)num Start_time:(NSString *)start_time End_time:(NSString *)end_time Join_end_time:(NSString *)join_end_time;

@end
