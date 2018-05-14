//
//  HCRequest.m
//  HealthCloud
//
//  Created by Vincent on 15/10/27.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"
#import "YTKNetworkAgent.h"
#import "YTKUrlArgumentsFilter.h"
#import "NSString+MD5.h"
//私有定义
//来自服务端定义
#define KCodeStatus           @"code"
#define KMessage              @"msg"
#define KBody                 @"data"
//#define kXAuthFailedCode      @"X-Auth-Failed-Code"


@implementation HCRequest

#pragma mark - override Getters

- (NSTimeInterval)requestTimeoutInterval
{
    return 15;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
//    return YTKRequestMethodPost;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    return @"";
}

/// (封装层) 解析，把服务器返回数据转换想要的数据
//默认返回原 data
//通常解析body内数据
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
- (NSDictionary *)requestHeaderFieldValueDictionary {
    
    if ([HCAccountMgr manager].loginInfo.token) {
        return @{@"XX-Device-Type":@"iphone",@"XX-Token":[HCAccountMgr manager].loginInfo.token};
    }
    return @{@"XX-Device-Type":@"iphone"};
}

#pragma mark - override Methods

- (void)startRequest:(HCRequestBlock)requestBlock
{

   // 打印请求
    DLog(@"\n%@\n%@\n",
         [[YTKNetworkAgent sharedAgent] buildRequestUrl:self],
         self.requestArgument);
    
    //开始请求
    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {

        [self handleSuccess:requestBlock responseSting:request.responseString responseObject:request.responseJSONObject responseHeaders:request.responseHeaders];
        
    } failure:^(YTKBaseRequest *request) {
        
        [self handleFailure:requestBlock
                      error:request.error
            responseHeaders:request.responseHeaders];
        
    }];
}




#pragma mark - private Method
- (void)handleSuccess:(HCRequestBlock)requestBlock  responseSting:(NSString *)responseString
       responseObject:(id)responseObject
      responseHeaders:(NSDictionary *)responseHeaders
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //打印结果
        [self printResponseData];
        
        NSDictionary *responseDic=nil;
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            responseDic=responseObject;
        }
        if (IsEmpty(responseObject)&&!IsEmpty(responseString)) {
            
            responseDic=[self parseJSONStringToNSDictionary:responseString];
            
        }
        
        if (!IsEmpty(responseDic)) {
            // message不可用时为@"", responseObject不可用时为nil
            HCRequestStatus status = [[responseDic objectForKey:KCodeStatus] integerValue];
            
            // 返回错误时, 需要解析message。服务器返回的错误没有用, 因为客户端需要显示中文。
            //token过期
            if (status == HCRequestStatusAccessTokenExpired) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kHCAccessTokenExpiredNotification object:nil];
                return;
            }
            
            NSString *message = @"";
            if (status != HCRequestStatusSuccess) {
                //                message = [self formatMessage:status];
                message = responseDic[@"msg"];
                
            }
            id object = [self formatResponseObject:responseDic];
            
            if (requestBlock) {
                requestBlock(status, message, object);
            }
            
        }else{
            NSString *message = @"";
            //
            message = @"服务器错误";
            // id object = [self formatResponseObject:responseObject];
            
            if (requestBlock) {
                requestBlock(-1, message, nil);
            }
        }
    });
}

- (void)handleFailure:(HCRequestBlock)requestBlock error:(NSError *)error responseHeaders:(NSDictionary *)responseHeaders
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (requestBlock) {
            
            DLog(@"\n error: \n %@", error);
            
         
            
            NSString *msg = @"服务器异常，请稍候再试!";
            switch (error.code) {
                case -1000:
                case -1002:
                    msg = @"系统异常，请稍后再试";
                    break;
                case -1001:
                    msg = @"请求超时，请检查您的网络!";
                    break;
                case -1005:
                case -1006:
                case -1009:
                    msg = @"网络异常，请检查您的网络!";
                    break;
                default:
                    
                    break;
            }
            
            requestBlock(HCRequestStatusFailure, msg, nil);
        }
    });
}

#pragma mark -
-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
- (void)printResponseData
{
    NSData *jsonData;
    if (self.responseJSONObject) {
        jsonData = [NSJSONSerialization dataWithJSONObject:self.responseJSONObject options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSString *jsonString;
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else {
        jsonString = self.responseString;
    }
    
    DLog(@"\n%@\n%@",self.responseHeaders,jsonString);
}


@end
