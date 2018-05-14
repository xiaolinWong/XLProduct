//
//  XLBarButtonItem.m
//  Project
//
//  Created by Mac on 16/8/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "XLBarButtonItem.h"
//#define kButtonHeight 44
//#define kButtonTitleFontSize 14
//#define kButtonTitlePadding 13

@implementation XLBarButtonItem
{
    UIButton    *_customBtn;
}

- (id)initWithBackTarget:(id)target action:(SEL)action andImageName:(NSString *)name
{
    _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self = [super initWithCustomView:_customBtn]) {
        
        _customBtn.frame = CGRectMake(0, 0, 30, 30);
        //_customBtn.backgroundColor = [UIColor redColor];
        [_customBtn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [_customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self = [super initWithCustomView:_customBtn]) {
        UIFont *font = [UIFont boldSystemFontOfSize:14];
        CGRect rectToFit = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
        
        _customBtn.frame = CGRectMake(5, 0, rectToFit.size.width+12, 40);
        _customBtn.titleLabel.font = font;
        [_customBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_customBtn setTitle:title forState:UIControlStateNormal];
        [_customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
