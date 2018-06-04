//
//  EquipCell.m
//  DingEr
//
//  Created by Tcy on 2018/4/25.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "EquipCell.h"

@implementation EquipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _numLab.layer.borderWidth=1;
    _numLab.layer.borderColor=RGBCOLOR(155, 155, 155).CGColor;
    _numLab.layer.cornerRadius=2;
    _numLab.layer.masksToBounds=YES;
}
- (IBAction)addNum:(id)sender {
    if ([_numLab.text intValue]<=98) {
        NSInteger num=[_numLab.text integerValue];
        num+=1;
        _numLab.text=[NSString stringWithFormat:@"%ld",(long)num];
        if (self.changeNumAction) {
            self.changeNumAction(num);
        }
    }
}
- (IBAction)minusNum:(id)sender {
    if ([_numLab.text intValue]>=2) {
        NSInteger num=[_numLab.text integerValue];
        num-=1;
        _numLab.text=[NSString stringWithFormat:@"%ld",(long)num];
        if (self.changeNumAction) {
            self.changeNumAction(num);
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
