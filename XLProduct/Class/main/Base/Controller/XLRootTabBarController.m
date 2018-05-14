//
//  XLRootTabBarController.m
//  Project
//
//  Created by Mac on 16/8/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "XLRootTabBarController.h"
//#import "XLHomeViewController.h"
//#import "XLMineViewController.h"
//#import "XLMessageListViewController.h"
@interface XLRootTabBarController ()
{
    UIViewController *_workHome;
}
@end

@implementation XLRootTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate=self;
    
    [self setupChildControllers];
}

- (void)setupChildControllers
{
    _workHome=[[UIViewController alloc]init];
    [self setupChildNavigationControllerWithClass:[UINavigationController class]
                                  tabBarImageName:@"icon_label_find"
                          rootViewControllerClass:_workHome
                          rootViewControllerTitle:@"发现"];
    
    [self setupChildNavigationControllerWithClass:[UINavigationController class]
                                  tabBarImageName:@"icon_label_news"
                          rootViewControllerClass:[[UIViewController alloc]init]
                          rootViewControllerTitle:@"消息"];
    
    [self setupChildNavigationControllerWithClass:[UINavigationController class]
                                  tabBarImageName:@"icon_label_my"
                          rootViewControllerClass:[[UIViewController alloc]init]
                          rootViewControllerTitle:@"我的"];
    
}

- (void)setSelIndex:(NSInteger)selIndex
{
    
    self.selectedIndex = selIndex;
}

- (void)setupChildNavigationControllerWithClass:(Class)class
                                tabBarImageName:(NSString *)name
                        rootViewControllerClass:(UIViewController *)rootViewControllerClass
                        rootViewControllerTitle:(NSString *)title
{
    UIViewController *rootVC = rootViewControllerClass;
    rootVC.title = title;
    UINavigationController *navVc = [[class  alloc] initWithRootViewController:rootVC];
    navVc.tabBarItem.image = OrigIMG(name);
    NSString *selectedImage = [NSString stringWithFormat:@"%@_click",name];
    navVc.tabBarItem.selectedImage = OrigIMG(selectedImage);
    [self addChildViewController:navVc];
}


//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    UINavigationController *nav = (UINavigationController *)viewController;
//
//    if (self.selectedIndex==0&& [nav.viewControllers[0] isKindOfClass:[XLWorksViewController class]]) {
//        NSLog(@"在这刷新");
//        [_workHome requestForRef];
//    }
//
//
//
//    return YES;
//}

@end
