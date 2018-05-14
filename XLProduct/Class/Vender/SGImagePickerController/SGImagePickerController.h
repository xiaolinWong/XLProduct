//
//  SGImagesPickerController.h
//  SGImagePickerController
//
//  Created by yyx on 15/9/17.
//  Copyright (c) 2015年 yyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGImagePickerController : UINavigationController

//返回用户选择的照片的原图
@property (nonatomic,copy) void(^didFinishSelectImages)(NSArray *images,NSArray*url);

//返回用户选择的照片的缩略图
@property (nonatomic,copy) void(^didFinishSelectThumbnails)(NSArray *thumbnails);

//最大选择图片数
@property (nonatomic,assign) NSInteger maxCount;

//已经选择
@property (nonatomic,strong) NSArray *phoneAry;
@end
