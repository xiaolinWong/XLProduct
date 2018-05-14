//
//  XLPubicRequsetApi.h
//  Project
//
//  Created by Mac on 16/8/4.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@interface XLPubicRequsetApi : HCRequest

@property (nonatomic, strong) NSDictionary *dicBody;
@property (nonatomic, strong) NSString *requestStr;
//@property (nonatomic, assign) YTKRequestMethod  requestMethod;
@end
