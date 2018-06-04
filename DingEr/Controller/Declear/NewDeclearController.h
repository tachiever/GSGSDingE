//
//  NewDeclearController.h
//  DingEr
//
//  Created by Tcy on 2018/4/20.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DoomController.h"

@interface NewDeclearController : DoomController
@property (nonatomic ) BOOL isChange;

@property (copy,nonatomic ) void(^changeDeclearAction)();

@end
