//
//  XLPOSTPubicAPI.m
//  Project
//
//  Created by Mac on 2017/9/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "XLPOSTPubicAPI.h"

@implementation XLPOSTPubicAPI


- (YTKRequestMethod)requestMethod {
    return self.method;
}
- (id)requestArgument
{
    
    return self.dicBody;
}
-(NSString *)requestUrl
{
    return self.requestStr;
}
- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    NSString *msg = nil;
    if (statusCode == HCRequestStatusFailure)
    {
        msg = @"加载失败";
    }
    return msg;
}
@end
