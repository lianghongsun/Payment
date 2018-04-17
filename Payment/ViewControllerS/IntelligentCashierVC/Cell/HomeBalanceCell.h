//
//  HomeBalanceCell.h
//  Payment
//
//  Created by 噗噗 on 2018/4/5.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeBalanceCell;
typedef void (^withdrawalsBlock) (HomeBalanceCell *);

@interface HomeBalanceCell : UITableViewCell

- (IBAction)withdrawalsAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *balanceLab;

@property(nonatomic, copy) withdrawalsBlock withdrawalstoBlock;

@end
