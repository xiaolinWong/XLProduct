//
//  XLPubicRequsetApi.m
//  Project
//
//  Created by Mac on 16/8/4.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "XLPubicRequsetApi.h"

@implementation XLPubicRequsetApi
- (id)requestArgument
{
    return self.dicBody;
}
//- (YTKRequestMethod)requestMethod
//{
//    if (self.requestMethod) {
//      return self.requestMethod;
//    }
//    
//    return YTKRequestMethodGET;
//}
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
