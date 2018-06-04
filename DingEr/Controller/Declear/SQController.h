//
//  SQController.h
//  DingEr
//
//  Created by Tcy on 2018/5/10.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DoomController.h"

@interface SQController : DoomController
@property (nonatomic ) NSMutableDictionary *user;
@property (nonatomic ) NSMutableDictionary *infor;

@property (nonatomic ) BOOL isChange;

@property (copy,nonatomic) void (^successChange)();

@end
