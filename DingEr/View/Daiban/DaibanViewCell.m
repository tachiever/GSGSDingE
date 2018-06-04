//
//  DaibanViewCell.m
//  DingEr
//
//  Created by Tcy on 2018/4/13.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DaibanViewCell.h"

@implementation DaibanViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _bgView.layer.masksToBounds=YES;
    _bgView.layer.cornerRadius=6;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
