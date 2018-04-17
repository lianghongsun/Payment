//
//  WithButtonCell.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WithButtonCell;
typedef void (^withdrawasBlock) (WithButtonCell *);

@interface WithButtonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backgr;
@property (weak, nonatomic) IBOutlet UIButton *withdarBtn;

- (IBAction)withdrawalAction:(id)sender;

@property(nonatomic, copy) withdrawasBlock withdrawalstoBlock;
@end
