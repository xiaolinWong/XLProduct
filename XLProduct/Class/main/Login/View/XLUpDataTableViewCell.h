//
//  XLUpDataTableViewCell.h
//  XLProduct
//
//  Created by Mac on 2018/1/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLUpDataTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^leftBtnClcik)(UIButton *leftBtn);

@property (nonatomic, copy) void(^rightBtnClcik)(UIButton *rightBtn);

@property (nonatomic, copy) void(^nameClcik)(NSString *nameStr);

@property (nonatomic, copy) void(^datePickClcik)(NSString *dateStr);

@property (nonatomic, copy) void(^headImageClcik)(UIButton *headBtn);

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndex:(NSIndexPath *)indexP;

@end
