//
//  HCRequest.h
//  HealthCloud
//
//  Created by Vincent on 15/10/27.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "YTKRequest.h"

typedef NS_ENUM(NSInteger , HCRequestStatus) {
    /*来自服务器定义*/
    //正常
    HCRequestStatusSuccess                   = 1,
    HCRequestStatusLoginUserNotFound         = 404,
    HCRequestStatusLoginUserPasswordNotRight = 501,
    HCRequestStatusLoginInOtherDevice        = 615,     //账号在其他设备登录
    HCRequestStatusAccessTokenExpired        = 10001,//token失效
    /*本地定义*/
    //网络失败
    HCRequestStatusFailure,
    
};

//使用此类时,ZLRequestBlock始终被传递
typedef void (^HCRequestBlock)(HCRequestStatus requestStatus, NSString *message, id responseObject);

@interface HCRequest : YTKRequest

/// (封装层) 发起请求, 返回自定义对象时需要子类调用
// 子类可重写该方法, 实现对参数的逻辑判断
// 只要调用本方法, requestBlock必须传递
- (void)startRequest:(HCRequestBlock)requestBlock;

/// (封装层) 解析, 根据statusCode解析message
// 默认返回@""
// 因为服务器返回的是英文信息, 客户端需要转成中文
- (NSString *)formatMessage:(HCRequestStatus)statusCode;

/// (封装层) 解析，把服务器返回数据转换想要的数据
//默认返回原 data
//通常解析body内数据
- (id)formatResponseObject:(id)responseObject;

@end
