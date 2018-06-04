//
//  PersonView.m
//  DingEr
//
//  Created by Tcy on 2018/4/26.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "PersonView.h"

@interface PersonView ()<UIGestureRecognizerDelegate>{
    
    NSInteger _l;
    CGFloat _w;
    
}
@property (nonatomic ) NSMutableArray *personArr;

@end
@implementation PersonView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];

        // 初始化设置
        _personArr=[[NSMutableArray alloc]init];
        _w=self.frame.size.width/4-32;
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
    
    UILabel *titLab= [[UILabel alloc] initWithFrame:CGRectMake(30, 8, self.frame.size.width-60, 30)];
    titLab.font = [UIFont systemFontOfSize:17];
    titLab.textColor=[UIColor blackColor];
    titLab.text=self.title;
    titLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:titLab];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-14, self.frame.size.width,14 )];
    line3.backgroundColor=RGBCOLOR(245, 245, 245);
    [self addSubview:line3];
    
    
}

- (void)drawRect:(CGRect)rect{
    [self setup];
    
    UILabel *nameLab= [[UILabel alloc] initWithFrame:CGRectMake(22+(_w+20)*0, 40, _w, _w)];
    nameLab.font = [UIFont systemFontOfSize:20];
    nameLab.layer.masksToBounds=YES;
    nameLab.layer.cornerRadius=_w/2;
    nameLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:nameLab];
    nameLab.userInteractionEnabled=self.isEdit;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPerson:)];
    recognizer.delegate = self;
    [nameLab addGestureRecognizer:recognizer];
    
   // if (_personArr.count==0) {
        nameLab.backgroundColor=RGBCOLOR(235, 235, 235);
        nameLab.textColor=RGBCOLOR(102, 102, 112);
        nameLab.text=@"+";
 //   }else{
        
 
 //   }
//添加多个
    /*
     for (int i=0; i<_personArr.count+1; i++) {
     if (i<_personArr.count) {
     UILabel *nameLab= [[UILabel alloc] initWithFrame:CGRectMake(20+(_w+20)*i, 50, _w, _w)];
     nameLab.font = [UIFont systemFontOfSize:17];
     nameLab.backgroundColor=[UIColor colorWithPatternImage:[UIImage makeArrowImageWithSize:CGSizeMake(_w, _w) image:[UIImage imageNamed:@"egImage.png"] isSender:NO]];
     nameLab.layer.masksToBounds=YES;
     nameLab.layer.cornerRadius=_w/2;
     nameLab.textColor=[UIColor blackColor];
     nameLab.text=self.title;
     nameLab.textAlignment=NSTextAlignmentCenter;
     [self addSubview:nameLab];
     nameLab.tag=i;
     nameLab.userInteractionEnabled=self.isEdit;
     UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPerson:)];
     recognizer.delegate = self;
     [nameLab addGestureRecognizer:recognizer];
     
     UIImageView *cloIcon=[[UIImageView alloc]initWithFrame:CGRectMake((_w+20)*(i+1)-14, 45, 16, 16)];
     [cloIcon setImage:[UIImage imageNamed:@"closeIcon.png"]];
     [cloIcon setContentMode:UIViewContentModeScaleAspectFit];
     [self addSubview:cloIcon];
     }else{
     UILabel *nameLab= [[UILabel alloc] initWithFrame:CGRectMake(20+(_w+20)*i, 50, _w, _w)];
     nameLab.font = [UIFont systemFontOfSize:20];
     nameLab.backgroundColor=RGBCOLOR(199, 194, 202);
     nameLab.layer.masksToBounds=YES;
     nameLab.layer.cornerRadius=_w/2;
     nameLab.textColor=RGBCOLOR(102, 102, 112);
     nameLab.text=@"+";
     nameLab.textAlignment=NSTextAlignmentCenter;
     [self addSubview:nameLab];
     nameLab.tag=i;
     nameLab.userInteractionEnabled=self.isEdit;
     
     UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPerson:)];
     recognizer.delegate = self;
     [nameLab addGestureRecognizer:recognizer];
     }
     }
     */
}
- (void)addPerson:(UITapGestureRecognizer *)tap{
    
    if (self.actionAddPerson) {
        if (_personArr.count==0) {
            self.actionAddPerson(0);
        }else{
            self.actionAddPerson(1);

        }
    }
}

- (void)updateWithPersonArr:(NSMutableArray *)personArr{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _personArr =[personArr mutableCopy];
    [self setNeedsDisplay];
}

@end
