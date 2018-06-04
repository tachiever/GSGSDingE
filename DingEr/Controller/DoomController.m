//
//  DoomController.m
//  DingEr
//
//  Created by Tcy on 2018/4/11.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DoomController.h"

@interface DoomController ()
@property (nonatomic )  UIButton *backBtn;
@property (nonatomic )  UILabel *titLab;

@end

@implementation DoomController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIColor *topleftColor = [UIColor colorWithRed:48/255.0f green:88/255.0f blue:123/255.0f alpha:1.0f];
//    UIColor *bottomrightColor = [UIColor colorWithRed:58/255.0f green:62/255.0f blue:108/255.0f alpha:1.0f];
//
//
//   // UIColor *topleftColor = [UIColor colorWithRed:0/255.0f green:136/255.0f blue:169/255.0f alpha:1.0f];
//   // UIColor *bottomrightColor = [UIColor colorWithRed:0/255.0f green:179/255.0f blue:232/255.0f alpha:1.0f];
//
//
//    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(300, 100)];
//    //self.view.backgroundColor=[UIColor colorWithPatternImage:bgImg];
//    self.view.layer.contents = (id)bgImg.CGImage;
    
  //  self.view.backgroundColor=RGBCOLOR(32, 143, 255);
    
    
    _backBtn=[[UIButton alloc]initWithFrame:CGRectMake(25,34,30,30)];
    [_backBtn setImage:[UIImage imageNamed:@"fh.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    _titLab= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-130, 28, 260, 30)];
    _titLab.font = [UIFont systemFontOfSize:19];
    _titLab.textColor=[UIColor whiteColor];
    _titLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_titLab];
    
}
- (void)setPageTitle:(NSString *)tit{
    [_titLab setText:tit];
}

- (void)hiddenBackBtnNoTitle{
    _backBtn.hidden=YES;

}
- (void)hiddenBackBtn{
    _backBtn.hidden=YES;
    _titLab.hidden=YES;
    
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
