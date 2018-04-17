//
//  AddactiveAPI.m
//  SpendTime
//
//  Created by mini1 on 2016/9/29.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "AddactiveAPI.h"

@implementation AddactiveAPI

{
    NSString *_title;
    NSString *_uid;
    NSString *_piclist;
    NSString *_address;
    NSString *_content;
    NSString *_price;
    NSString *_longitude;
    NSString *_latitude;
    NSString *_num;
    NSString *_start_time;
    NSString *_end_time;
    NSString *_join_end_time;
}

- (id)initWithTitle:(NSString *)title Uid:(NSString *)uid Piclist:(NSString *)piclist Address:(NSString *)address Content:(NSString *)content Price:(NSString *)price Longitude:(NSString *)longitude Latitude:(NSString *)latitude Num:(NSString *)num Start_time:(NSString *)start_time End_time:(NSString *)end_time Join_end_time:(NSString *)join_end_time{
    self = [super init];
    if (self) {
        _title = title?title:@"";
        _uid = uid?uid:@"";
        _piclist = piclist?piclist:@"";
        _address = address?address:@"";
        _content = content?content:@"";
        _price = price?price:@"";
        _longitude = longitude?longitude:@"";
        _latitude = latitude?latitude:@"";
        _num = num?num:@"";
        _start_time = start_time?start_time:@"";
        _end_time = end_time?end_time:@"";
        _join_end_time = join_end_time?join_end_time:@"";
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/auth/addactive";
}


- (id)requestArgument {
    
    return  @{
              @"title":_title,
              @"uid":_uid,
              @"piclist":_piclist,
              @"address":_address,
              @"content":_content,
              @"price":_price,
              @"longitude":_longitude,
              @"latitude":_latitude,
              @"num":_num,
              @"start_time":_start_time,
              @"end_time":_end_time,
              @"join_end_time":_join_end_time
              };
}


@end
