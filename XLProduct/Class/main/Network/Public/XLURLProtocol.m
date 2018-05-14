//
//  XLURLProtocol.m
//  XLProduct
//
//  Created by 王小林 on 2018/2/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "XLURLProtocol.h"

@implementation XLURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    
    if ([request isKindOfClass:[NSMutableURLRequest class]]) {
        [(id)request setValue:@"iphone" forHTTPHeaderField:@"XX-Device-Type"];
        NSLog(@"加载之后>>>>%@\n%@",request.URL, request.allHTTPHeaderFields);
    }
    return NO;
}

@end
