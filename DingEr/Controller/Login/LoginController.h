//
//  LoginController.h
//  DingEr
//
//  Created by Tcy on 2018/4/11.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DoomController.h"

@interface LoginController : DoomController
@property (copy,nonatomic) void (^checkSignImage)();
@property (copy,nonatomic) void (^loginSuccess)(NSMutableDictionary *userInfo);

@end
