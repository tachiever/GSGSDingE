//
//  IconView.h
//  DingEr
//
//  Created by Tcy on 2018/4/12.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconView : UIView

@property (nonatomic ) UIButton * numBtn;

@property (nonatomic ) UIButton * namBtn;

@property (nonatomic ) UIImageView * iconImage;
@property (nonatomic ) UILabel * titLab;
@property (nonatomic ) UIView * bgView;
@property (nonatomic ) UIColor * bgColor;


- (void)updateNumStatue:(NSString *)num;
- (void)setBgColor:(UIColor *)color;
- (void)setTitle:(NSString *)title font:(CGFloat)font icon:(NSString *)icon;
@property (copy,nonatomic) void (^actionShowDetail)(NSInteger tag);

@end
