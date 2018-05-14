//
//  XLUPImageAPI.m
//  Project
//
//  Created by 王小林 on 16/8/25.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "XLUPImageAPI.h"
#import <AFURLRequestSerialization.h>
@implementation XLUPImageAPI
- (void)startRequest:(HCUploadHeadImageBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    NSString *msg = @"图片上传失败";
    
    switch (statusCode) {
        case HCRequestStatusSuccess:
            msg = @"图片上传成功";
            break;
        default:
            break;
    }
    
    return msg;
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"data"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    
    return self.Argument;
}
-(NSString *)requestUrl
{
    return self.requestUrlstr;
}

- (AFConstructingBlock)constructingBodyBlock {
    WEAKSELF
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(weakSelf.image, 0.5);
        
        NSString *name = @"file.jpg";
        NSString *formKey = @"file";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
        NSLog(@">>>%@",formData);
    };
}

@end
