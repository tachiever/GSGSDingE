//
//  EnclusureView.m
//  DingEr
//
//  Created by Tcy on 2018/4/23.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "EnclusureView.h"
@interface EnclusureView ()<UIGestureRecognizerDelegate>{
    
    NSInteger _l;
    CGFloat _w;
    
}
@property (nonatomic ) NSMutableArray *imageArr;

@end
@implementation EnclusureView

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
    UILabel *titLab= [[UILabel alloc] initWithFrame:CGRectMake(30, 8, 100, 30)];
    titLab.font = [UIFont systemFontOfSize:18];
    titLab.textColor=[UIColor blackColor];
    titLab.text=@"附件:";
    titLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:titLab];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-14, self.frame.size.width,14)];
    line3.backgroundColor=RGBCOLOR(245, 245, 245);
    [self addSubview:line3];
    
}

- (void)drawRect:(CGRect)rect{
    
    [self setup];
    
    for (int i=0; i<_imageArr.count; i++) {
        //if (i<3) {
            UIImageView *enimageView=[[UIImageView alloc]initWithFrame:CGRectMake( 16+(_w+16)*i, 40, _w, _w*0.75)];
            enimageView.tag=i;
            enimageView.userInteractionEnabled=self.isEdit;
            [enimageView setImage:_imageArr[i]];
            [self addSubview:enimageView];
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImage:)];
            recognizer.delegate = self;
            [enimageView addGestureRecognizer:recognizer];
      //  }
    }
}

-(void)addImage:(UITapGestureRecognizer*)tapgest{
    
    if (self.actionAddImage) {
        self.actionAddImage(tapgest.view.tag);
    }
}

- (void)updateWithImageArr:(NSMutableArray *)imageArr{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _imageArr =[imageArr mutableCopy];
    [self setNeedsDisplay];
}
@end
