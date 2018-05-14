//
//  XLUpDataTableViewCell.m
//  XLProduct
//
//  Created by Mac on 2018/1/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "XLUpDataTableViewCell.h"
#import "XLPickerView.h"
#import "UIButton+WebCache.h"
@interface XLUpDataTableViewCell()<XLPickerViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIButton *headBtn;
@property (nonatomic, strong) UILabel *tishiLB;
@property (nonatomic, strong) UITextField *nickNameTF;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *yearChoiseBtn;

@end
@implementation XLUpDataTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndex:(NSIndexPath *)indexP
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutView:indexP];
    }
    return self;
}

-(void)layoutView:(NSIndexPath *)indexP{
    switch (indexP.row) {
        case 0:
            [self.contentView addSubview:self.bgImage];
            [self.contentView addSubview:self.headBtn];
            [self.contentView addSubview:self.tishiLB];
        self.bgImage.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).topEqualToView(self.contentView).heightIs(120);
            self.headBtn.sd_layout.topSpaceToView(self.contentView, 55).centerXIs(SCREEN_WIDTH/2).widthIs(80).heightEqualToWidth();
            self.tishiLB.sd_layout.bottomSpaceToView(self.contentView, 20).heightIs(30).widthIs(300).centerXIs(SCREEN_WIDTH/2);
            
            break;
        case 1:
            [self.contentView addSubview:self.nickNameTF];
            
            self.nickNameTF.sd_layout.topSpaceToView(self.contentView, 25).heightIs(30).centerXIs(SCREEN_WIDTH/2).widthIs(200);
            break;
        case 2:

            [self.contentView addSubview:self.leftBtn];
            [self.contentView addSubview:self.rightBtn];
            [self.leftBtn setImage:IMG(@"icon_login_man") forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"男" forState:UIControlStateNormal];
            [self.rightBtn setImage:IMG(@"icon_login_woman") forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"女" forState:UIControlStateNormal];
            
            
            self.leftBtn.sd_layout.topSpaceToView(self.contentView, 25).heightIs(30).centerXIs(SCREEN_WIDTH/2-35).widthIs(60);
            self.rightBtn.sd_layout.topSpaceToView(self.contentView, 25).heightIs(30).centerXIs(SCREEN_WIDTH/2+35).widthIs(60);
            
            break;
        case 3:

            [self.contentView addSubview:self.leftBtn];
            [self.contentView addSubview:self.rightBtn];
            [self.leftBtn setImage:IMG(@"") forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"在校学生" forState:UIControlStateNormal];
            [self.rightBtn setImage:IMG(@"") forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"社会人士" forState:UIControlStateNormal];
            
            
            self.leftBtn.sd_layout.topSpaceToView(self.contentView, 25).heightIs(30).centerXIs(SCREEN_WIDTH/2-50).widthIs(90);
            self.rightBtn.sd_layout.topSpaceToView(self.contentView, 25).heightIs(30).centerXIs(SCREEN_WIDTH/2+50).widthIs(90);
            
            
            break;
        case 4:

            [self.contentView addSubview:self.yearChoiseBtn];
            
            self.yearChoiseBtn.sd_layout.topSpaceToView(self.contentView, 25).heightIs(30).centerXIs(SCREEN_WIDTH/2).widthIs(200);
            break;
        default:
            break;
    }
}
#pragma mark  XLPickerViewDelegate

