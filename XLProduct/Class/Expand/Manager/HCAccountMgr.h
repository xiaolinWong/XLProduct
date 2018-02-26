//
//  HCAccountMgr.h
//  HealthCloud
//
//  Created by Vincent on 15/9/14.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "HCLoginInfo.h"
//#import "HCUserInfo.h"
//#import "HCertificateInfo.h"

@interface HCAccountMgr : NSObject

//@property (nonatomic, strong) HCLoginInfo       *loginInfo; //登陆信息
//@property (nonatomic, strong) HCUserInfo        *userInfo;

@property (nonatomic, assign) BOOL  isLogined;

//创建单例
+ (instancetype)manager;
/**
 *  账户退出时调用，会清空用户在数据库的所有数据
 */
- (void)clean;

//更新数据库的登录信息
- (void)updateLoginInfoToDB;

//更新数据库的用户信息
//- (void)updateUserInfoToDB;

//保存用户登录信息
- (void)saveLoginInfoToDB;

// 本地获取用户信息
- (void)getLoginInfoData;

- (void)login;

@end
