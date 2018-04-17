//
//  UploadImageApi.m
//  SpendTime
//
//  Created by mini14 on 2016/10/8.
//  Copyright © 2016年 mini14. All rights reserved.
//

#import "UploadImageApi.h"
#import "CommonUse.h"

@implementation UploadImageApi{
    UIImage *_image;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl {
    return @"/activemanager/uploadpic";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
        NSString *str = [[CommonUse shareObject].uploadImageFormat stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        NSString *formKey = @"pic";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:fileName mimeType:type];
    };
}

- (BOOL)statusCodeValidator {
    if ([[(NSDictionary *)[super responseJSONObject] objectForKey:@"status"] integerValue]==1) {
        return YES;
    }
    return NO;
}

//- (NSString *)responseImageId {
//    NSDictionary *dict = self.responseJSONObject;
//    return dict[@"url"];
//}

- (id)requestArgument {
    return  @{
              @"id":@"",//后面这里1变成空
              };
}

@end
