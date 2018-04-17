//
//  WithDetermineBtnCell.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WithDetermineBtnCell;
typedef void (^determineBlock) (WithDetermineBtnCell *);

@interface WithDetermineBtnCell : UITableViewCell

- (IBAction)determineAction:(id)sender;

@property(nonatomic, copy) determineBlock determineBlockoBlock;

@end
