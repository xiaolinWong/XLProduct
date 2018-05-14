//
//  AppDelegate.m
//  XLProduct
//
//  Created by Mac on 2017/12/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "YTKNetworkConfig.h"
#import "XLRootTabBarController.h"
#import "XLWelComeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置网络参数
    [self setupCustomProperty];
    //设置主控制器
    [self setupRootViewController];
    
    return YES;
}

//设置主控制器
- (void)setupRootViewController
{
   
    if ([HCAppMgr manager].showInstroView)
    {
        [self chageRootViewControll: [[XLWelComeViewController alloc] init] animate:YES];
    }else
    {
        [[HCAccountMgr manager] getLoginInfoData];
        
        if ([HCAccountMgr manager].isLogined) {
            
            [self chageRootViewControll: [[XLRootTabBarController alloc] init] animate:YES];
            
        }else{
            UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"XLLoginSB" bundle:nil];
            
            UINavigationController *nav=[storyBoard instantiateInitialViewController];
            
            // self.window.rootViewController = nav;
            [self chageRootViewControll:nav animate:YES];
            
        }
    }
}
-(void)chageRootViewControll:(UIViewController *)contorll animate:(BOOL)animate{
    
    //设置主控制器的动画
    CATransition *transition=[CATransition animation];
    transition.duration=animate?0:1.0;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type=kCATransitionFade;
    self.window.rootViewController=contorll;
    [self.window.layer addAnimation:transition forKey:@"animation"];
    
}

- (void)setupCustomProperty
{
    
    //设置网络端口
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl =kAPIURL;//外部
    config.baseUrl = kAPIURLText;//测试
    config.cdnUrl =  kIMGURL;
//    添加token
//    [NSURLProtocol registerClass:[XLMyURLProtocol class]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"XLProduct"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
