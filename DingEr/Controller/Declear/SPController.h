//
//  SPController.h
//  DingEr
//
//  Created by Tcy on 2018/5/11.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DoomController.h"

@interface SPController : DoomController

@property (nonatomic ) NSString *kind;
@property (nonatomic ) NSMutableDictionary *user;

@property (nonatomic ) NSMutableDictionary *infor;
@property (copy,nonatomic) void (^actionGetBack)(BOOL isgetBack);
@end
