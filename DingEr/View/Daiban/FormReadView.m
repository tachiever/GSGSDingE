//
//  FormReadView.m
//  DingEr
//
//  Created by Tcy on 2018/5/3.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "FormReadView.h"

#import "FromCell.h"

@interface FormReadView ()<UIGestureRecognizerDelegate>{
    
    NSInteger _l;
    CGFloat _w;
    UIScrollView *scr;
    
}
@property (nonatomic ) NSMutableArray *imageArr;

@end
@implementation FormReadView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化设置
        _imageArr=[[NSMutableArray alloc]init];
        _w=self.frame.size.width/3-21;
        _l=0;
        //        NSArray *arr=@[@"晴dlddl",@"晴少数",@"晴水",@"晴撒d实况",@"晴撒连",@"阿克苏酒店asked实况",@"酒店asked实况",@"sakd 实况"];
        //
        //        [_titArray addObjectsFromArray:arr];
    }
    return self;
}

- (void)setup {
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(16,40, self.frame.size.width-32, 1)];
    lineView.backgroundColor=RGBCOLOR(92, 94, 102);
    [self addSubview:lineView];
    
    UILabel *titLab= [[UILabel alloc] initWithFrame:CGRectMake(30, 10, self.frame.size.width-60, 30)];
    titLab.font = [UIFont systemFontOfSize:17];
    titLab.textColor=[UIColor blackColor];
    titLab.text=@"设备及数量";
    titLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:titLab];
    
    scr=[[UIScrollView alloc]initWithFrame:CGRectMake(16, 50, self.frame.size.width-32, 35)];
    scr.backgroundColor=[UIColor clearColor];
    scr.showsHorizontalScrollIndicator=NO;
    [self addSubview:scr];
    
    
    
    
    UILabel *nameLab= [[UILabel alloc] initWithFrame:CGRectMake(0, 0,206 , 35)];
    nameLab.font = [UIFont systemFontOfSize:17];
    nameLab.textColor=[UIColor blackColor];
    nameLab.backgroundColor=RGBCOLOR(138, 199, 255);
    nameLab.text=@"  设备名称";
    nameLab.textAlignment=NSTextAlignmentLeft;
    [scr addSubview:nameLab];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(206, 0, 1,35 )];
    line.backgroundColor=RGBCOLOR(92, 94, 102);
    [scr addSubview:line];
    
    UILabel *priceLab= [[UILabel alloc] initWithFrame:CGRectMake(207, 0,100 , 35)];
    priceLab.font = [UIFont systemFontOfSize:17];
    priceLab.textColor=[UIColor blackColor];
    priceLab.backgroundColor=RGBCOLOR(138, 199, 255);
    priceLab.text=@"单价:(元)";
    priceLab.textAlignment=NSTextAlignmentCenter;
    [scr addSubview:priceLab];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(307, 0, 1,35 )];
    line2.backgroundColor=RGBCOLOR(92, 94, 102);
    [scr addSubview:line2];
    
    UILabel *countLab= [[UILabel alloc] initWithFrame:CGRectMake(308, 0,58 , 35)];
    countLab.font = [UIFont systemFontOfSize:17];
    countLab.textColor=[UIColor blackColor];
    countLab.backgroundColor=RGBCOLOR(138, 199, 255);
    countLab.text=@"数量";
    countLab.textAlignment=NSTextAlignmentCenter;
    [scr addSubview:countLab];
    
}


- (void)drawRect:(CGRect)rect{
    
    [self setup];
    
    for (int i=0; i<_imageArr.count+1; i++) {
        if (i==_imageArr.count) {
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(16,95+i*35, self.frame.size.width-32, 1)];
            lineView.backgroundColor=RGBCOLOR(92, 94, 102);
            [self addSubview:lineView];
            
            UILabel *titLab= [[UILabel alloc] initWithFrame:CGRectMake(30,105+i*35, self.frame.size.width-60, 30)];
            titLab.font = [UIFont systemFontOfSize:23];
            titLab.textColor=[UIColor redColor];
            titLab.text=@"总价：22222元";
            titLab.textAlignment=NSTextAlignmentRight;
            [self addSubview:titLab];
            
            scr.frame=CGRectMake(16, 50, self.frame.size.width-32, 35*(i+1)+2);
            scr.contentSize=CGSizeMake(366,0);
            
        }else{
            FromCell *formView=[[FromCell alloc]initWithFrame:CGRectMake(0,(i+1)*35, 366, 35)];
            // formView.backgroundColor=RGBCOLOR(rand()%255, rand()%255, rand()%255);
            formView.isRead=YES;
            [formView createWithName:@"name" Price:@"jiage" Count:@"shuliang"];
            [scr addSubview:formView];
        }
    }
}


- (void)updateWithImageArr:(NSMutableArray *)imageArr{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _imageArr =[imageArr mutableCopy];
    [self setNeedsDisplay];
}
@end
