//
//  YTKUrlArgumentsFilter.h
//  Project
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKNetworkConfig.h"
//#import "YTKNetworkPrivate.h"
@interface YTKUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>

+ (YTKUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;

@end
