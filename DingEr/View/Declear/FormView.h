//
//  FormView.h
//  DingEr
//
//  Created by Tcy on 2018/4/24.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FormView : UIView
- (void)updateWithImageArr:(NSMutableArray *)imageArr;

@property (nonatomic ) UILabel *titLab;
@property (nonatomic ) NSInteger model;
@property (nonatomic ) BOOL isEdit;
@property (copy,nonatomic) void (^actionAddForm)(NSInteger tag);
@property (copy, nonatomic) void (^actionCloseForm)(NSInteger tag);

@property (copy, nonatomic) void (^getChaoEStatues)(NSInteger statue);

@end
