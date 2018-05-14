//
//  XLImageChooseMgr.h
//  XLProduct
//
//  Created by 王小林 on 2018/3/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLImageChooseMgr : NSObject
//单张选择
-(void)modifyAvatarWithController:(UIViewController *)vc
                       completion:(void (^)(BOOL result, UIImage *image, NSString *msg))completion;

//多张选择
-(void)modifyArrayWithController:(UIViewController *)vc withMaxNum:(int)max completion:(void (^)(BOOL result, NSArray *data, NSString *msg,NSArray *lastArr))completion;
//创建单例
+ (instancetype)manager;

@end
