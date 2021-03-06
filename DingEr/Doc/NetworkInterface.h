//
//  NetworkInterface.h
//  BaojiWeather
//
//  Created by Tcy on 2017/2/16.
//  Copyright © 2017年 Tcy. All rights reserved.
//

#ifndef NetworkInterface_h
#define NetworkInterface_h


#define DDLOG(...) printf("%s\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);

#define ImageUrl @"http://192.168.50.26:8080/RMSYS/%@"
#define URLHOST @"http://192.168.50.26:8080/RMSYS/rest/%@"
//#define URLHOST @"http://47.92.116.253:8080/RMSYS/rest/%@"

#define baikeUrl @"http://wapbaike.baidu.com/item/%@"

#define RealWeather @"http://219.144.95.133:8082/dfecw/real?"
#define WeaForCast @"http://219.144.95.133:8082/dfecw/forcast?"

#define UploadDataSX @"http://219.144.95.133:8082/dfecw/upload"


#define LoginUrl [URLHOST stringByAppendingFormat:@"/gus"]
#define CheckUrl [URLHOST stringByAppendingFormat:@"/stnam?"]
#define TemAndFall [URLHOST stringByAppendingFormat:@"/live"]
#define UploadData [URLHOST stringByAppendingFormat:@"/uploadgs"]
#define Weather [URLHOST stringByAppendingFormat:@"/pred"]

#define WarnUrl [URLHOST stringByAppendingFormat:@"/warngs"]

#define QiXiangBK @"http://219.144.95.133:8082/dfecw/wns"
#define Service @"http://219.144.95.133:8082/dfecw/sps"

#define BgImage @"http://219.144.95.133:8082/dfecw/bjimg/bj%d.jpg"

#endif /* NetworkInterface_h */
