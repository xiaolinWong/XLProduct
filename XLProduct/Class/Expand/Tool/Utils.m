//
//  Utils.m
//  PMedical
//
//  Created by Vincent on 15-1-13.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import "Utils.h"
#import "NSString+MD5.h"
#import <sys/sysctl.h>
#import "sys/utsname.h"
#import <CoreText/CoreText.h>
//#import "CYWebViewController.h"
@implementation Utils


#pragma mark - 网络请求基本 字段

+ (NSString *)systemModel {
    /*
     size_t size;
     sysctlbyname("hw.machine", NULL, &size, NULL, 0);
     char *machine = malloc(size);
     sysctlbyname("hw.machine", machine, &size, NULL, 0);
     NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
     free(machine);
     return platform;
     */
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSArray *modelArray = @[
                            @"i386", @"x86_64",
                            
                            @"iPhone1,1",
                            @"iPhone1,2",
                            @"iPhone2,1",
                            @"iPhone3,1",
                            @"iPhone3,2",
                            @"iPhone3,3",
                            @"iPhone4,1",
                            @"iPhone5,1",
                            @"iPhone5,2",
                            @"iPhone5,3",
                            @"iPhone5,4",
                            @"iPhone6,1",
                            @"iPhone6,2",
                            @"iPhone7,1",
                            @"iPhone7,2",
                            @"iPhone8,1",
                            @"iPhone8,2",
                            
                            @"iPod1,1",
                            @"iPod2,1",
                            @"iPod3,1",
                            @"iPod4,1",
                            @"iPod5,1",
                            
                            @"iPad1,1",
                            @"iPad2,1",
                            @"iPad2,2",
                            @"iPad2,3",
                            @"iPad2,4",
                            @"iPad3,1",
                            @"iPad3,2",
                            @"iPad3,3",
                            @"iPad3,4",
                            @"iPad3,5",
                            @"iPad3,6",
                            
                            @"iPad2,5",
                            @"iPad2,6",
                            @"iPad2,7",
                            ];
    NSArray *modelNameArray = @[
                                
                                @"iPhone Simulator", @"iPhone Simulator",
                                
                                @"iPhone 2G",
                                @"iPhone 3G",
                                @"iPhone 3GS",
                                @"iPhone 4(GSM)",
                                @"iPhone 4(GSM Rev A)",
                                @"iPhone 4(CDMA)",
                                @"iPhone 4S",
                                @"iPhone 5(GSM)",
                                @"iPhone 5(GSM+CDMA)",
                                @"iPhone 5c(GSM)",
                                @"iPhone 5c(Global)",
                                @"iphone 5s(GSM)",
                                @"iphone 5s(Global)",
                                @"iPhone 6 plus",
                                @"iPhone 6",
                                @"iPhone 6s",
                                @"iPhone 6s plus",
                                
                                @"iPod Touch 1G",
                                @"iPod Touch 2G",
                                @"iPod Touch 3G",
                                @"iPod Touch 4G",
                                @"iPod Touch 5G",
                                
                                @"iPad",
                                @"iPad 2(WiFi)",
                                @"iPad 2(GSM)",
                                @"iPad 2(CDMA)",
                                @"iPad 2(WiFi + New Chip)",
                                @"iPad 3(WiFi)",
                                @"iPad 3(GSM+CDMA)",
                                @"iPad 3(GSM)",
                                @"iPad 4(WiFi)",
                                @"iPad 4(GSM)",
                                @"iPad 4(GSM+CDMA)",
                                
                                @"iPad mini (WiFi)",
                                @"iPad mini (GSM)",
                                @"ipad mini (GSM+CDMA)"
                                ];
    NSInteger modelIndex = - 1;
    NSString *modelNameString = nil;
    modelIndex = [modelArray indexOfObject:deviceString];
    if (modelIndex >= 0 && modelIndex < [modelNameArray count]) {
        modelNameString = [modelNameArray objectAtIndex:modelIndex];
    }
    if (modelNameString.length < 1) {
        modelNameString = @"unknow";
    }
    
    return modelNameString;
}

+ (NSString *)networkingStates {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"9";
    
    switch (type) {
        case 0:
        //stateString = @"notReachable";
        stateString = @"9";
        break;
        
        case 1:
        //stateString = @"2G";
        stateString = @"1";
        break;
        
        case 2:
        //stateString = @"3G";
        stateString = @"2";
        
        break;
        
        case 3:
        //stateString = @"4G";
        stateString = @"3";
        break;
        
        case 4:
        //stateString = @"LTE";
        stateString = @"9";
        break;
        
        case 5:
        //stateString = @"wifi";
        stateString = @"4";
        break;
        
        default:
        break;
    }
    
    return stateString;
}

