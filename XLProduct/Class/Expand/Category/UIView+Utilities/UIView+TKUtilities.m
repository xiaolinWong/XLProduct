//
//  UIView+TKUtilities.m
//  MHPocket
//
//  Created by Mac on 14-3-17.
//
//

#import "UIView+TKUtilities.h"

@implementation UIView (TKUtilities)

- (void)removeAllSubviews
{
    for (UIView *one in [self subviews]) {
        
        [one removeFromSuperview];
    }
}

@end
