//
//  XLloginAPi.m
//  Project
//
//  Created by 王小林 on 16/8/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "XLloginAPi.h"
#import "XLLoginInfo.h"
@implementation XLloginAPi
-(void)startRequest:(XLLoginApiBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(id)formatResponseObject:(id)responseObject{
    XLLoginInfo *loginInfo=[XLLoginInfo mj_objectWithKeyValues:responseObject[@"data"]];
    return loginInfo;
}
-(id)requestArgument{
    
    return @{@"username":self.phoneNumber,@"code":self.codeNumber};
}
-(NSString *)requestUrl{
    return @"user/public/login";
}
@end
