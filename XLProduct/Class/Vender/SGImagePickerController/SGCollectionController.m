//
//  SGCollectionController.m
//  SGImagePickerController
//
//  Created by yyx on 15/9/20.
//  Copyright (c) 2015年 yyx. All rights reserved.
//

#import "SGCollectionController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SGAssetModel.h"
#import "SGPhotoBrowser.h"
#import "SGImagePickerController.h"
#import "MBProgressHUD.h"

//#import "SGTip.h"
#define MARGIN 10
#define COL 4
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface SGShowCell : UICollectionViewCell
@property (nonatomic,weak) UIButton *selectedButton;
@end

@implementation SGShowCell

@end

@interface SGCollectionController ()
@property (nonatomic,strong) NSMutableArray *assetModels;
//选中的模型
@property (nonatomic,strong) NSMutableArray *selectedModels;
//选中的图片
@property (nonatomic,strong) NSMutableArray *selectedImages;
@property (nonatomic,strong) NSMutableArray *selectedURL;
@end

@implementation SGCollectionController

static NSString * const reuseIdentifier = @"Cell";
//设置类型
- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = MARGIN;
    flowLayout.minimumInteritemSpacing = MARGIN;
    CGFloat cellHeight = (kWidth - (COL + 1) * MARGIN) / COL;
    flowLayout.itemSize = CGSizeMake(cellHeight, cellHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [super initWithCollectionViewLayout:flowLayout];
}
- (NSMutableArray *)assetModels{
    if (_assetModels == nil) {
        _assetModels = [NSMutableArray array];
    }
    return _assetModels;
}
- (NSMutableArray *)selectedImages{
    if (_selectedImages == nil) {
        _selectedImages = [NSMutableArray array];
    }
    return _selectedImages;
}
- (NSMutableArray *)selectedURL{
    if (_selectedURL == nil) {
        _selectedURL = [NSMutableArray array];
    }
    return _selectedURL;
}
- (NSMutableArray *)selectedModels{
    if (_selectedModels == nil) {
        _selectedModels = [NSMutableArray array];
    }
    return _selectedModels;
}
- (void)setGroup:(ALAssetsGroup *)group{
    _group = group;
    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset == nil) return ;
        if (![[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {//不是图片
            return;
        }
        SGAssetModel *model = [[SGAssetModel alloc] init];
        model.thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
        model.imageURL = asset.defaultRepresentation.url;
        if ([_phoneAry containsObject: model.imageURL]) {
            model.isSelected=YES;
        }

        [self.assetModels addObject:model];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[SGShowCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:IMG(@"icon_navigation_return") style:UIBarButtonItemStylePlain target:self action:@selector(backitemClick)];
    
    
    //右侧完成按钮
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelecting)];
    self.navigationItem.rightBarButtonItem = finish;
    
}
-(void)backitemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//出口,选择完成图片
- (void)finishSelecting{
    
    if ([self.navigationController isKindOfClass:[SGImagePickerController class]]) {
        SGImagePickerController *picker = (SGImagePickerController *)self.navigationController;
        if (picker.didFinishSelectThumbnails || picker.didFinishSelectImages) {
        
        for (SGAssetModel *model in self.assetModels) {
            if (model.isSelected) {
                [self.selectedModels addObject:model];
            }
        }
 
            //获取原始图片可能是异步的,因此需要判断最后一个,然后传出
            for (int i = 0; i < self.selectedModels.count; i++) {
                SGAssetModel *model = self.selectedModels[i];
                [self.selectedURL addObject:model.imageURL];
                [model originalImage:^(UIImage *image) {
                    [self.selectedImages addObject:image];
                    
                    if ( i == self.selectedModels.count - 1) {//最后一个
                        if (picker.didFinishSelectImages) {
                            picker.didFinishSelectImages(self.selectedImages,self.selectedURL);
                        }
                        
                    }
                }];
            }
        
        if (picker.didFinishSelectThumbnails) {
            picker.didFinishSelectThumbnails([_selectedModels valueForKeyPath:@"thumbnail"]);
        }
        
        }
    }
    
    //移除
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.assetModels.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SGShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    SGAssetModel *model = self.assetModels[indexPath.item];
   
    if (cell.backgroundView == nil) {//防止多次创建
        UIImageView *imageView = [[UIImageView alloc] init];
        cell.backgroundView = imageView;
    }
    UIImageView *backView = (UIImageView *)cell.backgroundView;
    backView.image = model.thumbnail;
    if (cell.selectedButton == nil) {//防止多次创建
        UIButton *selectButton = [[UIButton alloc] init];
        [selectButton setImage:[UIImage imageNamed:@"imageselecte_normal"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"imageselecte_selected"] forState:UIControlStateSelected];
        CGFloat width = cell.bounds.size.width;
        selectButton.frame = CGRectMake(width - 20, 0, 20, 20);
        [cell.contentView addSubview:selectButton];
        cell.selectedButton = selectButton;
        [selectButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.selectedButton.tag = indexPath.item;//重新绑定
    cell.selectedButton.selected = model.isSelected;//恢复设定状态
    return cell;
}
- (void)buttonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    SGAssetModel *model = self.assetModels[sender.tag];
    //因为冲用的问题,不能根据选中状态来记录
    if (sender.selected == YES) {//选中了记录
        if (self.maxCount <= 0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.detailsLabelText = @"超出最大数目";
            hud.detailsLabelFont = [UIFont systemFontOfSize:14];
          
            // 再设置模式
            hud.mode = MBProgressHUDModeCustomView;
            
            // 隐藏时候从父控件中移除
            hud.removeFromSuperViewOnHide = YES;
            
            // 1秒之后再消失
            [hud hide:YES afterDelay:1.2];

            sender.selected = NO;
        }else{
         model.isSelected = YES;
            self.maxCount--;
        }
    }else{//否则移除记录
        model.isSelected = NO;
        self.maxCount++;
    }
}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    SGPhotoBrowser *browser = [[SGPhotoBrowser alloc] init];
//    browser.assetModels = self.assetModels;
//    browser.currentIndex = indexPath.item;
//    [browser show];
    
    SGShowCell *cell =(SGShowCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self buttonClicked:cell.selectedButton];
}

@end
