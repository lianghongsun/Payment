//
//  JoinActivityApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/14.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "IdentityApplyApi.h"

@implementation IdentityApplyApi{
    NSString *_realname;
    NSString *_identityNo;
    UIImage  *_frontFile;
    UIImage  *_backFile;
    UIImage  *_personFile;
}
- (id)initWithRealname:(NSString *)realname IdentityNo:(NSString *)identityNo FrontFile:(UIImage *)frontFile BackFile:(UIImage *)backFile PersonFile:(UIImage *)personFile {
    self = [super init];
    if (self) {
        _realname = realname?realname:@"";
        _identityNo = identityNo?identityNo:@"";
        _frontFile = frontFile;
        _backFile = backFile;
        _personFile = personFile;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl {
    return @"/api/passport/identity/apply";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data1 = UIImageJPEGRepresentation(_frontFile, 0.9);
        NSData *data2 = UIImageJPEGRepresentation(_frontFile, 0.9);
        NSData *data3 = UIImageJPEGRepresentation(_frontFile, 0.9);
        NSString *str = [[CommonUse shareObject].uploadImageFormat stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data1 name:@"frontFile" fileName:fileName mimeType:type];
        [formData appendPartWithFileData:data2 name:@"backFile" fileName:fileName mimeType:type];
        [formData appendPartWithFileData:data3 name:@"personFile" fileName:fileName mimeType:type];
    };
}

- (id)requestArgument {
    return  @{
              @"realname":_realname,
              @"identityNo":_identityNo
              };
}

@end