//获取设备版本号
+ (NSString *)getDeviceVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

//获取设备号
+ (NSString *)getDeviceID
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

//获取app版本号
+ (NSString *)getClientVersion
{
    return ([[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]);
}

#pragma mark - 判断 身份证号
+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger )value1 Value2:(NSInteger )value2;
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */

+ (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */
+ (BOOL)chk18PaperId:(NSString *) sPaperId
{
    //判断位数
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        return NO;
    }
    NSString *carid = sPaperId;
    
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    
    if ([sPaperId length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![Utils areaCode:sProvince]) {
        
        return NO;
    }
    //判断年月日是否有效
    //年份
    int strYear = [[Utils getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[Utils getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[Utils getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

//通过身份证获取生日
+ (NSString *)getBirthdayBy18PaperId:(NSString *) sPaperId
{
    if ([Utils chk18PaperId:sPaperId]) {
        
        NSString *carid = sPaperId;
        //加权因子
        int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
        //校验码
        unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
        //将15位身份证号转换成18位
        NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
        
        if ([sPaperId length] == 15) {
            
            [mString insertString:@"19" atIndex:6];
            long p = 0;
            const char *pid = [mString UTF8String];
            for (int i=0; i<=16; i++)
            {
                p += (pid[i]-48) * R[i];
            }
            int o = p%11;
            NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
            [mString insertString:string_content atIndex:[mString length]];
            carid = mString;
        }
        //年份
        int strYear = [[Utils getStringWithRange:carid Value1:6 Value2:4] intValue];
        //月份
        int strMonth = [[Utils getStringWithRange:carid Value1:10 Value2:2] intValue];
        //日
        int strDay = [[Utils getStringWithRange:carid Value1:12 Value2:2] intValue];
        
        return [NSString stringWithFormat:@"%04d-%02d-%02d",strYear,strMonth,strDay];
    }
    
    return nil;
}

//根据某个日期计算年龄
+ (NSString *)yearOldFormDate:(double)serverStemp {
    
    double stemp = serverStemp / 1000;
    NSDate *servDate = [NSDate dateWithTimeIntervalSince1970:stemp];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth
                                                fromDate:servDate
                                                  toDate:[NSDate date]
                                                 options:NSCalendarWrapComponents];
    
    return [NSString stringWithFormat:@"%ld岁",(long)(components.year+1)];
}

/**
 *  通过身份证号获取年龄
 *
 *  @param idcard 身份证号
 *
 *  @return 周岁
 */
+ (NSInteger)getYearWithIdcard:(NSString *)idcard
{
    NSString *birth = [Utils getBirthdayBy18PaperId:idcard];
    if (!birth) return 0;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthday = [dateFormatter dateFromString:birth];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth
                                                fromDate:birthday
                                                  toDate:[NSDate date]
                                                 options:NSCalendarWrapComponents];
    return components.year;
}
+ (NSInteger)getYearWithDob:(NSString *)dobStr
{
    NSString *dob = [self formatterWithServer:dobStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthday = [dateFormatter dateFromString:dob];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth
                                                fromDate:birthday
                                                  toDate:[NSDate date]
                                                 options:NSCalendarWrapComponents];
    return components.year;
}
+ (NSNumber *)getSexFromIdcard:(NSString *) sPaperId
{
    if (sPaperId.length < 16) return nil;
    NSUInteger lenght = sPaperId.length;
    NSString *sex = [sPaperId substringWithRange:NSMakeRange(lenght-2,1)];
    
    if ([sex intValue] % 2 == 1) {
        return @1;
    }
    return @2;
}

//验证手机号码
+ (BOOL)checkPhoneNum:(NSString *)phoneNum {
    NSString *regex = @"^[1][3-9]\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    return isMatch;
}
////验证是否是手机号
//#pragma mark - phone
//+ (NSMutableArray *)runsPhoneWithAttString:(NSMutableAttributedString *)attString  {
//    
//    NSMutableArray *arr=[[NSMutableArray alloc]init];
//    NSString *textStr=@"(联系时请说明是在劳务圈看到的。)";
//    NSMutableString * attStr = attString.mutableString;
//    NSError *error = nil;
//    NSString *regulaStr = @"1+[358]+\\d{9}";
//    
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
//                                                                           options:NSRegularExpressionCaseInsensitive
//                                                                             error:&error];
//    if (error == nil)
//    {
//        NSArray *arrayOfAllMatches = [regex matchesInString:attStr
//                                                    options:0
//                                                      range:NSMakeRange(0, [attStr length])];
//        
//        
//        for (int ii=0; ii<arrayOfAllMatches.count; ii++) {
//            NSTextCheckingResult *match =arrayOfAllMatches[ii];
//            NSRange matchRange = match.range;
//            matchRange.location=matchRange.location+17*ii;
//            NSString * phoneStr = [attStr substringWithRange:matchRange];
//            [attStr insertString:textStr atIndex:matchRange.location+matchRange.length];
//            //          NSValue * valueRange = [NSValue valueWithRange:matchRange];
//            [attString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xff3366) range:matchRange];
//            [attString addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleSingle] range:matchRange];
//            
//            [arr addObject:phoneStr];
//
//        }

//        for (NSTextCheckingResult *match in arrayOfAllMatches){
//            NSRange matchRange = match.range;
//            
//           NSString * phoneStr = [attStr substringWithRange:matchRange];
//            [attStr insertString:textStr atIndex:matchRange.location+matchRange.length];
//            //          NSValue * valueRange = [NSValue valueWithRange:matchRange];
//            [attString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xff3366) range:matchRange];
//            [attString addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleSingle] range:matchRange];
//            
//            [arr addObject:phoneStr];
//        }
//    }
//    
//    return arr;
//}
+ (NSString *)formatterWithServer:(NSString *)birthdayStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *birthdayDate = [dateFormatter dateFromString:birthdayStr];
    
//    if (!birthdayDate) {
//        return birthdayStr;
//    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/yyyy/MM"];
    NSString *dobStr = [dateFormat stringFromDate:birthdayDate];
    return dobStr;
}

+ (NSString *)formatterWithTimeData:(NSString *)time
{
//    NSTimeInterval times=[time doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval times=[time doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:times];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//验证密码 6-20位数字和字母组成
+ (BOOL)checkPassWord:(NSString *)pwd
{
    NSInteger count = 0;
    NSInteger theii = 0;
    for (NSInteger i = 0; i<pwd.length; i++) {//123456
        NSString *theStr = [pwd substringWithRange:NSMakeRange(i, 1)];
        NSInteger ii = [theStr integerValue];
        if (ii == theii) {
            count++;
        }
        theii = ii;
        theii++;
    }
    
    if (count == pwd.length-1) {
        return NO;
    }
    
    count = 0;
    theii = 0;
    for (NSInteger i = pwd.length ;i>0; i--) {//654321
        NSString *theStr = [pwd substringWithRange:NSMakeRange(pwd.length - i, 1)];
        NSInteger ii = [theStr integerValue];
        if (ii == theii) {
            count++;
        }
        theii = ii;
        theii--;
    }
    if (count == pwd.length-1) {
        return NO;
    }
    return YES;
}

#pragma mark - 实用工具

//width范围内 文本的长度
//extern float fmaxf(float, float);
+ (CGFloat)detailTextHeight:(NSString *)text width:(CGFloat)width font:(CGFloat)font{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    //CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:@(NSLineBreakByCharWrapping)} context:nil];
    return rectToFit.size.height;
}
+ (CGFloat)detailTextwidth:(NSString *)text hegiht:(CGFloat)hegiht font:(CGFloat)font{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, hegiht) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return rectToFit.size.width;
}
+ (CGFloat)detailTextHeight:(NSString *)text lineSpage:(CGFloat)space width:(CGFloat)width font:(CGFloat)font{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = space;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    //CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:@(NSLineBreakByCharWrapping)} context:nil];
    return rectToFit.size.height;
}

//颜色转换图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+(UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字符串
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSString *)stringWithObject:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] != 0 && error == nil) {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return @"";
}


