//
//  CertificationVC.h
//  Payment
//
//  Created by iMac_1 on 2018/4/2.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificationVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *real_nameLab;
@property (weak, nonatomic) IBOutlet UILabel *shopLab;

- (IBAction)realnameAction:(id)sender;
- (IBAction)shopAction:(id)sender;
@end
