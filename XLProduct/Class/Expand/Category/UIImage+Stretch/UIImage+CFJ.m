//
//  UIImage+CFJ.m
//  商场购物
//
//  Created by user on 15-2-22.
//  Copyright (c) 2015年 xiaodaohang. All rights reserved.
//

#import "UIImage+CFJ.h"

@implementation UIImage (CFJ)
/**
 *  拉伸图片
 */
+ (UIImage *)stretchableImageWithImageName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.7 topCapHeight:image.size.height * 0.9];
    return image;
}
@end
