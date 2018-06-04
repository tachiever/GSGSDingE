//
//  FormView.m
//  DingEr
//
//  Created by Tcy on 2018/4/24.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "FormView.h"
#import "FromCell.h"

@interface FormView ()<UIGestureRecognizerDelegate>{
    
    NSInteger _l,chaoE;
    CGFloat _w,sum;
    UIScrollView *scr;
    
}
@property (nonatomic ) NSMutableArray *imageArr;

@end
@implementation FormView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        // 初始化设置
        _imageArr=[[NSMutableArray alloc]init];
        _w=self.frame.size.width/3-21;
        sum=0;
        _l=0;
        chaoE=0;
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
    titLab.text=@"设备定额";
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
    
    
    
    UILabel *nameLab= [[UILabel alloc] initWithFrame:CGRectMake(0, 0,222 , 35)];
    nameLab.font = [UIFont systemFontOfSize:17];
    nameLab.textColor=[UIColor blackColor];
    nameLab.backgroundColor=RGBCOLOR(220, 220, 220);
    nameLab.text=@"   名称";
    nameLab.textAlignment=NSTextAlignmentLeft;
    [scr addSubview:nameLab];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(222, 0, 1,35 )];
    line.backgroundColor=[UIColor darkGrayColor];
    [scr addSubview:line];
    
    UILabel *priceLab= [[UILabel alloc] initWithFrame:CGRectMake(223, 0,100 , 35)];
    priceLab.font = [UIFont systemFontOfSize:17];
    priceLab.textColor=[UIColor blackColor];
    priceLab.backgroundColor=RGBCOLOR(220, 220, 220);
    priceLab.text=@"单价:(元)";
    priceLab.textAlignment=NSTextAlignmentCenter;
    [scr addSubview:priceLab];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(323, 0, 1,35 )];
    line2.backgroundColor=[UIColor darkGrayColor];
    [scr addSubview:line2];
    
    UILabel *countLab= [[UILabel alloc] initWithFrame:CGRectMake(324, 0,58 , 35)];
    countLab.font = [UIFont systemFontOfSize:17];
    countLab.textColor=[UIColor blackColor];
    countLab.backgroundColor=RGBCOLOR(220, 220, 220);
    countLab.text=@"数量";
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

//            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(16,95+i*35, self.frame.size.width-32, 1)];
//            lineView.backgroundColor=RGBCOLOR(92, 94, 102);
//            [self addSubview:lineView];
            
            _titLab= [[UILabel alloc] initWithFrame:CGRectMake(30,98+i*35, self.frame.size.width-60, 30)];
            _titLab.font = [UIFont systemFontOfSize:23];
            _titLab.text=[NSString stringWithFormat:@"总价:%.2f元",sum];
            _titLab.textAlignment=NSTextAlignmentRight;
            [self addSubview:_titLab];
            
            scr.frame=CGRectMake(16, 50, self.frame.size.width-32, 35*(i+1)+2);
            scr.contentSize=CGSizeMake(382,0);
            
            if (sum>=50000) {
                chaoE=3;
                _titLab.textColor=RGBCOLOR(225, 0, 0);
            }else{
                _titLab.textColor=[UIColor blackColor];
            }
            if (self.getChaoEStatues) {
                self.getChaoEStatues(chaoE);
            }
        }else{
            FromCell *formView=[[FromCell alloc]initWithFrame:CGRectMake(0,(i+1)*35, 382, 35)];
           // formView.backgroundColor=RGBCOLOR(rand()%255, rand()%255, rand()%255);
            formView.isRead=self.isEdit;
            formView.tag=i;                
                [formView createWithName:_imageArr[i][@"machineName"] Price:[NSString stringWithFormat:@"%.2f",[_imageArr[i][@"price"] floatValue]] Count:_imageArr[i][@"serviceNum"]];
                sum+=[_imageArr[i][@"price"] floatValue]*[_imageArr[i][@"serviceNum"] floatValue];

            [formView setCloseCell:^(NSInteger sig) {
                if (self.actionCloseForm) {
                    self.actionCloseForm(sig);
                }
            }];
            [scr addSubview:formView];
            
            if([_imageArr[i][@"price"] floatValue]>=7000){
                
                chaoE=2;
            }
        }
    }
}


- (void)updateWithImageArr:(NSMutableArray *)imageArr{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _imageArr =[imageArr mutableCopy];
    sum=0;
    chaoE=0;
    [self setNeedsDisplay];
}
@end
