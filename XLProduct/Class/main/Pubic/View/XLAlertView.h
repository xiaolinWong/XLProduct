//
//  XLAlertView.h
//  XLProduct
//
//  Created by 王小林 on 2018/3/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^XLCancelBlock)(void);
typedef void (^XLConfirmBlock)(void);
@interface XLAlertView : NSObject

@property (nonatomic, copy) XLCancelBlock cancelBlock;
@property (nonatomic, copy) XLConfirmBlock confirmBlock;

+ (XLAlertView *)sharedInstance;
//提示框
- (void)showWithParentViewController:(UIViewController *)parentVC
                               title:(NSString *)title
                             message:(NSString *)message
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                  confirmButtonTitle:(NSString *)confirmButtonTitle
                        confirmBlock:(XLConfirmBlock)confirm
                         cancelBlock:(XLCancelBlock)cancel;

@end
