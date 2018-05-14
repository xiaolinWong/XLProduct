//
//  XLViewController.m
//  Project
//
//  Created by Mac on 16/8/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "XLViewController.h"
#import "MBProgressHUD.h"
#import "YTKNetworkAgent.h"
//#import <AudioToolbox/AudioToolbox.h>
#import "XLBarButtonItem.h"
@interface XLViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *_HUD;
}
@end

@implementation XLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   //支持左滑pop
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self registerNotifications];
     [self navcontorlor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self unregisterNotifications];
}


-(void)navcontorlor{
    [[UIBarButtonItem appearance]
     setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
     forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = kHCBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //设置导航栏背景色
    [self.navigationController.navigationBar setBarTintColor:kHCNavBarColor];
    self.navigationController.navigationBar.translucent =NO;
    //设置导航栏文字图片背景颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置导航栏 文字颜色、字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:BOLDSYSTEMFONT(18.0)}];
    
    
    
    //tabBar 背景颜色
    UIImage *tabImg = [Utils createImageWithColor:kXLWhiteColor];
    [self.tabBarController.tabBar setBackgroundImage:tabImg];
    [self.tabBarController.tabBar setTintColor:kHCNavBarColor];
    
    //状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //去掉下面的线
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}
- (void)dealloc
{
    //销毁当前网络请求
    if (_baseRequest) {
        [[YTKNetworkAgent sharedAgent] cancelRequest:_baseRequest];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)setupBackItem
{
    XLBarButtonItem *item = [[XLBarButtonItem alloc] initWithBackTarget:self action:@selector(backBtnClick)andImageName:@"icon_navigation_return"];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)setupBackItem2
{
    XLBarButtonItem *item = [[XLBarButtonItem alloc] initWithBackTarget:self action:@selector(backBtnClick)andImageName:@"icon_navigation_return"];
    self.navigationItem.leftBarButtonItem = item;
}
-(void)setLeftTilte:(NSString *)name{
    
    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, 44)];
    lable.text=name;
    lable.textColor=[UIColor whiteColor];
    lable.font=SYSTEMFONT(15);
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(-10, 12, 1, 20)];
//    view.backgroundColor=[UIColor whiteColor];
//    [lable addSubview:view];
    self.navigationItem.titleView = lable;
}
- (void)backBtnClick
{
    //销毁当前网络请求
    [self hideHUDView];
    if (_baseRequest) {
        [[YTKNetworkAgent sharedAgent] cancelRequest:_baseRequest];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSDictionary *)data{
    if (!_data) {
        _data=[[NSDictionary alloc]init];
    }
    return _data;
}
#pragma mark - touchesBegan

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击空白 消除键盘
    [self.view endEditing:YES];
}

#pragma mark - HUDView

- (void)showErrorHint:(NSError *)error
{
    NSString *msg = @"服务器异常，请稍候再试!";
    switch (error.code) {
        case -999:
            //请求取消，不提示
            return;
        case -1000:
        case -1002:
            msg = @"系统异常，请稍后再试";
            break;
        case -1001:
            msg = @"请求超时，请检查您的网络!";
            break;
        case -1004:
        case -1005:
        case -1006:
        case -1009:
            msg = @"网络异常，请检查您的网络!";
            break;
        default:
            break;
    }
    [self show:msg icon:nil];
}

- (void)showHUDView:(NSString *)text
{
    [self hideHUDView];
    
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.delegate = self;
    _HUD.label.text = text;
    [self.view endEditing:YES];
}

- (void)hideHUDView
{
    [_HUD hideAnimated:YES];
}

#pragma mark - HUD显示异常

- (void)showHUDText:(NSString *)content
{
    [self show:content icon:nil];
}

- (void)showHUDError:(NSString *)error
{
    [self show:error icon:@"hud_error"];
}

- (void)showHUDSuccess:(NSString *)success
{
    [self show:success icon:@"hud_success2"];
}

- (void)show:(NSString *)text icon:(NSString *)icon
{
    [self hideHUDView];
    UIView *view = self.view;//[UIApplication sharedApplication].keyWindow;
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.2];
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    _HUD = nil;
}



@end
