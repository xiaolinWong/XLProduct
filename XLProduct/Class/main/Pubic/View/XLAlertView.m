//
//  XLAlertView.m
//  XLProduct
//
//  Created by 王小林 on 2018/3/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "XLAlertView.h"

@implementation XLAlertView
+ (XLAlertView *)sharedInstance {
    
    static XLAlertView *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

- (void)showWithParentViewController:(UIViewController *)parentVC
                               title:(NSString *)title
                             message:(NSString *)message
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                  confirmButtonTitle:(NSString *)confirmButtonTitle
                        confirmBlock:(XLConfirmBlock)confirm
                         cancelBlock:(XLCancelBlock)cancel
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelButtonTitle) {
        [alertVC addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) {
                cancel();
            }
        }]];
    }
    if (confirmButtonTitle) {
        [alertVC addAction:[UIAlertAction actionWithTitle:confirmButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirm) {
                confirm();
            }
        }]];
    }
    
    if (parentVC) {
        [parentVC presentViewController:alertVC animated:YES completion:NULL];
    }else {
        [WINDOW.rootViewController presentViewController:alertVC animated:YES completion:NULL];
    }
    
}

@end
