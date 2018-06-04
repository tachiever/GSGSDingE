//
//  DeclearViewCell.m
//  DingEr
//
//  Created by Tcy on 2018/4/16.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DeclearViewCell.h"

@implementation DeclearViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setStatue:(NSString *)str{
    self.statueLab.text=str;

    if ([str rangeOfString:@"未通过"].location != NSNotFound) {
        self.statueLab.textColor=RGBCOLOR(227, 0, 0);
    }
    else if ([str isEqualToString:@"已确认"]) {
        self.statueLab.textColor=RGBCOLOR(0, 171,98);
    }else{
        self.statueLab.textColor=[UIColor orangeColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
