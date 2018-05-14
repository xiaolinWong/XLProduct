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

/*****APP颜色******/
//导航栏颜色
#define kHCNavBarColor UIColorFromRGB(0x659Aff)
//背景色
#define kHCBackgroundColor UIColorFromRGB(0xfbfbfb)
//失效按钮颜色 浅灰
#define kXLDisAbleColor UIColorFromRGB(0xe5e5e5)
//特殊 阴影   浅蓝
#define kXLShadowBuleColor UIColorFromRGB(0x95b8fe)
//特殊或者警告红色
#define kXLWaningColor  UIColorFromRGB(0xff3157)
//特殊红 阴影
#define kXLShadowRedColor UIColorFromRGB(0xf4a0a9)
//透明色
#define CLEARCOLOR [UIColor clearColor]

/*****字体颜色******/
//纯白色
#define kXLWhiteColor [UIColor whiteColor]
//浅灰_辅助 白色 阴影
#define kXLConeColorl  UIColorFromRGB(0xc1c1c1)
//浅灰_失效 提示
#define kXL95Color  UIColorFromRGB(0x959595)
//深黑 默认状态文字
#define kXLBlackColorl UIColorFromRGB(0x6a6a6a)
//黑色 标题
#define kXLTitleBlackColorl UIColorFromRGB(0x282828)

//占位图
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

// View 圆角加阴影
#define ViewShadowRadius(View, Radius, X, Y, Color, Opacity,sRadius)\
\
View.layer.cornerRadius=Radius;\
View.layer.shadowColor=[Color CGColor];\
View.layer.shadowOffset=CGSizeMake(X, Y);\
View.layer.shadowOpacity=Opacity;\
View.layer.shadowRadius=sRadius;

//view 阴影
#define ViewShadow(View, X, Y, Color, Opacity,sRadius)\
\
View.layer.shadowColor=[Color CGColor];\
View.layer.shadowOffset=CGSizeMake(X, Y);\
View.layer.shadowOpacity=Opacity;\
View.layer.shadowRadius=sRadius;


#endif /* XLColorMacros_h */
