//
//  RealNameCationCell.h
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopCationCell;
typedef void (^positiveBlock) (ShopCationCell *);
typedef void (^reverseBlock) (ShopCationCell *);
typedef void (^myimgBlock) (ShopCationCell *);
typedef void (^submitBlock) (ShopCationCell *);

@interface ShopCationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *nameTx;
@property (weak, nonatomic) IBOutlet UIImageView *positiveimg;
@property (weak, nonatomic) IBOutlet UIImageView *reverseimg;
@property (weak, nonatomic) IBOutlet UIImageView *myimg;
- (IBAction)submitAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *Photofirst;
@property (weak, nonatomic) IBOutlet UIImageView *Photosecond;
@property (weak, nonatomic) IBOutlet UIImageView *Photothree;
@property (weak, nonatomic) IBOutlet UILabel *photofirstLab;
@property (weak, nonatomic) IBOutlet UILabel *photosecondLab;

@property (weak, nonatomic) IBOutlet UILabel *photothreeLab;


@property(nonatomic, copy) positiveBlock positivetoBlock;
@property(nonatomic, copy) reverseBlock reversetoBlock;
@property(nonatomic, copy) myimgBlock myimgtoBlock;
@property(nonatomic, copy) submitBlock submittoBlock;
@end
