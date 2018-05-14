//
//  XLImageChooseMgr.m
//  XLProduct
//
//  Created by 王小林 on 2018/3/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "XLImageChooseMgr.h"
#import "SGImagePickerController.h"

static XLImageChooseMgr *_sharedManager = nil;

@interface XLImageChooseMgr()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    UIImagePickerController *selectpicker;
    BOOL _isMorePhoto;
    int _maxNum;
}
@property (nonatomic, copy) void(^uploadCompletionBlock) (BOOL result, UIImage *image, NSString *msg);
@property (nonatomic, copy) void(^uploadAryPhotoCompletionBlock) (BOOL result, NSArray *ary, NSString *msg,NSArray *lastArr);


@property (nonatomic, weak) UIViewController *delegate;

@end
@implementation XLImageChooseMgr

//创建单例
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[XLImageChooseMgr alloc] init];
    });
    
    return _sharedManager;
}
- (void)modifyAvatarWithController:(UIViewController *)vc
                        completion:(void (^)(BOOL result, UIImage *image, NSString *msg))completion
{
    self.delegate = vc;
    self.uploadCompletionBlock = completion;
    _isMorePhoto=NO;
    [self showActionSheet];
}
-(void)modifyArrayWithController:(UIViewController *)vc withMaxNum:(int)max completion:(void (^)(BOOL, NSArray *, NSString *,NSArray*))completion
{
    self.delegate = vc;
    self.uploadAryPhotoCompletionBlock = completion;
    _isMorePhoto=YES;
    _maxNum=max;
    [self showActionSheet];
}
- (void)showActionSheet
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
    UIWindow *keyWindow = WINDOW;
    [action showInView:keyWindow];
}
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        //NSLog(@"拍照");
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex == 1){
        //NSLog(@"从手机相册选择");
        
        if (_isMorePhoto) {
            //多选
            SGImagePickerController *picker = [[SGImagePickerController alloc] init];
            //        picker.phoneAry=self.phoneAry;
            picker.maxCount =_maxNum;
            
            //返回选中的原图
            [picker setDidFinishSelectImages:^(NSArray *images,NSArray *urlArr) {
                
                
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                for (UIImage *iamge in images) {
                    
                    UIImage *new=nil;
                    
                    new= [self compressImage:iamge toTargetWidth:600];
                    
                    
                    [arr addObject:new];
                }
                
                self.uploadAryPhotoCompletionBlock(YES,arr,nil,urlArr);
            }];
            [self.delegate presentViewController:picker animated:YES completion:nil];
            return;
        }
        
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        return;
    }
    
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    [[picker navigationBar] setTintColor:kXLBlackColorl];
    picker.delegate = self;
    picker.sourceType = sourceType;
    if (!_isMorePhoto) {
        picker.allowsEditing = YES;
    }
    selectpicker=picker;
    [self.delegate presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // bug fixes: UIIMagePickerController使用中偷换StatusBar颜色的问题
    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
        ((UIImagePickerController *)navigationController).sourceType ==     UIImagePickerControllerSourceTypePhotoLibrary) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (_isMorePhoto) {
       image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    //等比压缩
    UIImage *newImage=[self compressImage:[Utils fixOrientation:image] toTargetWidth:600];
    if (_isMorePhoto) {
        self.uploadAryPhotoCompletionBlock(YES,@[newImage],nil,nil);
        
    }else{
        self.uploadCompletionBlock(YES, newImage, @"");
        
    }
    
    [selectpicker dismissViewControllerAnimated:YES completion:nil];
}
//对图片等比压缩
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    //先判断高宽
    if (width>height) {
        if (width>=targetWidth) {
            CGFloat targetHeight = (targetWidth / width) * height;
            
            UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
            [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return newImage;
        }else{
            return sourceImage;
        }
        
    }else{
        if (height>=targetWidth) {
            CGFloat targetWidth2 = (targetWidth / height) * width;
            
            UIGraphicsBeginImageContext(CGSizeMake(targetWidth2, targetWidth));
            [sourceImage drawInRect:CGRectMake(0, 0, targetWidth2, targetWidth)];
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return newImage;
        }else{
            return sourceImage;
        }
        
    }
}

@end
