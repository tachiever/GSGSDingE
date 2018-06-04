//
//  FromCell.m
//  DingEr
//
//  Created by Tcy on 2018/4/24.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "FromCell.h"

@implementation FromCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (void)createWithName:(NSString *)name Price:(NSString *)price Count:(NSString *)count{
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
        nameLab.frame=CGRectMake(22, 0,184 , 35);

    }else{
        nameLab.frame=CGRectMake(6, 0,200 , 35);

    }
    UIView *line0=[[UIView alloc]initWithFrame:CGRectMake(0, 35, self.frame.size.width,1)];
    line0.backgroundColor=RGBCOLOR(92, 94, 102);
    [self addSubview:line0];
    nameLab.font = [UIFont systemFontOfSize:16];
    nameLab.textColor=[UIColor blackColor];
   // nameLab.backgroundColor=RGBCOLOR(138, 199, 255);
    nameLab.text=name;
    nameLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:nameLab];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(222, 0, 1,35 )];
    line1.backgroundColor=RGBCOLOR(92, 94, 102);
    [self addSubview:line1];
    
    UILabel *priceLab= [[UILabel alloc] initWithFrame:CGRectMake(223, 0,100 , 35)];
    priceLab.font = [UIFont systemFontOfSize:16];
    priceLab.textColor=[UIColor blackColor];
    //priceLab.backgroundColor=RGBCOLOR(138, 199, 255);
    priceLab.text=price;
    priceLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:priceLab];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(323, 0, 1,35 )];
    line2.backgroundColor=RGBCOLOR(92, 94, 102);
    [self addSubview:line2];
    
    UILabel *countLab= [[UILabel alloc] initWithFrame:CGRectMake(324, 0,58 , 35)];
    countLab.font = [UIFont systemFontOfSize:16];
    countLab.textColor=[UIColor blackColor];
   // countLab.backgroundColor=RGBCOLOR(138, 199, 255);
    countLab.text=count;
    countLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:countLab];
    
}
- (void)minCell:(UIButton *)btn{
    if (self.closeCell) {
        self.closeCell(btn.tag);
    }
    
}
- (void)setup {
//    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(16,40, self.frame.size.width-32, 1)];
//    lineView.backgroundColor=RGBCOLOR(92, 94, 102);
//    [self addSubview:lineView];
//    
//    UILabel *titLab= [[UILabel alloc] initWithFrame:CGRectMake(30, 10, self.frame.size.width-60, 30)];
//    titLab.font = [UIFont systemFontOfSize:17];
//    titLab.textColor=[UIColor blackColor];
//    titLab.text=@"请添加设备及数量";
//    titLab.textAlignment=NSTextAlignmentLeft;
//    [self addSubview:titLab];
    
}

@end
