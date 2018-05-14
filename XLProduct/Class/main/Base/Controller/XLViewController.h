//
//  XLViewController.h
//  Project
//
//  Created by Mac on 16/8/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCRequest.h"
@interface XLViewController : UIViewController
{
    HCRequest    *_baseRequest;
}

@property (nonatomic, strong) NSDictionary *data;


//设置返回按钮
- (void)setupBackItem;
- (void)setupBackItem2;
- (void)backBtnClick;
- (void)setLeftTilte:(NSString *)name;
/**
 *  请求请求系统错误提示
 *
 *  @param error 错误内容
 */
- (void)showErrorHint:(NSError *)error;
- (void)showHUDText:(NSString *)content;
- (void)showHUDView:(NSString *)text;
- (void)showHUDError:(NSString *)error;
- (void)showHUDSuccess:(NSString *)success;
- (void)hideHUDView;

@end
