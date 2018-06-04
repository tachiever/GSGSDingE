//
//  IconBtn.m
//  DingEr
//
//  Created by Tcy on 2018/4/12.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "IconBtn.h"

@implementation IconBtn

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
        
    }
    return self;
}

- (void)setup {
    self.layer.shadowOffset = CGSizeMake(4, 5);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.layer.shadowRadius = 4;//阴影半径，默认3
    //    self.layer.masksToBounds=YES;
    //    self.layer.cornerRadius=6;
    
    
    _iconBtn=[[UIButton alloc]initWithFrame:CGRectMake(8,8,self.frame.size.width-16,self.frame.size.height-16)];
    [_iconBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_iconBtn];
    
    _signView=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-10,0, 10, 10)];
    _signView.layer.masksToBounds=YES;
    _signView.layer.cornerRadius=5;
    _signView.backgroundColor=RGBCOLOR(255, 60, 70);
    [self addSubview:_signView];

    
}
- (void)setIconImage:(NSString *)image{
    [_iconBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
}
- (void)updateSignStatue:(NSString *)update{
    if ([update boolValue]==YES) {
        _signView.hidden=NO;
    }else{
        
        _signView.hidden=YES;
    }
}
- (void)closeView{
    if (self.actionShowDetail) {
        self.actionShowDetail();
    }
}

@end
