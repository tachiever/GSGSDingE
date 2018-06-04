
//
//  SheBei.m
//  DingEr
//
//  Created by Tcy on 2018/5/14.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "SheBei.h"
#import "SheBeiCell.h"

@interface SheBei ()<UIGestureRecognizerDelegate>{
    
    NSInteger _l;
    CGFloat _w;
    UIScrollView *scr;
    
}
@property (nonatomic ) NSMutableArray *imageArr;

@end
@implementation SheBei


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
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
    //    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(16,40, self.frame.size.width-32, 1)];
    //    lineView.backgroundColor=RGBCOLOR(92, 94, 102);
    //    [self addSubview:lineView];
    
    UILabel *titLab= [[UILabel alloc] initWithFrame:CGRectMake(22, 8, self.frame.size.width-100, 30)];
    titLab.font = [UIFont systemFontOfSize:18];
    titLab.textColor=[UIColor blackColor];
    titLab.text=@"维护设备";
    titLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:titLab];
    
    if (self.isEdit) {
        UIButton *addBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-22-48, 14, 48, 26)];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        addBtn.titleLabel.font=[UIFont systemFontOfSize:17];
        [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        addBtn.layer.masksToBounds=YES;
        addBtn.layer.cornerRadius=4;
        addBtn.layer.borderWidth=1;
        addBtn.layer.borderColor=[UIColor blackColor].CGColor;
        [addBtn addTarget:self action:@selector(addfrom:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
    }
    scr=[[UIScrollView alloc]initWithFrame:CGRectMake(16, 50, self.frame.size.width-32, 35)];
    scr.backgroundColor=[UIColor clearColor];
    scr.showsHorizontalScrollIndicator=NO;
    [self addSubview:scr];
    
    
    
    UILabel *nameLab= [[UILabel alloc] initWithFrame:CGRectMake(0, 0,170 , 35)];
    nameLab.font = [UIFont systemFontOfSize:17];
    nameLab.textColor=[UIColor blackColor];
    nameLab.backgroundColor=RGBCOLOR(220, 220, 220);
    nameLab.text=@"   所属部门";
    nameLab.textAlignment=NSTextAlignmentLeft;
    [scr addSubview:nameLab];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(170, 0, 1,35 )];
    line.backgroundColor=[UIColor darkGrayColor];
    [scr addSubview:line];
    
    UILabel *priceLab= [[UILabel alloc] initWithFrame:CGRectMake(171, 0,120 , 35)];
    priceLab.font = [UIFont systemFontOfSize:17];
    priceLab.textColor=[UIColor blackColor];
    priceLab.backgroundColor=RGBCOLOR(220, 220, 220);
    priceLab.text=@"位置";
    priceLab.textAlignment=NSTextAlignmentCenter;
    [scr addSubview:priceLab];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(291, 0, 1,35 )];
    line2.backgroundColor=[UIColor darkGrayColor];
    [scr addSubview:line2];
    
    UILabel *countLab= [[UILabel alloc] initWithFrame:CGRectMake(292, 0,308 , 35)];
    countLab.font = [UIFont systemFontOfSize:17];
    countLab.textColor=[UIColor blackColor];
    countLab.backgroundColor=RGBCOLOR(220, 220, 220);
    countLab.text=@"名称";
    countLab.textAlignment=NSTextAlignmentCenter;
    [scr addSubview:countLab];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-14, self.frame.size.width,14 )];
    line3.backgroundColor=RGBCOLOR(245, 245, 245);
    [self addSubview:line3];
    
}

- (void)addfrom:(UIButton *)btn{
    if (self.actionAddForm) {
        self.actionAddForm(1);
    }
    
}

- (void)drawRect:(CGRect)rect{
    
    [self setup];
    
    for (int i=0; i<_imageArr.count+1; i++) {
        if (i==_imageArr.count) {
//
//            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(16,95+i*35, self.frame.size.width-32, 1)];
//            lineView.backgroundColor=RGBCOLOR(92, 94, 102);
//            [self addSubview:lineView];
//
//            UILabel *titLab= [[UILabel alloc] initWithFrame:CGRectMake(30,100+i*35, self.frame.size.width-60, 30)];
//            titLab.font = [UIFont systemFontOfSize:23];
//            titLab.textColor=[UIColor redColor];
//            titLab.text=@"总价：22222元";
//            titLab.textAlignment=NSTextAlignmentRight;
//            [self addSubview:titLab];
//
            scr.frame=CGRectMake(16, 50, self.frame.size.width-32, 35*(i+1)+2);
            scr.contentSize=CGSizeMake(600,0);
            
        }else{
            SheBeiCell *formView=[[SheBeiCell alloc]initWithFrame:CGRectMake(0,(i+1)*35, 382, 35)];
            // formView.backgroundColor=RGBCOLOR(rand()%255, rand()%255, rand()%255);
            formView.isRead=self.isEdit;
            formView.tag=i;
                [formView createWithPart:_imageArr[i][@"deptName"] Loca:_imageArr[i][@"locatinName"] name:_imageArr[i][@"machineName"]];
            [formView setCloseCell:^(NSInteger sig) {
                if (self.actionCloseForm) {
                    self.actionCloseForm(sig);
                }
            }];
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
