//
//  NSString+SignStr.m
//  ZhenBanWeather
//
//  Created by Tcy on 2017/9/15.
//  Copyright © 2017年 Tcytachiever. All rights reserved.
//

#import "NSString+SignStr.h"

@implementation NSString (SignStr)

+ (NSString *)weaIconWithWea:(NSString *)str{
    NSString *dayIconstr;
    if ([str isEqualToString:@"晴"]){
        dayIconstr=@"d_qing.png";
    }
    else if ([str isEqualToString:@"多云"]){
        dayIconstr=@"d_duoyun.png";
    }
    else if ([str isEqualToString:@"阴"]){
        dayIconstr=@"d_yin.png";
    }
    else if ([str isEqualToString:@"阵雨"]){
        dayIconstr=@"d_zhenyu";
    }
    else if ([str isEqualToString:@"雷阵雨"]){
        dayIconstr=@"d_leizhenyu";
    }
    else if ([str isEqualToString:@"冰雹"]){
        dayIconstr=@"d_leizhengyubanyoubingbao";
    }
    else if ([str isEqualToString:@"雨夹雪"]){
        dayIconstr=@"d_yujiaxue";
    }
    else if ([str isEqualToString:@"阵雪"]){
        dayIconstr=@"d_zhenxue";
    }
    else if ([str isEqualToString:@"雾"]){
        dayIconstr=@"d_wu";
    }
    else if ([str isEqualToString:@"冻雨"]){
        dayIconstr=@"d_dongyu";
    }
    else if ([str isEqualToString:@"沙尘暴"]){
        dayIconstr=@"d_shachenbao";
    }
    else if ([str isEqualToString:@"小雨"]){
        dayIconstr=@"d_xiaoyu";
    }
    else if ([str isEqualToString:@"中雨"]){
        dayIconstr=@"d_xiaoyu_zhongyu";
    }
    else if ([str isEqualToString:@"大雨"]){
        dayIconstr=@"d_zhongyu_dayu";
    }
    else if ([str isEqualToString:@"暴雨"]){
        dayIconstr=@"d_dayu_baoyu";
    }
    else if ([str isEqualToString:@"大暴雨"]){
        dayIconstr=@"d_baoyu_dabaoyu";
    }
    else if ([str isEqualToString:@"特大暴雨"]){
        dayIconstr=@"d_dabaoyu_tedabaoyu";
    }
    else if ([str isEqualToString:@"小雪"]){
        dayIconstr=@"d_xiaoxue";
    }
    else if ([str isEqualToString:@"中雪"]){
        dayIconstr=@"d_xiaoxue_zhongxue";
    }
    else if ([str isEqualToString:@"大雪"]){
        dayIconstr=@"d_zhongxue_daxue";
    }
    else if ([str isEqualToString:@"暴雪"]){
        dayIconstr=@"d_daxue_baoxue";
    }
    else if ([str isEqualToString:@"阵雪"]){
        dayIconstr=@"d_zhenxue";
    }
    else if ([str isEqualToString:@"浮尘"]){
        dayIconstr=@"d_fuchen";
    }
    else if ([str isEqualToString:@"扬沙"]){
        dayIconstr=@"d_yangsha";
    }
    else if ([str isEqualToString:@"强沙尘暴"]){
        dayIconstr=@"d_qiangshachenbao";
    }
    else if ([str isEqualToString:@"雨"]){
        dayIconstr=@"d_zhongyu";
    }
    else if ([str isEqualToString:@"雪"]){
        dayIconstr=@"d_zhongxue";
    }
    else if ([str isEqualToString:@"霾"]){
        dayIconstr=@"d_mai";
    }
    else{
        dayIconstr=@"d_qing";
    }
    
    return dayIconstr;
}
- (NSString *)dayWeatherChangeImage:(NSString *)weather{
    
    NSString *dayIconstr;
    NSInteger dayIcon=[weather integerValue];
    if (0==dayIcon){
        dayIconstr=@"d_qing";
    }
    else if (1==dayIcon){
        dayIconstr=@"d_duoyun";
    }
    else if (2==dayIcon){
        dayIconstr=@"d_yin";
        
    }
    else if (3==dayIcon){
        dayIconstr=@"d_zhenyu";
    }
    else if (4==dayIcon){
        dayIconstr=@"d_leizhenyu";
    }
    else if (5==dayIcon){
        dayIconstr=@"d_leizhengyubanyoubingbao";
    }
    else if (6==dayIcon){
        dayIconstr=@"d_yujiaxue";
    }
    else if (7==dayIcon){
        dayIconstr=@"d_xiaoyu";
    }
    else if (8==dayIcon){
        dayIconstr=@"d_zhongyu";
    }
    else if (9==dayIcon){
        dayIconstr=@"d_dayu";
    }
    else if (10==dayIcon){
        dayIconstr=@"d_baoyu";
    }
    else if (11==dayIcon){
        dayIconstr=@"d_dabaoyu";
    }
    else if (12==dayIcon){
        dayIconstr=@"d_tedabaoyu";
    }
    else if (13==dayIcon){
        dayIconstr=@"d_zhenxue";
    }
    else if (14==dayIcon){
        dayIconstr=@"d_xiaoxue";
    }
    else if (15==dayIcon){
        dayIconstr=@"d_zhongxue";
    }
    else if (16==dayIcon){
        dayIconstr=@"d_daxue";
    }
    else if (17==dayIcon){
        dayIconstr=@"d_baoxue";
    }
    else if (18==dayIcon){
        dayIconstr=@"d_wu";
    }
    else if (19==dayIcon){
        dayIconstr=@"d_dongyu";
    }
    else if (20==dayIcon){
        dayIconstr=@"d_shachenbao";
    }
    else if (21==dayIcon){
        dayIconstr=@"d_xiaoyu_zhongyu";
    }
    else if (22==dayIcon){
        dayIconstr=@"d_zhongyu_dayu";
    }
    else if (23==dayIcon){
        dayIconstr=@"d_dayu_baoyu";
    }
    else if (24==dayIcon){
        dayIconstr=@"d_baoyu_dabaoyu";
    }
    else if (25==dayIcon){
        dayIconstr=@"d_dabaoyu_tedabaoyu";
    }
    else if (26==dayIcon){
        dayIconstr=@"d_xiaoxue_zhongxue";
    }
    else if (27==dayIcon){
        dayIconstr=@"d_zhongxue_daxue";
    }
    else if (28==dayIcon){
        dayIconstr=@"d_daxue_baoxue";
    }
    else if (29==dayIcon){
        dayIconstr=@"d_fuchen";
    }
    else if (30==dayIcon){
        dayIconstr=@"d_yangsha";
    }
    else if (31==dayIcon){
        dayIconstr=@"d_qiangshachenbao";
    }
    
    else if (33==dayIcon){
        dayIconstr=@"d_zhongyu";
    }
    else if (33==dayIcon){
        dayIconstr=@"d_zhongxue";
    }
    else if (53==dayIcon){
        dayIconstr=@"d_mai";
    }
    else{
        dayIconstr=@"d_qing";
        
    }
    
    return dayIconstr;
}

