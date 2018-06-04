//
//  IconView.m
//  DingEr
//
//  Created by Tcy on 2018/4/12.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "IconView.h"

@interface IconView ()<UIGestureRecognizerDelegate>


@end


@implementation IconView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化设置
        
        [self setup];
        
    }
    return self;
}

- (void)setup {
    self.layer.shadowOffset = CGSizeMake(4, 5);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.layer.shadowRadius = 4;//阴影半径，默认3
    //self.layer.masksToBounds=YES;
    // self.layer.cornerRadius=6;
    
    
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(4, 4, self.frame.size.width-8, self.frame.size.height-8)];
     _bgView.layer.cornerRadius=4;
    _bgView.layer.masksToBounds=YES;
    
    [self addSubview:_bgView];
    
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetail)];
    recognizer.delegate = self;
    [_bgView addGestureRecognizer:recognizer];
    
    
    
    
    
    
    _titLab= [[UILabel alloc] initWithFrame:CGRectMake(_bgView.frame.size.width/2-10, 0, _bgView.frame.size.width/2, _bgView.frame.size.height)];
    //_titLab.font = [UIFont systemFontOfSize:18];
    _titLab.numberOfLines=0;
    _titLab.textColor=RGBCOLOR(0, 46, 98);
    _titLab.textAlignment=NSTextAlignmentLeft;
    [_bgView addSubview:_titLab];
    
    _iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(_bgView.frame.size.width/2-45, _bgView.frame.size.height/2-15, 30,30)];
    [_bgView addSubview:_iconImage];
    
    
    _namBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _namBtn.frame=CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20);
    [_namBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_namBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //[_closeBtn setImage:[UIImage imageNamed:@"closeBtn.png"] forState:UIControlStateNormal];
    
    
    [_namBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    //[self addSubview:_namBtn];
    
    
    
    _numBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-26,0,26,26)];
    _numBtn.layer.masksToBounds=YES;
    _numBtn.layer.cornerRadius=13;
    [_numBtn setBackgroundColor:RGBCOLOR(255, 60, 70)];
    [_numBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_numBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //[_closeBtn setImage:[UIImage imageNamed:@"closeBtn.png"] forState:UIControlStateNormal];
    
    
    [_numBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_numBtn];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    _bgView.backgroundColor = [_bgColor colorWithAlphaComponent:1];
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    _bgView.backgroundColor = [_bgColor colorWithAlphaComponent:0.5];
    
    
    return YES;
}



- (void)setBgColor:(UIColor *)color{
    _bgColor=color;
    [_bgView setBackgroundColor:color];
    
    [_namBtn setBackgroundColor:color];
}
- (void)setTitle:(NSString *)title font:(CGFloat)font icon:(NSString *)icon{
    [_titLab setText:title];
    _titLab.font=[UIFont systemFontOfSize:font];
    [_iconImage setImage:[UIImage imageNamed:icon]];
    
    [_namBtn setTitle:title forState:UIControlStateNormal];
    [_namBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    
}

- (void)updateNumStatue:(NSString *)num{
    if ([num integerValue]>0) {
        [_numBtn setTitle:num forState:UIControlStateNormal];
        _numBtn.hidden=NO;
        
    }else{
        _numBtn.hidden=YES;
        
    }
}

-(void)showDetail{
    
    //    [UIView animateWithDuration:0.1 animations:^{
    //
    //        _bgView.backgroundColor = [_bgColor colorWithAlphaComponent:0.5];
    //    } completion:^(BOOL finished) {
    //        _bgView.backgroundColor = [_bgColor colorWithAlphaComponent:1];
    //
    //    }];
    
    if (self.actionShowDetail) {
        self.actionShowDetail(self.tag);
    }
    
    
    
}
- (void)closeView{
    
    if (self.actionShowDetail) {
        self.actionShowDetail(self.tag);
    }
}

@end
