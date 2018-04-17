//
//  WithdrpriceCell.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrpriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backgroview;

@property (weak, nonatomic) IBOutlet UIButton *allBtn;

- (IBAction)waitAllAction:(id)sender;
@end
