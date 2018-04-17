//
//  UploadImageApi.h
//  SpendTime
//
//  Created by mini14 on 2016/10/8.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface UploadImageApi : BaseAPIRequest

- (id)initWithImage:(UIImage *)image;
//- (NSString *)responseImageId;

@end
