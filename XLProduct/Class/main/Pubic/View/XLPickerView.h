//
//  XLPickerView.h
//  XLProduct
//
//  Created by 王小林 on 2018/3/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLPickerView;
@protocol XLPickerViewDelegate <NSObject>

@optional
//时间选择器返回 @{@"date":str}  多选 @{@"":@""}
- (void)doneBtnClickBackDic:(XLPickerView *)pickView result:(NSDictionary *)result withOtherTag:(id)tag;

//单选返回  result
- (void)doneBtnClickBackStr:(XLPickerView *)pickView result:(NSString *)result withOtherTag:(id)tag;


@end
@interface XLPickerView : UIView
{
    
}
@property(nonatomic,weak) id<XLPickerViewDelegate> delegate;

@property(nonatomic, strong) UIPickerView   *pickerView;
@property(nonatomic, strong) UIDatePicker   *datePicker;

//是否需要传递其他参数
@property (nonatomic, strong) id otherTag;

/**
 *  通过plistName添加一个pickView
 *
 *  @param array              需要显示的数组
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickViewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *  通过dic添加一个pickView
 *
 *  @param dic              需要显示的字典
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickViewWithDicArr:(NSDictionary *)dic isHaveNavControler:(BOOL)isHaveNavControler;
/**
 *  通过时间创建一个DatePicker
 *
 *  @param  defaulDate               默认选中时间
 *  @param  isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的datePicker
 */
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *   移除本控件
 */
-(void)remove;
/**
 *  显示本控件
 */
-(void)show;
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color;
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color;
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color;


@end
