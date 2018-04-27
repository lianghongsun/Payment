//
//  RealNameFailureVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/24.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RealNameFailureVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
- (IBAction)uploadAgainAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;

@end
