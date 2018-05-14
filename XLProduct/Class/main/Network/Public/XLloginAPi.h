//
//  XLloginAPi.h
//  Project
//
//  Created by 王小林 on 16/8/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HCRequest.h"
@class XLLoginInfo;
typedef void (^XLLoginApiBlock)(HCRequestStatus requestStatus, NSString *message,XLLoginInfo *longinInfo);
@interface XLloginAPi : HCRequest
@property (nonatomic, strong)NSString *phoneNumber;
@property (nonatomic, strong)NSString *codeNumber;
-(void)startRequest:(XLLoginApiBlock)requestBlock;
@end
