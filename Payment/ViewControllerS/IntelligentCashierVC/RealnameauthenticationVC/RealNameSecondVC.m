//
//  RealNameSecondVC.m
//  Payment
//
//  Created by iMac_1 on 2018/4/11.
//  Copyright © 2018年 噗噗. All rights reserved.
//

#import "RealNameSecondVC.h"
#import "RealNameCationCell.h"
#import "UIViewController+XHPhoto.h"
#import "IdentityApplyApi.h"

@interface RealNameSecondVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *nameTx;
    UITextField *numTx;
    UIImage *frontFileImg;
    UIImage *backFileImg;
    UIImage *personFileImg;
    UserInfo *user;
}
@end

@implementation RealNameSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @" 实名认证";
    user = [UserInfo shareObject];
    [self.tableview registerNib:[UINib nibWithNibName:@"RealNameCationCell" bundle:nil] forCellReuseIdentifier:@"RealNameCationCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 520;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier1 = @"RealNameCationCell";
    RealNameCationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    cell.nameTx.delegate = self;
    cell.numTx.delegate = self;
    nameTx = cell.nameTx;
    numTx = cell.numTx;
    
    cell.positivetoBlock = ^(RealNameCationCell *cell) {
        
        [self showCanEdit:YES photo:^(UIImage *photo) {
            [cell.Photofirst setHidden:YES];
            cell.positiveimg.image =  photo;
            frontFileImg = photo;
        }];
    };
    
    cell.reversetoBlock = ^(RealNameCationCell *cell) {
        [self showCanEdit:YES photo:^(UIImage *photo) {
            
            [cell.Photosecond setHidden:YES];
            cell.reverseimg.image =  photo;
            backFileImg = photo;
            
        }];
    };
    
    cell.myimgtoBlock = ^(RealNameCationCell *cell) {
        
        [self showCanEdit:YES photo:^(UIImage *photo) {
            
            [cell.Photothree setHidden:YES];
            cell.myimg.image =  photo;
            personFileImg = photo;
            
        }];
    };
    
    cell.submittoBlock = ^(RealNameCationCell *cell) {
        if ([nameTx.text length]<=0) {
            [self showMessage:@"请输入姓名" viewHeight:0];
            return ;
        }
        if ([numTx.text length]<=0) {
            [self showMessage:@"请输入身份证号" viewHeight:0];
            return ;
        }
        
        if (![self checkUserID:numTx.text]) {
            [self showMessage:@"身份证号码不正确" viewHeight:0];
            return ;
        }
        
        if (!frontFileImg) {
            [self showMessage:@"身份证正面照片不能缺失" viewHeight:0];
            return ;
        }
        if (!backFileImg) {
            [self showMessage:@"身份证反面照片不能缺失" viewHeight:0];
            return ;
        }
        if (!personFileImg) {
            [self showMessage:@"手持身份证照片不能缺失" viewHeight:0];
            return ;
        }
        [self IdentityApplyApi];
    };
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == nameTx) {
        [nameTx resignFirstResponder];
        [numTx becomeFirstResponder];
    }else{
        [numTx resignFirstResponder];
    }
    return YES;
}

- (void)IdentityApplyApi {
    [self showLoding:@"请稍后"];
    IdentityApplyApi *apply = [[IdentityApplyApi alloc]initWithRealname:nameTx.text IdentityNo:numTx.text FrontFile:frontFileImg BackFile:backFileImg PersonFile:personFileImg];
    [apply startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self closeLoding];
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [(NSDictionary *)request.responseJSONObject objectForKey:@"data"];
            NSInteger responseCode = [[dic objectForKey:@"code"] integerValue];
            switch (responseCode) {
                case RequestStatusSuccess:
                {
                    user.identityAuthed = [[dic objectForKey:@"identityAuthed"]integerValue];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                    break;
                default:
                {
                    NSString *mesgStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]];
                    [self showMessage:mesgStr viewHeight:0];
                }
                    break;
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [self closeLoding];


    }];

}
@end
