//
//  XLUPMoreImageAPI.h
//  Project
//
//  Created by 王小林 on 2016/12/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HCRequest.h"

typedef void (^HCUploadHeadImageBlock)(HCRequestStatus requestStatus, NSString *message, NSDictionary *data);

@interface XLUPMoreImageAPI : HCRequest

- (void)startRequest:(HCUploadHeadImageBlock)requestBlock;
@property (nonatomic, strong) NSString *requestStr;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSDictionary *dic;

@end
