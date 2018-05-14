//
//  YTKUrlArgumentsFilter.m
//  Project
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "YTKUrlArgumentsFilter.h"

@implementation YTKUrlArgumentsFilter
{
    NSDictionary *_arguments;
}

+ (YTKUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {

    return nil;
//    NSString*str=@"";
//    return [YTKNetworkPrivate urlStringWithOriginUrlString:str appendParameters:_arguments];
}
@end
