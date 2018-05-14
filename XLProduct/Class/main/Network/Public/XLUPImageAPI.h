//
//  XLUPImageAPI.h
//  Project
//
//  Created by 王小林 on 16/8/25.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HCRequest.h"


typedef void (^HCUploadHeadImageBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface XLUPImageAPI : HCRequest

- (void)startRequest:(HCUploadHeadImageBlock)requestBlock;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSDictionary *Argument;

@property (nonatomic, strong) NSString *requestUrlstr;
@end
