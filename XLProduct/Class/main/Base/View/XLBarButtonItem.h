//
//  XLBarButtonItem.h
//  Project
//
//  Created by Mac on 16/8/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLBarButtonItem : UIBarButtonItem
//返回按钮
- (id)initWithBackTarget:(id)target action:(SEL)action andImageName:(NSString *)name;
//
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
