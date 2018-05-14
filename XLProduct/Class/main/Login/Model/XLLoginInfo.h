//
//  XLLoginInfo.h
//  XLProduct
//
//  Created by Mac on 2018/1/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLLoginInfo : NSObject

@property (nonatomic, copy) NSString      *nickname;
@property (nonatomic, copy) NSString      *avatar;
@property (nonatomic, copy) NSString      *user_id;
@property (nonatomic, copy) NSString      *openim_id;
@property (nonatomic, copy) NSString      *openim_pw;
@property (nonatomic, copy) NSString      *token;
@property (nonatomic, copy) NSString      *mobile;
@property (nonatomic, copy) NSString      *has_resume;//是否有简历
@end
