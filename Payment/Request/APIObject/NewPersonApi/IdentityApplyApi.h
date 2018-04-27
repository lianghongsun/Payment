//
//  JoinActivityApi.h
//  SpendTime
//
//  Created by mini14 on 2016/10/14.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAccessTokenAPIRequest.h"

@interface IdentityApplyApi : BaseAccessTokenAPIRequest
- (id)initWithRealname:(NSString *)realname IdentityNo:(NSString *)identityNo FrontFile:(UIImage *)frontFile BackFile:(UIImage *)backFile PersonFile:(UIImage *)personFile;
@end
