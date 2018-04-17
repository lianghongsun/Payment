//
//  WeChatStylePlaceHolder.h
//  CYLTableViewPlaceHolder
//
//  Created by 陈宜龙 on 15/12/23.
//  Copyright © 2015年 http://weibo.com/luohanchenyilong/ ÂæÆÂçö@iOSÁ®ãÂ∫èÁä≠Ë¢Å. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeChatStylePlaceHolderDelegate <NSObject>

@required
- (void)emptyOverlayClicked:(id)sender;


@end

@interface WeChatStylePlaceHolder : UIView

@property (nonatomic, weak) id<WeChatStylePlaceHolderDelegate> delegate;

@property (nonatomic, copy)NSString *imageName;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;

@end
