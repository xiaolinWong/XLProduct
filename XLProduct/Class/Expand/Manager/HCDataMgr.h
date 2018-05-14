//
//  HCDataMgr.h
//  HealthCloud
//
//  Created by Vincent on 15/9/16.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDataMgr : NSObject

@property (nonatomic, assign) BOOL needUpdate;//首页列表
@property (nonatomic, assign) BOOL myProfileUpDate;//个人界面

//创建单例
+ (instancetype)manager;
+ (void)clean;

@end
