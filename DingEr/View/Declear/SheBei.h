//
//  SheBei.h
//  DingEr
//
//  Created by Tcy on 2018/5/14.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheBei : UIView
- (void)updateWithImageArr:(NSMutableArray *)imageArr;

@property (nonatomic ) NSString *title;
@property (nonatomic ) NSString *sum;
@property (nonatomic ) NSInteger model;
@property (nonatomic ) BOOL isEdit;
@property (copy,nonatomic) void (^actionAddForm)(NSInteger tag);
@property (copy, nonatomic) void (^actionCloseForm)(NSInteger tag);

@end
