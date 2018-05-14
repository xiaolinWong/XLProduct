//
//  HCAccountDBMgr.h
//  HealthCloud
//
//  Created by Vincent on 15/9/23.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLLoginInfo.h"

typedef void (^HCAccountInfo)(XLLoginInfo *loginInfo);

@interface HCAccountDBMgr : NSObject
{
    
}

//创建单例
+ (instancetype)manager;
+ (void)clean;

/**
 *  插入一条数据库
 *
 *  param  插入用户登录信息
 *
 *  @return 更新语句的执行结果
 */
- (BOOL)insertLoginInfo:(XLLoginInfo *)loginInfo;

/* 
 *读取
 */
- (void)queryLastUserInfo:(HCAccountInfo)accountInfo;


/**
 *  更新用户登录信息：密码，头像等
 *
 *  param  用户信息
 *
 *  @return 更新语句的执行结果
 */
- (BOOL)updateLoginInfo:(XLLoginInfo *)info;

/**
 *  清空表（但不清除表结构）
 *
 *  param table  表名
 *
 *  @return 操作结果
 */
- (BOOL)truncateTable;


/**
 *  清空表（同时清除表结构）
 *
 *  param table  表名
 *
 *  @return 操作结果
 */
- (BOOL)dropTable;
@end
