//
//  SignController.m
//  DingEr
//
//  Created by Tcy on 2018/4/17.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "SignController.h"


@interface SignController ()
@property (weak, nonatomic) IBOutlet MYDrawView *signView;
@property (weak, nonatomic) IBOutlet UIImageView *signImage;

@end

@implementation SignController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddenBackBtn ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sure:(id)sender {
    UIImage *image = [self imageWithUIView:self.signView];
    _signImage.image = image;
    [self.signView clear];

}
- (IBAction)clear:(id)sender {
    [self.signView clear];
    _signImage.image = nil;

}

- (IBAction)back:(id)sender {
    if (_signImage.image!=nil) {
        NSLog(@"保存签名");
    }else{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先确认签名，再录入！" preferredStyle:UIAlertControllerStyleAlert];
        // UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
//            
//            [self presentViewController:[[SignController alloc]init
//                                         ] animated:YES completion:^{
//                
//            }];
            
            
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

- (IBAction)btnRotate:(UIButton *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
 //   int rotate = tag == 7? 1: -1;
//    //int rotate = tag==7? 1: -1;
    //_btn.transform = CGAffineTransformRotate(_btn.transform, M_PI_4*rotate);
    [UIView commitAnimations];
}


- (UIImage*) imageWithUIView:(UIView*) view

{
    
    UIGraphicsBeginImageContext(view.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tImage;
    
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
