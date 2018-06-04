//
//  LoginController.m
//  DingEr
//
//  Created by Tcy on 2018/4/11.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()<UITextFieldDelegate>{
    
    CGFloat _h;
}
@property (strong, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UIImageView *phoneIcon;
@property (weak, nonatomic) IBOutlet UIImageView *passIcon;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
        UIColor *topleftColor = [UIColor colorWithRed:48/255.0f green:88/255.0f blue:123/255.0f alpha:1.0f];
        UIColor *bottomrightColor = [UIColor colorWithRed:58/255.0f green:62/255.0f blue:108/255.0f alpha:1.0f];
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(300, 100)];
        self.view.layer.contents = (id)bgImg.CGImage;
    
    
    CGFloat pro=(SCREEN_WIDTH>320)?((SCREEN_WIDTH>400)?0.16:0.18):0.2;
    _h=(SCREEN_HEIGHT>600)?20:35;
    _accountView.frame=CGRectMake(0, SCREEN_HEIGHT/2-49, SCREEN_WIDTH, 172);
    [self.view addSubview:_accountView];
    
    _phoneField.layer.shadowOffset = CGSizeMake(4, 5);
    _phoneField.layer.shadowColor = [UIColor blackColor].CGColor;
    _phoneField.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    _phoneField.layer.shadowRadius = 4;//阴影半径，默认3
    
    _passField.layer.shadowOffset = CGSizeMake(4, 5);
    _passField.layer.shadowColor = [UIColor blackColor].CGColor;
    _passField.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    _passField.layer.shadowRadius = 4;//阴影半径，默认3
    
    _phoneIcon.layer.shadowOffset = CGSizeMake(4, 5);
    _phoneIcon.layer.shadowColor = [UIColor blackColor].CGColor;
    _phoneIcon.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    _phoneIcon.layer.shadowRadius = 4;//阴影半径，默认3
    
    _passIcon.layer.shadowOffset = CGSizeMake(4, 5);
    _passIcon.layer.shadowColor = [UIColor blackColor].CGColor;
    _passIcon.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    _passIcon.layer.shadowRadius = 4;//阴影半径，默认3
    
    
    _phoneField.delegate=self;
    [_phoneField setValue:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    //_phoneField.keyboardType=UIKeyboardTypeNumberPad;
    _phoneField.textColor=[UIColor whiteColor];
    _phoneField.font = [UIFont fontWithName:@"ArialMT" size:17];
    
    _passField.delegate=self;
    [_passField setValue:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_passField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    //_phoneField.keyboardType=UIKeyboardTypeNumberPad;
    _passField.textColor=[UIColor whiteColor];
    _passField.font = [UIFont fontWithName:@"ArialMT" size:17];
    
    
    
    UIImageView *hBg=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4,SCREEN_HEIGHT/2-SCREEN_WIDTH/2-70,SCREEN_WIDTH/2,SCREEN_WIDTH/2)];
    [hBg setContentMode:UIViewContentModeScaleAspectFit];
    // hBg.backgroundColor=[UIColor blackColor];
    [hBg setImage:[UIImage imageNamed:@"gsgsIcon.png"]];
    hBg.layer.shadowOffset = CGSizeMake(4, 5);
    hBg.layer.shadowColor = [UIColor blackColor].CGColor;
    hBg.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    hBg.layer.shadowRadius = 4;//阴影半径，默认3
    [self.view addSubview:hBg];
    
    
    UIButton *loginBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame=CGRectMake(35, SCREEN_HEIGHT/2+86+80*(SCREEN_WIDTH/320), SCREEN_WIDTH-70, (SCREEN_WIDTH-70)*pro);
    [loginBtn setBackgroundColor:RGBCOLOR(0, 158, 221)];
    loginBtn.layer.masksToBounds=YES;
    loginBtn.layer.cornerRadius=6;
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:22];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"登   录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [self hiddenBackBtn];
    
}
- (void)login:(UIButton *)btn{
    if (_phoneField.text.length>0) {
        if (_passField.text.length>0) {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            // [dict setObject:[[NSString stringWithFormat:@"%@", _phoneField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"username"];
            [dict setObject:_phoneField.text  forKey:@"username"];
            [dict setObject:_passField.text forKey:@"password"];
            AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
            manger.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            manger.requestSerializer.timeoutInterval = 20.f;
            [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            [SVProgressHUD showWithStatus:@"登录中..."  maskType:SVProgressHUDMaskTypeGradient];
            
            
            
//            [manger POST:[NSString stringWithFormat:URLHOST,@"appLogin/login"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"-----%@",dic);
//            if ([dic[@"success"] intValue]==1) {
//                [self dismissViewControllerAnimated:YES completion:^{
//
//                    [SVProgressHUD showSuccessWithStatus:@"登录成功！"];
//                    NSMutableDictionary *user=[[NSMutableDictionary alloc]init];
//                    user=[dic[@"list"][0] mutableCopy];
//                    [[DataDefault shareInstance]setUserInfor:user];
//
//                    if ([user[@"sign"] length]==0) {
//                        if (self.checkSignImage) {
//                            self.checkSignImage();
//                        }
//                    }
//                }];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"登录失败！"];
//            }
//
//            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//                [SVProgressHUD showErrorWithStatus:@"登录失败！"];
//            }];
            
            
            
            
            
            [manger GET:[NSString stringWithFormat:URLHOST,@"appLogin/login"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                //NSLog(@"-----%@",dic);
                if ([dic[@"success"] intValue]==1) {
                    [self dismissViewControllerAnimated:YES completion:^{

                        [SVProgressHUD showSuccessWithStatus:@"登录成功！"];
                        NSMutableDictionary *user=[[NSMutableDictionary alloc]init];
                        user=[dic[@"list"][0] mutableCopy];
                        [[DataDefault shareInstance]setUserInfor:user];

                        if ([user[@"sign"] length]==0) {
                            if (self.checkSignImage) {
                                self.checkSignImage();
                            }
                        }else{
                            if (self.loginSuccess) {
                                self.loginSuccess(user);
                            }
                        }
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"登录失败！"];
                }

            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                [SVProgressHUD showErrorWithStatus:@"登录失败！"];
                NSLog(@"-----%@",error);

            }];
            

        }else{
            [SVProgressHUD showErrorWithStatus:@"密码不能为空！"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空！"];
    }
}

#pragma mark -PassWoed TextField Editing

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat offset=_accountView.frame.origin.y-_h;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame=_accountView.frame;
        frame.origin.y=offset;
        _accountView.frame=frame;
    }];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    CGFloat offset=_accountView.frame.origin.y+_h;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame=_accountView.frame;
        frame.origin.y=offset;
        _accountView.frame=frame;
    }];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
