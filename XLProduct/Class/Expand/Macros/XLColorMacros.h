//
//  XLColorMacros.h
//  XLProduct
//
//  Created by Mac on 2018/1/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#ifndef XLColorMacros_h
#define XLColorMacros_h
/* ********************颜色类********************* */

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define OrangeColor RGB(243,128,1)
#define LightGraryColor RGB(153,153,153)
#define DarkGrayColor RGB(51,51,51)

//导航栏颜色
#define kHCNavBarColor UIColorFromRGB(0xcc2c2c)

//导航栏颜色2
#define kXLNavBarColor UIColorFromRGB(0xeeeeee)

//背景色
#define kHCBackgroundColor UIColorFromRGB(0xf5f8fa)
//深灰色
#define XL60Colorl  UIColorFromRGB(0xb8b8b8)
//黑色
#define XLBlackColor  UIColorFromRGB(0x323232)
//灰色
#define XL99Colorl UIColorFromRGB(0x757575)
//背景灰
#define XLBG_GrayColorl UIColorFromRGB(0xf5f5f5)
//链接颜色
#define XLLJColorl UIColorFromRGB(0x54c2f6)
//深分割线
#define XLSFGColorl UIColorFromRGB(0xd7dadb)

//浅分割线
#define XLQFGColorl UIColorFromRGB(0xefefef)

//辅助橙
#define XLQrangeColorl UIColorFromRGB(0xf27200)

#define PlaceholderImage IMG(@"placeload")
#define PlaceholderBigImage IMG(@"placeload_2")

#define LoadNoData IMG(@"no")

#define DefaultFontSize [UIFont systemFontOfSize:17]

/* ********************颜色类********************* */

/* ********************图片********************* */

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//获取Image
#define IMG(NAME) [UIImage imageNamed:(NAME)]
#define OrigIMG(a) [IMG(a) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

//建议使用前两种宏定义,性能高于后者
/* ********************图片********************* */

//----------------------其他设置----------------------------

#define HCTabelHeadView(h) [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)]

//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
//#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]



#endif /* XLColorMacros_h */
