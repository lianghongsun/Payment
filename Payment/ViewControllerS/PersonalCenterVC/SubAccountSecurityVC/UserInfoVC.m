//
//  UserInfoVC.m
//  Payment
//
//  Created by 噗噗 on 2018/4/1.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "UserInfoVC.h"
#import "PersonalDataCell.h"
#import "VersionCell.h"
#import "UIViewController+XHPhoto.h"
#import "UIImageView+WebCache.h"

@interface UserInfoVC ()<UITableViewDelegate,UITableViewDataSource>

{
    UIImage *userimg;
    UserInfo *user;
}
@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    user = [UserInfo shareObject];
    [self.tableview registerNib:[UINib nibWithNibName:@"PersonalDataCell" bundle:nil] forCellReuseIdentifier:@"PersonalDataCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"VersionCell" bundle:nil] forCellReuseIdentifier:@"VersionCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.00001;
    }
    return  10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    return TAbcell_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *identifier1 = @"PersonalDataCell";
        PersonalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (userimg) {
            cell.head_Image.image = userimg;
        }
        else{
            [cell.head_Image sd_setImageWithURL:[user.detail objectForKey:@"headPath"] placeholderImage:[UIImage imageNamed:@"userporfile-pic"]];
        }
        cell.introduceLab.text = @"头像";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else{
        static NSString *identifier1 = @"VersionCell";
        VersionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        NSString *namestr;
        if ([[user.detail objectForKey:@"realName"]length]>0) {
            namestr = [user.detail objectForKey:@"realName"];
        }
        else{
            namestr = user.username;
        }
        
        if (indexPath.row == 0) {
            cell.versioLab.text = @"用户名";
            cell.subLab.text = namestr;
        }
        else{
            cell.versioLab.text = @"创建时间";
            cell.subLab.text = user.create;
        }
         cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        [self showCanEdit:YES photo:^(UIImage *photo) {
            userimg = photo;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }
}
@end
