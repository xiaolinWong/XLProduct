//
//  XLPickerView.m
//  XLProduct
//
//  Created by 王小林 on 2018/3/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "XLPickerView.h"
#define PMToobarHeight 44
@interface XLPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIToolbar       *_toolbar;
    NSDictionary    *_dataDic;
    
    NSDate          *_defaulDate;
    
    BOOL            _isHaveNavControler;
    NSInteger       _pickerViewHeight;
    
    NSDictionary    *_resultData;//时间返回的
    NSString * _resultString;
}

@property (nonatomic, strong) UIView *mbView;//蒙板

@property(nonatomic,strong)NSArray *plistArray;


@property (nonatomic, strong) NSDictionary *plistDic;

@property (nonatomic, strong) NSMutableDictionary *resultDic2;

@property(nonatomic,assign)BOOL isMoreChoise;


@end
@implementation XLPickerView

@synthesize pickerView = _pickerView;

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mbView];
        [self setUpToolBar];
        
    }
    return self;
}

//加载单数组
-(instancetype)initPickViewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler; {
    self = [super init];
    if (self) {
        [self setUpPickView];
        _plistArray=array;
        [self setFrameWith:isHaveNavControler];
        [self setToolbarWithPickViewFrame];
    }
    return self;
}

//加载多数组
-(instancetype)initPickViewWithDicArr:(NSDictionary *)dic isHaveNavControler:(BOOL)isHaveNavControler{
    self = [super init];
    if (self) {
        [self setUpPickView];
        _plistDic =dic;
        _isMoreChoise=YES;
        
        [self setFrameWith:isHaveNavControler];
        [self setToolbarWithPickViewFrame];
    }
    return self;
}
//时间选择器
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler{
    
    self=[super init];
    if (self) {
        _defaulDate=defaulDate;
        [self setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode];
        [self setFrameWith:isHaveNavControler];
        [self setToolbarWithPickViewFrame];
    }
    return self;
}


#pragma mark - Layout

-(void)setFrameWith:(BOOL)isHaveNavControler{
    //    CGFloat toolViewX = 0;
//    CGFloat toolViewH = _pickerViewHeight + PMToobarHeight;
//    CGFloat toolViewY ;
//    if (_isHaveNavControler) {
//        toolViewY= SCREEN_HEIGHT-toolViewH - 50;
//    }else {
//        toolViewY= SCREEN_HEIGHT-toolViewH;
//    }
    CGFloat toolViewW = [UIScreen mainScreen].bounds.size.width;
    self.frame = CGRectMake(0, 0, toolViewW, SCREEN_HEIGHT);
}

-(void)setUpPickView
{
    UIPickerView *pickView = [[UIPickerView alloc] init];
    pickView.backgroundColor = [UIColor lightGrayColor];
    _pickerView = pickView;
    pickView.delegate = self;
    pickView.dataSource = self;
    pickView.backgroundColor = UIColorFromRGB(0xebeef0);
    pickView.frame = CGRectMake(0,SCREEN_HEIGHT-pickView.frame.size.height, SCREEN_WIDTH, pickView.frame.size.height);
    _pickerViewHeight = pickView.frame.size.height;
    [self addSubview:pickView];
}


-(void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor = UIColorFromRGB(0xebeef0);
    
    if (_defaulDate) {
        [datePicker setDate:_defaulDate];
    }
    _datePicker = datePicker;
    datePicker.frame = CGRectMake(0,SCREEN_HEIGHT-datePicker.frame.size.height, SCREEN_WIDTH, datePicker.frame.size.height);
    _pickerViewHeight = datePicker.frame.size.height;
    [self addSubview:datePicker];
}

-(void)setUpToolBar {
    
    _toolbar = [self setToolbarStyle];
    
    [self addSubview:_toolbar];
}

