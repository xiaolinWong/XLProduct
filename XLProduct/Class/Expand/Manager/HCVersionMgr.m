//
//  HCUpdateMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/17.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCVersionMgr.h"
#import <AFNetworking.h>

#define APPStoreAppVersion @"appstoreappversion"
#define APPVersionTime  @"appversiontime"//一天一次

@interface HCVersionMgr()

@property (nonatomic, strong) NSString *appStoreVersion;

@property (nonatomic, strong) NSString *releaseNotes;//更新笔记

@end

static HCVersionMgr *_sharedManager = nil;

@implementation HCVersionMgr

//创建单例
+ (instancetype)manager
{
    if (!_sharedManager) {
        _sharedManager = [[HCVersionMgr alloc] init];
    }
    return _sharedManager;
}

- (void)checkFirVersion
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate *time=[defaults objectForKey:APPVersionTime];

    if (!IsEmpty(time)&&[[Utils intervalSinceNow:time] doubleValue]<=24*60*60) {
        //如果没到一天  不弹出
        return;
    }
    //q请求appstore
    
    NSString * url_str = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=1148870943"];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
//    [manager GET:url_str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //从数据字典中检出版本号数据
//        NSArray *configData = [responseObject valueForKey:@"results"];
//        
//        for(id config in configData)
//        {
//            _appStoreVersion = [config valueForKey:@"version"];
//            _releaseNotes=[config valueForKey:@"releaseNotes"];
//            
//            self.alertView.version=_appStoreVersion;
//            self.alertView.releaseNotes=_releaseNotes;
//        }
//        
//        // 忽略版本
//     
//        NSString *loseVersion =nil;
//        
//        if (IsEmpty(loseVersion)) {
//            loseVersion=APP_VERSION;
//        }
//        if (([_appStoreVersion compare:APP_VERSION options:NSNumericSearch] == kCFCompareGreaterThan) && ([_appStoreVersion compare:loseVersion options:NSNumericSearch] == kCFCompareGreaterThan))
//        {
//            //弹出
//         
//            
//            UIWindow *window=[[UIApplication sharedApplication] keyWindow];
//            
//            [window addSubview:self.alertView];
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@", error);
//    }];
}



@end
