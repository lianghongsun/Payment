//
//  collectionCell.h
//  Payment
//
//  Created by iMac_1 on 2018/4/3.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMonthBillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimge;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footheight;
@property (weak, nonatomic) IBOutlet UILabel *toptitle;
@property (weak, nonatomic) IBOutlet UILabel *topsubtitle;

@end
