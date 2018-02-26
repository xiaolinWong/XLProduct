//
//  HCUpdateMgr.h
//  HealthCloud
//
//  Created by Vincent on 15/9/17.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCVersionMgr : NSObject
{
    NSString    *_updateURL;
}

//创建单例
+ (instancetype)manager;

//检查Fir.im版本更新
- (void)checkFirVersion;

@end