-(UIToolbar *)setToolbarStyle {
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.backgroundColor=UIColorFromRGB(0xffffff);
    UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithTitle:@"    取消" style:UIBarButtonItemStyleDone target:self action:@selector(remove)];
    [lefttem setTitleTextAttributes:@{NSForegroundColorAttributeName:kHCNavBarColor,NSFontAttributeName:BOLDSYSTEMFONT(16.0)} forState:UIControlStateNormal];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定    " style:UIBarButtonItemStyleDone target:self action:@selector(doneClick)];
    [right setTitleTextAttributes:@{NSForegroundColorAttributeName:kHCNavBarColor,NSFontAttributeName:BOLDSYSTEMFONT(16.0)} forState:UIControlStateNormal];
    toolbar.items = @[lefttem,centerSpace,right];
    
    return toolbar;
}
-(UIView *)mbView{
    if (!_mbView) {
        _mbView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mbView.backgroundColor=[UIColor blackColor];
        _mbView.alpha=0.4;
    }
    return _mbView;
}
-(void)setToolbarWithPickViewFrame{
    _toolbar.frame = CGRectMake(0,SCREEN_HEIGHT-_pickerViewHeight-PMToobarHeight ,SCREEN_WIDTH, PMToobarHeight);
}


#pragma mark piackView 数据源方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    if (_isMoreChoise) {
        NSArray *keys = [_plistDic allKeys];
        return keys.count;
    }
    if (IsEmpty(self.plistArray)) {
        NSArray *keys = [_dataDic allKeys];
        return keys.count;
    }else{
        return 1;
    }
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_isMoreChoise) {
        NSArray *keys = [_plistDic allKeys];
        NSString *key = keys[component];
        NSArray *list = _plistDic[key];
        return list.count;
    }
    if (IsEmpty(self.plistArray)) {
        NSArray *keys = [_dataDic allKeys];
        NSString *key = keys[component];
        NSArray *list = _dataDic[key];
        return list.count;
    }else{
        return self.plistArray.count;
    }
    
}

#pragma mark UIPickerViewdelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (_isMoreChoise) {
        NSArray *keys = [_plistDic allKeys];
        NSString *key = keys[component];
        NSArray *list = _plistDic[key];
        NSString *rowTitle=list[row];
        return rowTitle;
    }
    NSString *rowTitle=_plistArray[row];
    
    return rowTitle;
}
-(NSMutableDictionary *)resultDic2{
    if (!_resultDic2) {
        _resultDic2=[[NSMutableDictionary alloc]init];
        
    }
    return _resultDic2;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_isMoreChoise) {
        NSArray *keys = [_plistDic allKeys];
        NSString *key = keys[component];
        NSArray *list = _plistDic[key];
        NSString *rowTitle=list[row];
        
        [self.resultDic2 setObject:rowTitle forKey:key];
    }else{
        _resultString=_plistArray[row];
    }
}


#pragma mark - Action

-(void)remove{
    
    [self removeFromSuperview];
}
-(void)show{
    
    [WINDOW addSubview:self];
    
}
//确定选择点击
-(void)doneClick
{
    if (_datePicker) {
        //判断是不是时间选择器
        if (_datePicker) {
            _resultData = @{@"date":_datePicker.date};
            NSLog(@"%@",_datePicker.date);
        }
        if ([self.delegate respondsToSelector:@selector(doneBtnClickBackDic:result:withOtherTag:)]) {
            [self.delegate doneBtnClickBackDic:self result:_resultData withOtherTag:self.otherTag];
        }
        
    }else if(_isMoreChoise){
        //判断是不是多选
        for (int ii =0; ii<_plistDic.count; ii++) {
            NSArray *keys = [_plistDic allKeys];
            NSString *key = keys[ii];
            if (IsEmpty(self.resultDic2[key])) {
                NSArray *list = _plistDic[key];
                NSString *rowTitle=list[0];
                [self.resultDic2 setObject: rowTitle forKey:key];
            }
            
        }
        if ([self.delegate respondsToSelector:@selector(doneBtnClickBackDic:result:withOtherTag:)]) {
            [self.delegate doneBtnClickBackDic:self result:self.resultDic2 withOtherTag:self.otherTag];
        }
    }else{
        //单项选择 返回字符串
        if (IsEmpty(_resultString)) {
            _resultString=_plistArray[0];
        }
        if ([self.delegate respondsToSelector:@selector(doneBtnClickBackStr:result:withOtherTag:)]) {
            [self.delegate doneBtnClickBackStr:self result:_resultString withOtherTag:self.otherTag];
        }
    }
    
    [self removeFromSuperview];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self remove];
}
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color {
    _pickerView.backgroundColor=color;
}
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color {
    
    _toolbar.tintColor=color;
}
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color {
    
    _toolbar.barTintColor=color;
}

@end

