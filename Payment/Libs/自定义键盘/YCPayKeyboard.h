//
//  YCPayKeyboard.h
//  SWWH
//
//  Created by 尚往文化 on 17/1/16.
//  Copyright © 2017年 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCPayKeyboard : UIView

+ (instancetype)keyboard;

@property (nonatomic, copy) void(^clickBlock)(NSInteger index);

@end
