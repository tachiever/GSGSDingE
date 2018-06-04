//
//  NSString+SignStr.h
//  ZhenBanWeather
//
//  Created by Tcy on 2017/9/15.
//  Copyright © 2017年 Tcytachiever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SignStr)
+ (NSString *)ChineseDateMandD;
+ (NSString *)ChineseDate;
+(NSString *)nowTimeStyle1;
+(NSString *)nowTimeStyle2;
+ (NSString *)nowTimeStyle4;
+(NSString *)timeStr;
+(NSString *)signStrWithToken:(NSString *)str tim:(NSString *)tim;
+(CGFloat)stringWidth:(NSString *)str font:(CGFloat)font;
+(CGFloat)stringHight:(NSString *)str font:(CGFloat)font width:(CGFloat)width;
+ (NSString *)weaIconWithWea:(NSString *)str;
+ (NSString *)beginTime:(NSString *)begStr endtime:(NSString *)endStr;
+ (NSString *)HourstimeBegin:(NSString *)begStr timeEnd:(NSString *)endStr;

- (BOOL)isMobileNumberClassification;
- (BOOL)isMobileNumber;
- (BOOL)isEmailAddress;
- (BOOL) simpleVerifyIdentityCardNum;
- (BOOL)isCarNumber;
- (BOOL)isMacAddress;
- (BOOL)isValidUrl;
- (BOOL)isValidChinese;
- (BOOL)isValidPostalcode;
- (BOOL)isValidTaxNo;
//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;
- (BOOL)bankCardluhmCheck;
- (BOOL)isIPAddress;
@end
