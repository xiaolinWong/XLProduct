//
//  XLUPMoreImageAPI.m
//  Project
//
//  Created by 王小林 on 2016/12/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "XLUPMoreImageAPI.h"
#import <AFURLRequestSerialization.h>

@implementation XLUPMoreImageAPI
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
    
    return self.dic;
 
}
-(NSString *)requestUrl
{
    return self.requestStr;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        for (NSInteger i = 0; i < self.imageArr.count; i++)
        {
            NSString *name = @"file.jpg";
            NSString *type = @"image/jpeg";
            NSString *formKey = @"image[]";
            UIImage *image = self.imageArr[i];
            NSData *data = UIImageJPEGRepresentation(image, 0.5);
            
            [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
            
        }
        
    };
}
@end