+(CGFloat)stringHight:(NSString *)str font:(CGFloat)font width:(CGFloat)width{
    CGFloat h;
    CGSize titleSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    h=titleSize.height;
    return h;
}

+(CGFloat)stringWidth:(NSString *)str font:(CGFloat)font{
    CGFloat w;
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:font]};
    CGSize size=[str sizeWithAttributes:attrs];
    w=size.width;
    return w;
}

+(NSString *)nowTimeStyle1{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *formate=[[NSDateFormatter alloc]init];
    [formate setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [formate stringFromDate:dat];
    return timeString;
}
+(NSString *)nowTimeStyle2{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *formate=[[NSDateFormatter alloc]init];
    [formate setDateFormat:@"HH mm"];
    NSString *timeString = [formate stringFromDate:dat];
    return timeString;
}
+ (NSString *)nowTimeStyle4{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *formate=[[NSDateFormatter alloc]init];
    [formate setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeString = [formate stringFromDate:dat];
    return timeString;
}

+(NSString *)timeStr{

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];
    return timeString;
}
+(NSString *)signStrWithToken:(NSString *)str tim:(NSString *)tim{
    NSString *signStr=[NSString stringWithFormat:@"time=%@&token=%@",tim,str];
   NSString *resultStr= [signStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return resultStr;
}

+ (NSString *)ChineseDate{
    NSArray *chineseYear = @[@"鼠", @"牛", @"虎", @"兔", @"龙", @"蛇", @"马", @"羊", @"猴", @"鸡", @"狗", @"猪"];
    NSArray *HeavenlyStems= @[@"甲", @"乙", @"丙",@"丁", @"戊", @"己", @"庚", @"辛", @"壬", @"癸"];
    NSArray *EarthlyBranches= @[@"子", @"丑", @"寅", @"卯", @"辰", @"巳", @"午", @"未", @"申", @"酉", @"戌", @"亥"];
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *day = [dateFormatter stringFromDate:date];
    
    NSDateFormatter *wekFormate=[[NSDateFormatter alloc]init];
    [wekFormate setDateFormat:@"EEEE"];
    NSString *week = [wekFormate stringFromDate:date];
    
    NSCalendar *calendarChinese = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSCalendarUnit calenderUnitChinese = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *componentsChinese = [calendarChinese components:calenderUnitChinese fromDate:date];
    //    NSLog(@"Year: %ld", componentsChinese.year);
    //    NSLog(@"Month: %ld", componentsChinese.month);
    //    NSLog(@"Day: %ld", componentsChinese.day);
    //    NSLog(@"Day: %@", date);
    
    NSString *mon=[NSString stringWithFormat:@"%@",[NSString monToString:componentsChinese.month]];
    NSString *days=[NSString stringWithFormat:@"%@",[NSString dayToString:componentsChinese.day]];
    NSInteger x=(componentsChinese.year -1)%chineseYear.count;
    NSInteger y=(componentsChinese.year -1)%HeavenlyStems.count;
    NSInteger z=(componentsChinese.year -1)%EarthlyBranches.count;
    
    NSString *str=[NSString stringWithFormat:@"阳历%@ %@\n农历%@月%@ (%@年 %@%@)",day,week,mon,days,chineseYear[x],HeavenlyStems[y],EarthlyBranches[z]];
    return str;
    
}
+ (NSString *)ChineseDateMandD{
    NSDate *date = [NSDate date];
    NSCalendar *calendarChinese = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSCalendarUnit calenderUnitChinese = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *componentsChinese = [calendarChinese components:calenderUnitChinese fromDate:date];
    NSString *mon=[NSString stringWithFormat:@"%@",[NSString monToString:componentsChinese.month]];
    NSString *days=[NSString stringWithFormat:@"%@",[NSString dayToString:componentsChinese.day]];
    NSString *str=[NSString stringWithFormat:@"%@月%@",mon,days];
    return str;
    
}

+ (NSString *)monToString:(NSInteger )num{
    NSString *str;
    switch (num) {
        case 1:
            str=@"一";
            break;
        case 2:
            str=@"二";
            break;
        case 3:
            str=@"三";
            break;
        case 4:
            str=@"四";
            break;
        case 5:
            str=@"五";
            break;
        case 6:
            str=@"六";
            break;
        case 7:
            str=@"七";
            break;
        case 8:
            str=@"八";
            break;
        case 9:
            str=@"九";
            break;
        case 10:
            str=@"十";
            break;
        case 11:
            str=@"十一";
            break;
        case 12:
            str=@"十二";
            break;
        default:
            NSLog(@"错误");
            break;
    }
    return str;
}
+ (NSString *)dayToString:(NSInteger )num{
    NSString *str;
    switch (num) {
        case 1:
            str=@"初一";
            break;
        case 2:
            str=@"初二";
            break;
        case 3:
            str=@"初三";
            break;
        case 4:
            str=@"初四";
            break;
        case 5:
            str=@"初五";
            break;
        case 6:
            str=@"初六";
            break;
        case 7:
            str=@"初七";
            break;
        case 8:
            str=@"初八";
            break;
        case 9:
            str=@"初九";
            break;
        case 10:
            str=@"初十";
            break;
        case 11:
            str=@"十一";
            break;
        case 12:
            str=@"十二";
            break;
        case 13:
            str=@"十三";
            break;
        case 14:
            str=@"十四";
            break;
        case 15:
            str=@"十五";
            break;
        case 16:
            str=@"十六";
            break;
        case 17:
            str=@"十七";
            break;
        case 18:
            str=@"十八";
            break;
        case 19:
            str=@"十九";
            break;
        case 20:
            str=@"二十";
            break;
        case 21:
            str=@"廿一";
            break;
        case 22:
            str=@"廿二";
            break;
        case 23:
            str=@"廿三";
            break;
        case 24:
            str=@"廿四";
            break;
        case 25:
            str=@"廿五";
            break;
        case 26:
            str=@"廿六";
            break;
        case 27:
            str=@"廿七";
            break;
        case 28:
            str=@"廿八";
            break;
        case 29:
            str=@"廿九";
            break;
        case 30:
            str=@"三十";
            break;
        case 31:
            str=@"三十一";
            break;
        default:
            NSLog(@"错误");
            break;
    }
    return str;
}


#pragma mark - 时间差计算
+ (NSString *)HourstimeBegin:(NSString *)begStr timeEnd:(NSString *)endStr{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *dateB =[dateFormat dateFromString:begStr];
    NSDate *dateE =[dateFormat dateFromString:endStr];
    NSTimeInterval time = [dateE timeIntervalSinceDate:dateB];
    int hours = (int)time /3600;
    int minute = (int)time /60%60;
    CGFloat pointMin=minute/60.0;


    return [NSString stringWithFormat:@"%.1f",hours+pointMin];
}

+ (NSString *)beginTime:(NSString *)begStr endtime:(NSString *)endStr{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *dateB =[dateFormat dateFromString:begStr];
    NSDate *dateE =[dateFormat dateFromString:endStr];
    NSTimeInterval time = [dateE timeIntervalSinceDate:dateB];
    
    int minute = (int)time /60%60;
    int hours = (int)time % (24 * 3600)/3600;
    int day = (int)time / (24 * 3600);
    NSString *str;
    if(day==0){
        if(hours==0){
            if(minute==0){
                str=[NSString stringWithFormat:@"历时%d分钟",minute];

            }else{
                str=[NSString stringWithFormat:@"历时%d分钟",minute];

            }
        }else{
            str=[NSString stringWithFormat:@"历时%d小时%d分钟",hours,minute];

        }
    }else{
        str=[NSString stringWithFormat:@"历时%d天%d小时%d分钟",day,hours,minute];
    }
    
    return str;
}
#pragma mark - 正则相关
- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

#pragma mark -

//手机号分服务商
- (BOOL)isMobileNumberClassification{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,1709
     17         */
    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,1700
     22         */
    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([self isValidateByRegex:CM])
        || ([self isValidateByRegex:CU])
        || ([self isValidateByRegex:CT])
        || ([self isValidateByRegex:PHS]))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//手机号有效性
- (BOOL)isMobileNumber{
    /**
     *  手机号以13、15、18、170开头，8个 \d 数字字符
     *  小灵通 区号：010,020,021,022,023,024,025,027,028,029 还有未设置的新区号xxx
     */
    NSString *mobileNoRegex = @"^1((3\\d|5[0-35-9]|8[025-9])\\d|70[059])\\d{7}$";//除4以外的所有个位整数，不能使用[^4,\\d]匹配，这里是否iOS Bug?
    NSString *phsRegex =@"^0(10|2[0-57-9]|\\d{3})\\d{7,8}$";
    
    BOOL ret = [self isValidateByRegex:mobileNoRegex];
    BOOL ret1 = [self isValidateByRegex:phsRegex];
    
    return (ret || ret1);
}

//邮箱
- (BOOL)isEmailAddress{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

//身份证号
- (BOOL) simpleVerifyIdentityCardNum{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self isValidateByRegex:regex2];
}

//车牌
- (BOOL)isCarNumber{
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";//其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    return [self isValidateByRegex:carRegex];
}

//
- (BOOL)isMacAddress{
    NSString * macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    return  [self isValidateByRegex:macAddRegex];
}


- (BOOL)isValidUrl
{
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self isValidateByRegex:regex];
}

- (BOOL)isValidChinese{
    NSString *chineseRegex = @"^[\u4e00-\u9fa5]+$";
    return [self isValidateByRegex:chineseRegex];
}

- (BOOL)isValidPostalcode {
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    return [self isValidateByRegex:postalRegex];
}

- (BOOL)isValidTaxNo
{
    NSString *taxNoRegex = @"[0-9]\\d{13}([0-9]|X)$";
    return [self isValidateByRegex:taxNoRegex];
}

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
{
    //  [\u4e00-\u9fa5A-Za-z0-9_]{4,20}
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    
    NSString *regex = [NSString stringWithFormat:@"%@[%@A-Za-z0-9_]{%d,%d}", first, hanzi, (int)(minLenth-1), (int)(maxLenth-1)];
    return [self isValidateByRegex:regex];
}

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
{
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    return [self isValidateByRegex:regex];
}

#pragma mark - 算法相关
//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}



/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)bankCardluhmCheck{
    NSString * lastNum = [[self substringFromIndex:(self.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[self substringToIndex:(self.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0)?YES:NO;
}

- (BOOL)isIPAddress{
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL rc = [pre evaluateWithObject:self];
    
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        
        return v;
    }
    
    return NO;
}



@end
