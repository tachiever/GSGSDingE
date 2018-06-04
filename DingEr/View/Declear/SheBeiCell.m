//
//  SheBeiCell.m
//  DingEr
//
//  Created by Tcy on 2018/5/18.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "SheBeiCell.h"

@implementation SheBeiCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)createWithPart:(NSString *)part Loca:(NSString *)loca name:(NSString *)name{
    UILabel *nameLab= [[UILabel alloc] init];
    
    if (_isRead) {
        UIButton *cloBtn=[[UIButton alloc]init];
        cloBtn.frame=CGRectMake(0, 7, 20, 20);
        cloBtn.tag=self.tag;
        cloBtn.layer.masksToBounds=YES;
        cloBtn.layer.cornerRadius=10;
        cloBtn.backgroundColor=RGBCOLOR(255, 0, 0);
        [cloBtn setImage:[UIImage imageNamed:@"closeBtn.png"] forState:UIControlStateNormal];
        [self addSubview:cloBtn];
        [cloBtn addTarget:self action:@selector(minCell:) forControlEvents:UIControlEventTouchUpInside];
        nameLab.frame=CGRectMake(22, 0,148 , 35);
        
    }else{
        nameLab.frame=CGRectMake(6, 0,164 , 35);
        
    }
    UIView *line0=[[UIView alloc]initWithFrame:CGRectMake(0, 35, 600,1)];
    line0.backgroundColor=RGBCOLOR(92, 94, 102);
    [self addSubview:line0];
    nameLab.font = [UIFont systemFontOfSize:16];
    nameLab.textColor=[UIColor blackColor];
    // nameLab.backgroundColor=RGBCOLOR(138, 199, 255);
    nameLab.text=part;
    nameLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:nameLab];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(170, 0, 1,35 )];
    line1.backgroundColor=RGBCOLOR(92, 94, 102);
    [self addSubview:line1];
    
    UILabel *priceLab= [[UILabel alloc] initWithFrame:CGRectMake(171, 0,120 , 35)];
    priceLab.font = [UIFont systemFontOfSize:16];
    priceLab.textColor=[UIColor blackColor];
    //priceLab.backgroundColor=RGBCOLOR(138, 199, 255);
    priceLab.text=loca;
    priceLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:priceLab];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(291, 0, 1,35 )];
    line2.backgroundColor=RGBCOLOR(92, 94, 102);
    [self addSubview:line2];
    
    UILabel *countLab= [[UILabel alloc] initWithFrame:CGRectMake(292, 0,308 , 35)];
    countLab.font = [UIFont systemFontOfSize:16];
    countLab.textColor=[UIColor blackColor];
    // countLab.backgroundColor=RGBCOLOR(138, 199, 255);
    countLab.text=name;
    countLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:countLab];
    
}
- (void)minCell:(UIButton *)btn{
    if (self.closeCell) {
        self.closeCell(btn.tag);
    }
    
}

@end