-(void)doneBtnClickBackDic:(XLPickerView *)pickView result:(NSDictionary *)result withOtherTag:(id)tag{
    
    NSDate *date=result[@"date"];
    [self.yearChoiseBtn setTitle:[Utils getDateStringWithDate:date format:@"YYYY-MM-dd"] forState:UIControlStateNormal];
    if (self.datePickClcik) {
        self.datePickClcik([Utils getDateStringWithDate:date format:@"YYYY-MM-dd"]);
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
  
    if (self.nameClcik  ) {
        self.nameClcik(textField.text);
    }
    
}
#pragma mark  btn点击

-(void)headBtnClcik{
    if (self.headImageClcik) {
        self.headImageClcik(self.headBtn);
    }
}
-(void)leftBtnClick:(UIButton *)btn{
    
    ViewBorderRadius(btn,15 , 1,kHCNavBarColor);
    [btn setTitleColor:kHCNavBarColor forState:UIControlStateNormal];
    
    ViewBorderRadius(self.rightBtn,15 , 1,kXLConeColorl);
    [self.rightBtn setTitleColor:kXLBlackColorl forState:UIControlStateNormal];
    
    if (self.leftBtnClcik) {
        self.leftBtnClcik(btn);
    }
}
-(void)rightBtnClick:(UIButton *)btn{
    
    ViewBorderRadius(btn,15 , 1,kHCNavBarColor);
    [btn setTitleColor:kHCNavBarColor forState:UIControlStateNormal];
    
    ViewBorderRadius(self.leftBtn,15 , 1,kXLConeColorl);
    [self.leftBtn setTitleColor:kXLBlackColorl forState:UIControlStateNormal];
    if (self.rightBtnClcik) {
        self.rightBtnClcik(btn);
    }
}
-(void)yearChooseClcik{

    XLPickerView *dateView=[[XLPickerView alloc]initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
    dateView.delegate=self;
    [dateView show];
}

-(UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage=[[UIImageView alloc]initWithImage:IMG(@"icon_login_background")];
    }
    return _bgImage;
}
-(UIButton *)headBtn{
    if (!_headBtn) {
        _headBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame=CGRectMake(0, 0, 80, 80);
        _headBtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
//        if ( [HCAccountMgr manager].loginInfo.avatar ) {
//            [_headBtn sd_setImageWithURL:[NSURL URLWithString:[HCAccountMgr manager].loginInfo.avatar] forState:UIControlStateNormal];
//        }else{
//            [_headBtn setImage:IMG(@"icon_add_photo") forState:UIControlStateNormal];
//        }
        _headBtn.clipsToBounds=YES;
        _headBtn.backgroundColor=kXLWhiteColor;
        [_headBtn addTarget:self action:@selector(headBtnClcik) forControlEvents:UIControlEventTouchUpInside];
        ViewShadowRadius(_headBtn, 40,0, 0, kXLConeColorl, 0.5, 5)
    }
    return _headBtn;
}
-(UILabel *)tishiLB{
    if (!_tishiLB) {
        _tishiLB=[[UILabel alloc]init];
        _tishiLB.textColor=kHCNavBarColor;
        _tishiLB.font=SYSTEMFONT(15);
        _tishiLB.text=@"头像,一个好工作的开始";
        _tishiLB.textAlignment=NSTextAlignmentCenter;
    }
    return _tishiLB;
}
-(UITextField *)nickNameTF{
    if (!_nickNameTF) {
        _nickNameTF=[[UITextField alloc]init];
        _nickNameTF.placeholder=@"请输入姓名";
        _nickNameTF.textAlignment=NSTextAlignmentCenter;
        _nickNameTF.delegate=self;
    }
    return _nickNameTF;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame=CGRectMake(0, 0, 80, 30);
        _leftBtn.backgroundColor=kXLWhiteColor;
        [_leftBtn setTitleColor:kXLBlackColorl forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        ViewBorderRadius(_leftBtn,15 , 1,kXLConeColorl);
    }
    return _leftBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame=CGRectMake(0, 0, 80, 30);
        _rightBtn.backgroundColor=kXLWhiteColor;
        [_rightBtn setTitleColor:kXLBlackColorl forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        ViewBorderRadius(_rightBtn,15 , 1,kXLConeColorl);
    }
    return _rightBtn;
}
-(UIButton *)yearChoiseBtn{
    if (!_yearChoiseBtn) {
        _yearChoiseBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _yearChoiseBtn.frame=CGRectMake(0, 0, 80, 30);
        [_yearChoiseBtn setTitle:@"出生日期" forState:UIControlStateNormal];
        [_yearChoiseBtn setTitleColor:kXLBlackColorl forState:UIControlStateNormal];
        [_yearChoiseBtn addTarget:self action:@selector(yearChooseClcik) forControlEvents:UIControlEventTouchUpInside];
        _yearChoiseBtn.backgroundColor=kXLWhiteColor;
    }
    return _yearChoiseBtn;
}
@end
