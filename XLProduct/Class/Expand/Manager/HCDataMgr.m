//
//  HCDataMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/16.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCDataMgr.h"

static HCDataMgr *_sharedManager = nil;

@implementation HCDataMgr

//创建单例
+ (instancetype)manager
{
    if (!_sharedManager) {
        _sharedManager = [[HCDataMgr alloc] init];
    }
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}


+ (void)clean
{
    _sharedManager = nil;
}


@end
