//
//  IconBtn.h
//  DingEr
//
//  Created by Tcy on 2018/4/12.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconBtn : UIView


@property (nonatomic ) UIButton *iconBtn;
@property (nonatomic ) UIView *signView;

- (void)updateSignStatue:(NSString *)update;
- (void)setIconImage:(NSString *)image;
@property (copy,nonatomic) void (^actionShowDetail)();

@end
