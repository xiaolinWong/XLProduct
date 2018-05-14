//
//  XLFinshBtn.m
//  XLProduct
//
//  Created by Mac on 2018/1/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "XLFinshBtn.h"

@implementation XLFinshBtn

-(instancetype)initWithFrame:(CGRect)frame withTile:(NSString *)text{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=kHCNavBarColor;
        ViewShadowRadius(self, frame.size.height/2, 0, 5, kXLShadowBuleColor, 0.5, 2.0);
        [self setTitle:text forState:UIControlStateNormal];
    }
    return self;
}
@end
