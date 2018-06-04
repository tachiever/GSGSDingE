//
//  EnclusureView.h
//  DingEr
//
//  Created by Tcy on 2018/4/23.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnclusureView : UIView

- (void)updateWithImageArr:(NSMutableArray *)imageArr;
@property (nonatomic ) NSInteger model;
@property (nonatomic ) BOOL isEdit;
@property (copy,nonatomic) void (^actionAddImage)(NSInteger tag);

@end
