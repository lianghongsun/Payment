//
//  CollectionVC.h
//  Payment
//
//  Created by 噗噗 on 2018/4/6.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *paymethodLab;

@property (weak, nonatomic) IBOutlet UILabel *paypriceLab;
@property (weak, nonatomic) IBOutlet UIImageView *QrImg;

@property (nonatomic,copy)NSString *methods;
@property (nonatomic,copy)NSString *price;
@end
