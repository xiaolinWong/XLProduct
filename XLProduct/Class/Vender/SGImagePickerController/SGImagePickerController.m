//
//  SGImagesPickerController.m
//  SGImagePickerController
//
//  Created by yyx on 15/9/17.
//  Copyright (c) 2015年 yyx. All rights reserved.
//

#import "SGImagePickerController.h"
#import "SGAssetsGroupController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface SGImagePickerController ()
@property (nonatomic,strong) SGAssetsGroupController *assetsGroupVC;
@end

@implementation SGImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (instancetype)init{

    if (self = [super initWithRootViewController:self.assetsGroupVC]) {
        self.maxCount = LONG_MAX;
        UINavigationBar *navBar = [UINavigationBar appearance];
        //导航条背景色
        navBar.barTintColor = [UIColor whiteColor];
        //字体颜色
        navBar.tintColor = kXLBlackColorl;
    }
    return self;
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    return  [self init];
}
- (SGAssetsGroupController *)assetsGroupVC{
    if (_assetsGroupVC == nil) {
    _assetsGroupVC = [[SGAssetsGroupController alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"选择相册";
    [titleLabel sizeToFit];
    _assetsGroupVC.navigationItem.titleView = titleLabel;
    
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    _assetsGroupVC.navigationItem.leftBarButtonItem = cancelItem;
    }
    return _assetsGroupVC;
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setMaxCount:(NSInteger)maxCount{
    _maxCount = maxCount;
    if (maxCount > 0) {
        self.assetsGroupVC.maxCount = maxCount;
    }
}

-(void)setPhoneAry:(NSArray *)phoneAry
{
    _phoneAry=phoneAry;
    if (_phoneAry.count) {
        self.assetsGroupVC.phoneAry =_phoneAry;
    }
}
@end
