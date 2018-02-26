//
//  HCAppMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/15.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCAppMgr.h"
#import "AppDelegate.h"

#define XLInterForManager @"XLInterForManager"
static HCAppMgr *_sharedManager = nil;

@implementation HCAppMgr
{
    UIView *_scrView;
    UIImage *_allImage;
}
//创建单例
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HCAppMgr alloc] init];
    });
    
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
    
        //token失效
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginTokenInvalided)
                                                     name:kHCAccessTokenExpiredNotification
                                                   object:nil];
        //下线通知
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(accountKickedOffTheLine)
//                                                     name:kHCNotificationOffline
//                                                   object:nil];
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDidTakeScreenshot:)
                                                     name:UIApplicationUserDidTakeScreenshotNotification object:nil];
        
        
        

    }
    return self;
}

+ (void)clean
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _sharedManager = nil;
}


#pragma mark - Setters & Getters

/**
 *  是否首次启动程序，启动加载页
 *
 *
 */
- (BOOL)showInstroView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long long flag = [[defaults objectForKey:@"GUIDE"] longLongValue];
    
    if (flag == 0) //首次运行，加载引导页
    {
        [defaults setObject:@(++flag) forKey:@"GUIDE"];
        [defaults synchronize];
        
        return YES;
    }
    return NO;
}

#pragma mark - Public Methods

//登录
- (void)login
{
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app setupRootViewController];
}

//注销
- (void)logout
{
    //想服务端发送注销请求
    [self requestLogout];
//
//    [[HCAccountMgr manager] clean];
//
//    [HCAccountMgr manager].isLogined=NO;
    
    [self login];
}

/**
 *  token失效，提醒用户重新登录
 */
- (void)loginTokenInvalided
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"您的登录会话已失效，请重新登录。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
//    [alert handlerClickedButton:^(UIAlertView *alert, NSInteger index){
//        //清空数据，返回登录
//        [[HCAccountMgr manager] clean];
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [app setupRootViewController];
//    }];
//    [alert show];
}

/**
 *  登出
// */
- (void)requestLogout
{
//    HCLogoutApi *api = [[HCLogoutApi alloc] init];
//    [api startRequest:nil];
}
//是否获取了推送权限
-(BOOL)isHavePushMessage
{
//    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0f) {
    
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (UIUserNotificationTypeNone == setting.types) {
            NSLog(@"推送关闭 8.0");
            NSUserDefaults *defauts=[NSUserDefaults standardUserDefaults];
            
            NSString *integr=[defauts objectForKey:XLInterForManager];
            if (IsEmpty(integr)) {
                integr=@"0";
            }
            NSLog(@">>>%@",integr);
            if ([integr intValue]%50==0) {
                
                integr =[NSString stringWithFormat:@"%d",[integr intValue]+1];
                [defauts setObject:integr forKey:XLInterForManager];
            }else{
                integr =[NSString stringWithFormat:@"%d",[integr intValue]+1];
                 [defauts setObject:integr forKey:XLInterForManager];
            }
            return NO;
        }
        else
        {
            NSLog(@"推送打开 8.0");
            return YES;
        }
//    }
//    else
//    {
//        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//
//        if(UIRemoteNotificationTypeNone == type){
//            NSLog(@"推送关闭");
//            return NO;
//        }
//        else
//        {
//            NSLog(@"推送打开");
//            return YES;
//        }
//    }
    
    
}
#pragma mark 获取时间差
-(void)serverDiffTimeCheck{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *appserverTime = [defaults objectForKey:APPServerTime];
//    if (!IsEmpty(appserverTime)) {
//
//        self.serverDifftime=appserverTime;
//
//    }
//
//    NSString * url_str = [NSString stringWithFormat:@"http://www.laowuquan.cc/api/index/serverTime"];
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//
//    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
//    [manager GET:url_str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dic=responseObject;
//
//        NSString *serverTime=dic[@"data"];
//
//        NSString *appTime=[NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970]];
//        NSLog(@">>>serverTime%@>>>>appTime%@",serverTime,appTime);
//        self.serverDifftime=[NSString stringWithFormat:@"%d",[serverTime intValue]-[appTime intValue]];
//
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:self.serverDifftime forKey:APPServerTime];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@", error);
//    }];
}

#pragma mark 截屏
//截屏响应
- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    NSLog(@"检测到截屏");
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot:@""];
    _allImage=[self imageWithScreenshot:@"all"];
    
    CGFloat width =SCREEN_WIDTH/(75/19);
    CGFloat height=width/190*300;
    
    _scrView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-width-40, (SCREEN_HEIGHT-height)/2+50,width ,height )];
    _scrView.backgroundColor=[UIColor whiteColor];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,width , width/190*130)];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    imageView.image=image_;
    [_scrView addSubview:imageView];
    
  
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
    backBtn.backgroundColor=[UIColor blackColor];
    backBtn.alpha=0.64;
    [backBtn setImage:IMG(@"icon_hiring_write_white") forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, width/190*130, width, (height-width/190*130)/2-1);
//    [backBtn addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrView addSubview:backBtn];
    
    UIButton *shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setTitle:@"分享界面" forState:UIControlStateNormal];
    [shareBtn setImage:IMG(@"icon_conventional_forwarding_white") forState:UIControlStateNormal];
    shareBtn.backgroundColor=[UIColor blackColor];
    shareBtn.alpha=0.64;
//    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.frame=CGRectMake(0, width/190*130+ (height-width/190*130)/2, width, (height-width/190*130)/2-1);
    [_scrView addSubview:shareBtn];

    ViewBorderRadius(_scrView, 5, 1, XLBlackColor);
    
    [WINDOW addSubview:_scrView];
    
    WEAKSELF
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf closeView];
    });
 
}


//关闭
-(void)closeView{
    CGRect oldFrame =_scrView.frame;
    [UIView animateWithDuration:0.5 animations:^{
        _scrView.frame=CGRectMake(oldFrame.origin.x,oldFrame.origin.y , 0, 0);
    } completion:^(BOOL finished) {
        [_scrView removeFromSuperview];
    }];
}
/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat:(NSString *)type
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
//
        if ([type isEqualToString:@"all"]) {
            imageSize = [UIScreen mainScreen].bounds.size;
        }else{
            imageSize=CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/190*130);
        }
    
    else
        imageSize = CGSizeMake(SCREEN_HEIGHT, SCREEN_WIDTH);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot:(NSString *)type
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat:type];
    return [UIImage imageWithData:imageData];
}



//获取当前的viewContr
-(UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