// 得到中间显示200为橘色的文字
+ (NSMutableAttributedString *)changeStringColorWithStart:(NSString *)start colorString:(NSString *)colorStr end:(NSString *)end withColor:(UIColor *)color withFont:(UIFont *)font
{
    NSMutableAttributedString *startString = [[NSMutableAttributedString alloc] initWithString:start];
    
    NSMutableAttributedString *colorString = [[NSMutableAttributedString alloc] initWithString:colorStr];
    if (IsEmpty(font)) {
        
        [colorString addAttributes:@{NSForegroundColorAttributeName: color,} range:NSMakeRange(0, colorStr.length)];
    }else{
         [colorString addAttributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font} range:NSMakeRange(0, colorStr.length)];
    }
  
    
    NSMutableAttributedString *endString= [[NSMutableAttributedString alloc] initWithString:end];
    
    [startString appendAttributedString:colorString];
    [startString appendAttributedString:endString];
    return startString;
}


#pragma mark - 转换首字符

+ (NSString *)getChineseFirstCharPinyinWithCityStr:(NSString *)cityStr
{
    NSMutableString *pinyin = [NSMutableString stringWithString:cityStr];
    CFStringTransform((CFMutableStringRef)pinyin,NULL, kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)pinyin,NULL, kCFStringTransformStripDiacritics,NO);
    
    NSString *firstC = [pinyin substringToIndex:1];
    return firstC;
}


