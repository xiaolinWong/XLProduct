//
//  HCAccountDBMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/23.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCAccountDBMgr.h"
#import "FMDB.h"

#define kHCDBTableNeedUpdate    @"kXLDBTableNeedUpdate"   //表单是否需要更新
#define kHCDBTableUser          @"UserInfo"
#define kHCDBName               @"hcn.sqlite"

static HCAccountDBMgr *_sharedManager = nil;

@interface HCAccountDBMgr ()
/**
 *  具有线程安全的数据队列
 */
@property (nonatomic,strong) FMDatabaseQueue *queue;

@end


@implementation HCAccountDBMgr

//创建单例
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HCAccountDBMgr alloc] init];
    });
    
    return _sharedManager;
}

/**
 *  数据库队列的初始化：本操作一个
 */
+(void)initialize{
    
    //取出实例
    HCAccountDBMgr *coreFMDB=[HCAccountDBMgr manager];
    
    //在沙盒中存入数据库文件
    NSString *documentFolder=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *folder=[NSString stringWithFormat:@"%@/%@",documentFolder,@"DB"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:folder isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *dbPath=[folder stringByAppendingPathComponent:kHCDBName];

    DLog(@"dbPath:%@",dbPath);
    //创建队列
    FMDatabaseQueue *queue =[FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    if(queue==nil)  NSLog(@"code=1：创建数据库失败，请检查");
    
    coreFMDB.queue = queue;
    
    //表单已经更新，需要删除重新创建
   
    BOOL updated = [[kXLUserDefult objectForKey:kHCDBTableNeedUpdate] boolValue];
    if (!updated) {
        [coreFMDB dropTable];
        [kXLUserDefult setObject:@"1" forKey:kHCDBTableNeedUpdate];
        [kXLUserDefult synchronize];
    }
    
    //创建表单
    [coreFMDB createAccountTable];
}

+ (void)clean
{
    _sharedManager = nil;
}

/**
 *  创建表结构
 *  @return 更新语句的执行结果
 */
- (BOOL)createAccountTable
{
    __block BOOL createRes = NO;
    
    [self.queue inDatabase:^(FMDatabase *db) {

        NSString *sql = [NSString stringWithFormat:
                         @"CREATE TABLE IF NOT EXISTS '%@'(\
                         id INTEGER PRIMARY KEY AUTOINCREMENT,\
                         nickname TEXT, \
                         user_id TEXT,\
                         avatar TEXT,\
                         openim_id TEXT,\
                         token TEXT,\
                         openim_pw TEXT);",
                         kHCDBTableUser];
        createRes = [db executeUpdate:sql];
    }];
    
    return createRes;
}


/**
 *  插入一条数据库
 *
 *  param 用户信息
 *
 *  @return 更新语句的执行结果
 */

- (BOOL)insertLoginInfo:(XLLoginInfo *)loginInfo
{
    //清空表数据
    [self truncateTable];
    
    if (!IsEmpty(loginInfo.token)) {
        
        [self dropTable];
        [self createAccountTable];
    }
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO '%@' (\
                           nickname,\
                           user_id,\
                           avatar,\
                           openim_id,\
                           token,\
                           openim_pw)\
                           VALUES ('%@', '%@', '%@', '%@', '%@', '%@');",
                           kHCDBTableUser,
                           loginInfo.nickname,
                           loginInfo.user_id,
                           loginInfo.avatar,
                           loginInfo.openim_id,
                           loginInfo.token,
                           loginInfo.openim_pw];
    BOOL res = [self executeUpdate:insertSql];
    return res;
}

/**
 *  更新用户信息
 *
 *  @para m 用户信息
 *
 *  @return 更新语句的执行结果
 */

- (BOOL)updateLoginInfo:(XLLoginInfo *)info
{
    if (info.user_id) {
        
        NSString *modifySql = [NSString stringWithFormat:@"UPDATE '%@' SET nickname = '%@',avatar = '%@',openim_id = '%@', token = '%@', openim_pw = '%@' WHERE user_id = '%@';",kHCDBTableUser,info.nickname,info.avatar,info.openim_id,info.token,info.openim_pw,info.user_id];
        
        return [self executeUpdate:modifySql];
    }
    
    return NO;
}

/**
 *  更新用户信息
 *
 *  @pa ram 用户信息
 *
 *  @re urn 更新语句的执行结果
 */


- (void)queryLastUserInfo:(HCAccountInfo)accountInfo
{
    [self.queue inDatabase:^(FMDatabase *db) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from '%@';",kHCDBTableUser];
        
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            XLLoginInfo *loginInfo = [[XLLoginInfo alloc] init];
            
            loginInfo.user_id = [set stringForColumn:@"user_id"];
            loginInfo.nickname = StringFromObject([set stringForColumn:@"nickname"]);
            loginInfo.avatar = StringFromObject([set stringForColumn:@"avatar"]);
            loginInfo.openim_id = StringFromObject([set stringForColumn:@"openim_id"]);
            loginInfo.openim_pw = StringFromObject([set stringForColumn:@"openim_pw"]);
            loginInfo.token = StringFromObject([set stringForColumn:@"token"]);
           
            accountInfo(loginInfo);
            
            return;
        }
        
    }];
//    return NO;
}

/**
 *  执行一个更新语句
 *
 *  @param sql 更新语句的sql
 *
 *  @return 更新语句的执行结果
 */
- (BOOL)executeUpdate:(NSString *)sql{
    
    __block BOOL updateRes = NO;
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        updateRes = [db executeUpdate:sql];
    }];
    
    return updateRes;
}

/**
 *  清空表（但不清除表结构）
 *
 *  param table 表名
 *
 *  @return 操作结果
 */
- (BOOL)truncateTable {
    
    return [self executeUpdate:[NSString stringWithFormat:@"DELETE FROM '%@'", kHCDBTableUser]];
}

/**
 *  清空表（同时清除表结构）
 *
 *  param table 表名
 *
 *  @return 操作结果
 */
- (BOOL)dropTable {
    
    return [self executeUpdate:[NSString stringWithFormat:@"DROP TABLE '%@'", kHCDBTableUser]];
}


@end
