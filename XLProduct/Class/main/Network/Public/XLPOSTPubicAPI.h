//
//  XLPOSTPubicAPI.h
//  Project
//
//  Created by Mac on 2017/9/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "XLPubicRequsetApi.h"

@interface XLPOSTPubicAPI : HCRequest
@property (nonatomic, strong) NSDictionary *dicBody;
@property (nonatomic, strong) NSString *requestStr;

@property (nonatomic, assign) YTKRequestMethod method;

@end