#pragma mark - 时间转换

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

+ (NSString *)getDateStringWithStemp:(double)stemp format:(NSString *)format
{
    NSDate *thatDate = [NSDate dateWithTimeIntervalSince1970:stemp];
    return [Utils getDateStringWithDate:thatDate format:format];
}

+ (NSString *)getDateStringWithDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSDate *)getDateWithString:(NSString *)sdate format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:sdate];
}

+ (NSString *)transformServerDate:(double)serverStemp
{
    double stemp = serverStemp;
    NSDate *servDate = [NSDate dateWithTimeIntervalSince1970:stemp];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear|
                                     NSCalendarUnitMonth |
                                     NSCalendarUnitDay|
                                     NSCalendarUnitHour |
                                     NSCalendarUnitMinute |
                                     NSCalendarUnitSecond
                                                fromDate:servDate
                                                  toDate:[NSDate date]
                                                 options:NSCalendarWrapComponents];
    if (components.year > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        return [formatter stringFromDate:servDate];
    }
    if (components.month > 0) {
        return [Utils transformMoneDay:servDate];
    }
    if (components.day > 0) {
        return [NSString stringWithFormat:@"%ld天前",(long)components.day];
    }
    if (components.hour > 0) {
        return [NSString stringWithFormat:@"%ld小时前",(long)components.hour];
    }
    if (components.minute > 0) {
        return [NSString stringWithFormat:@"%ld分钟前",(long)components.minute];
    }
    
    return @"刚刚";
}

+ (NSString *)transformMoneDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowCom = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (components.year == nowCom.year) {
        [formatter setDateFormat:@"MM-dd"];
    }else {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    return [formatter stringFromDate:date];
}
+(NSString *)getStandardTimeInterval:(NSTimeInterval)interval{
    //进行时间差比较
    //当前时间与1970时间戳(秒为单位)
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    // 当前时间戳-当时时间戳=差值(比如朋友圈动态发表时间为10分钟前(当前时间-发表时间))
    NSTimeInterval timeInterval = time-interval;
    //计算出天、小时、分钟
    int day = timeInterval/(60*60*24);
//    int hour = ((long)timeInterval%(60*60*24))/(60*60);
//    int minite = ((long)timeInterval%(60*60*24))%(60*60)/60;
    NSMutableString * timeStr = [[NSMutableString alloc]init];
    // 逻辑判断
    if (day<=3) {
        [timeStr appendString:@"最新"];
    }else if (3<day&&day<=7){
        [timeStr appendString:@"本周"];
    }else if (7<day&&day<=30){
        [timeStr appendString:@"本月"];
    }else if (30<day&&day<=90) {
        [timeStr appendString:@"三个月内"];
    }else{
        [timeStr appendString:@"三个月后"];
    }
    return timeStr;
}

+(NSString *)intervalSinceNow: (NSDate *) theDate
{
    
    
    NSTimeInterval late=[theDate timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    
    NSTimeInterval cha=now-late;
    NSString *timeString=[NSString stringWithFormat:@"%f",cha];
    
    return timeString;
}
////打开网页
//+(void)opeWebWithUrl:(NSString *)url  andWithNav:(UINavigationController *)nav{
//    CYWebViewController *vc=[[CYWebViewController alloc]init];
//    vc.backIcon=IMG(@"conventional_icon_return");
//    vc.url=[NSURL URLWithString:url];
//    vc.loadingBarTintColor = [UIColor redColor];
//    vc.hidesBottomBarWhenPushed=YES;
//    [nav pushViewController:vc animated:YES];
//}

@end
