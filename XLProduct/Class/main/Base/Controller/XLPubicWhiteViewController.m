//
//  XLPubicWhiteViewController.m
//  Project
//
//  Created by 王小林 on 2017/3/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "XLPubicWhiteViewController.h"

@interface XLPubicWhiteViewController ()

@end

@implementation XLPubicWhiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     [self anavcontorlor];
}
-(void)anavcontorlor{

    
    //设置导航栏背景色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent =NO;
    //设置导航栏文字图片背景颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置导航栏 文字颜色、字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kXLBlackColorl,NSFontAttributeName:BOLDSYSTEMFONT(18.0)}];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
