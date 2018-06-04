//
//  PersonalController.m
//  DingEr
//
//  Created by Tcy on 2018/4/13.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "PersonalController.h"
#import "MYDrawView.h"

@interface PersonalController ()<UITextFieldDelegate>{
    
    UIScrollView *_scroller;
    BOOL isEdit;
    CGFloat fW;
    NSMutableDictionary *_userDic;
}

@property (nonatomic ) CGFloat pro;
@property (nonatomic ) UIView *nameView;
@property (nonatomic ) UILabel *name;
@property (nonatomic ) UILabel *nameIcon;
@property (nonatomic ) UIButton *chBtn;

@property (strong, nonatomic) IBOutlet UIView *InfoView;
@property (strong, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *mail;
@property (weak, nonatomic) IBOutlet UILabel *remind;
@property (weak, nonatomic) IBOutlet UIImageView *signImage;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UILabel *unityLab;

@property (strong, nonatomic) IBOutlet UIView *signView;
@property (weak, nonatomic) IBOutlet MYDrawView *drawView;




@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setPageTitle:@"个人信息"];
    isEdit=NO;
}
- (void)viewWillAppear:(BOOL)animated{
    _userDic=[[NSMutableDictionary alloc]init];
    _userDic=[[[DataDefault shareInstance]userInfor] mutableCopy];
    [self createUI];

}

- (void)createUI{
    

    
    fW=(SCREEN_WIDTH>320)?90:86;
    CGFloat infHig=(SCREEN_WIDTH-76)*200/343+325;
    
    _nameView=[[UIView alloc]init];
    _nameView.frame=CGRectMake(0, 70, SCREEN_WIDTH, 80);
    _nameView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_nameView];
    
    _nameIcon=[[UILabel alloc]initWithFrame:CGRectMake(35, 10, 60, 60)];
    _nameIcon.layer.masksToBounds=YES;
    _nameIcon.layer.cornerRadius=30;
    _nameIcon.numberOfLines=0;
    _nameIcon.backgroundColor=RGBCOLOR(32, 143, 255);
    _nameIcon.textColor=[UIColor whiteColor];
    _nameIcon.font=[UIFont systemFontOfSize:16];
    _nameIcon.textAlignment=NSTextAlignmentCenter;
    
    NSString *string=_userDic[@"username"];
    
    
    
    
    
    
    
    NSString *str2 = [string substringFromIndex:(string.length-2)];
    _nameIcon.text=string;
    
    [_nameView addSubview:_nameIcon];
    
    _name=[[UILabel alloc]initWithFrame:CGRectMake(110, 0, 90, 80)];
    _name.textColor=RGBCOLOR(25, 25, 25);
    _name.textAlignment=NSTextAlignmentLeft;
    _name.font=[UIFont systemFontOfSize:20];
    _name.text=string;

    [_nameView addSubview:_name];
    
    _scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT-148-fW)];
    _scroller.layer.masksToBounds=YES;
    _scroller.layer.cornerRadius=2;
    _scroller.backgroundColor=RGBACOLOR(255, 255, 255,1);
    _scroller.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scroller];

    _InfoView.frame=CGRectMake(0, 0, SCREEN_WIDTH, infHig);
    [_scroller addSubview:_InfoView];
    _remind.hidden=NO;

    _footView.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
    [self.view addSubview:_footView];
    
    _scroller.contentSize=CGSizeMake(SCREEN_WIDTH-16, infHig);
    
    _chBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-8-55,120,55,30)];
    _chBtn.backgroundColor=[UIColor clearColor];
    [_chBtn setTitle:@"修改" forState:UIControlStateNormal];
    _chBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [_chBtn setTitleColor:RGBCOLOR(32, 143, 255) forState:UIControlStateNormal];
    [_chBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_chBtn addTarget:self action:@selector(ediInfor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_chBtn];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSignView)];
    _signImage.userInteractionEnabled=NO;
    [_signImage addGestureRecognizer:recognizer];
    


    
    UIColor *topleftColor = [UIColor colorWithRed:48/255.0f green:88/255.0f blue:123/255.0f alpha:1.0f];
    UIColor *bottomrightColor = [UIColor colorWithRed:58/255.0f green:62/255.0f blue:108/255.0f alpha:1.0f];
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(300, 100)];
    _signView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_HEIGHT, SCREEN_HEIGHT);
    [self.view addSubview:_signView];
    _signView.layer.contents = (id)bgImg.CGImage;
    
    _phone.enabled=NO;
    _mail.enabled=NO;
    _userName.enabled=NO;
    _remind.hidden=YES;
    _phone.delegate=self;
    _mail.delegate=self;
    _userName.delegate=self;
    
    switch ([_userDic[@"level"] intValue]) {
        case 1:
            _unityLab.text=[NSString stringWithFormat:@"所属单位:%@",_userDic[@"game"]];
            break;
        case 2:
            _unityLab.text=[NSString stringWithFormat:@"所属单位:%@",_userDic[@"part"]];
            break;
        case 3:
            _unityLab.text=[NSString stringWithFormat:@"所属单位:%@",_userDic[@"place"]];
            break;
        case 4:
            _unityLab.text=[NSString stringWithFormat:@"所属单位:%@",_userDic[@"station"]];
            break;
        default:
            break;
    }
    
    _userName.text=_userDic[@"name"];
    _mail.text=_userDic[@"email"];
    _phone.text=_userDic[@"phone"];
    
    if ([_userDic[@"sign"] rangeOfString:@".jpeg"].location == NSNotFound ) {
        NSData *decodedImageData = [[NSData alloc]
                                    initWithBase64EncodedString:_userDic[@"sign"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        _signImage.image=[UIImage imageWithData:decodedImageData];
    }else{
        NSData *decodedImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:ImageUrl,_userDic[@"sign"]]]];
        _signImage.image=[UIImage imageWithData:decodedImageData];
    }


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)showSignView{
    [UIView animateWithDuration:0.3 animations:^{
        _signView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {

    }];
}
- (void)ediInfor{
    if (!isEdit) {
        [UIView animateWithDuration:0.3 animations:^{
            _scroller.frame=CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT-70-fW);
            _chBtn.frame=CGRectMake(SCREEN_WIDTH-8-55,40,55,30);
        } completion:^(BOOL finished) {
            _phone.enabled=YES;
            _mail.enabled=YES;
            _userName.enabled=YES;
            _signImage.userInteractionEnabled=YES;
            _remind.hidden=NO;
            [_chBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_chBtn setTitle:@"完成" forState:UIControlStateNormal];
            isEdit=YES;
            _phone.backgroundColor=RGBACOLOR(210, 210, 210, 0.9);
            _mail.backgroundColor=RGBACOLOR(210, 210, 210, 0.9);
            _userName.backgroundColor=RGBACOLOR(210, 210, 210, 0.9);
        }];
        
    }else{
        [_phone resignFirstResponder];
        [_mail resignFirstResponder];
        [_userName resignFirstResponder];
        if ([_phone.text isMobileNumber]) {
            if ([_mail.text isEmailAddress]) {
                if (_userName.text.length>=2) {
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        _scroller.frame=CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT-150-fW);
                        _chBtn.frame=CGRectMake(SCREEN_WIDTH-8-55,120,55,30);
                        
                    } completion:^(BOOL finished) {
                        _phone.enabled=NO;
                        _mail.enabled=NO;
                        _userName.enabled=NO;
                        _signImage.userInteractionEnabled=NO;

                        _remind.hidden=YES;
                        [_chBtn setTitleColor:RGBCOLOR(32, 143, 255) forState:UIControlStateNormal];
                        [_chBtn setTitle:@"修改" forState:UIControlStateNormal];
                        isEdit=NO;
                        _phone.backgroundColor=[UIColor clearColor];
                        _mail.backgroundColor=[UIColor clearColor];
                        _userName.backgroundColor=[UIColor clearColor];

                        
                        [_userDic setValue: _userName.text forKey:@"name"];
                        [_userDic setValue: _mail.text forKey:@"email"];
                        [_userDic setValue: _phone.text forKey:@"phone"];
                        [[DataDefault shareInstance]setUserInfor:_userDic];
                        
                        
                        [self uploadUserInfor:_userDic];
                        
                        

                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请输入正确姓名！"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入正确邮箱！"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入正确电话！"];
        }
        
    }
}

- (IBAction)clear:(id)sender {
    [self.drawView clear];
    
}

- (IBAction)sureSign:(id)sender {
    NSData * imageData = UIImageJPEGRepresentation([self imageWithUIView:_drawView],1);
    float length = [imageData length]/1024;
    if (length>4) {
        [UIView animateWithDuration:0.3 animations:^{
            _signView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
           // NSString *encodedImageStr =[[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
            NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            

            [_userDic setValue:encodedImageStr forKey:@"sign"];
            
         //   [[DataDefault shareInstance]setSignImage:imageData];
            _signImage.image=[self imageWithUIView:_drawView];
            [self.drawView clear];
        
        }];
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"您还未签名"];
    }
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

- (void)uploadUserInfor:(NSMutableDictionary *)dict{
    [SVProgressHUD showWithStatus:@"个人信息保存中..."  maskType:SVProgressHUDMaskTypeGradient];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manger POST:[NSString stringWithFormat:URLHOST,@"appUser/updateUser"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      //  NSLog(@"%@",dic);
        if ([dic[@"success"] intValue]==1) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功！"];
         }else{
             [SVProgressHUD showErrorWithStatus:@"修改失败！"];
         }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"修改失败！"];
    }];
}


- (IBAction)logOut:(id)sender {
    if (isEdit) {
        [SVProgressHUD showErrorWithStatus:@"您的修改操作还未完成！"];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [[DataDefault shareInstance]setUserInfor:nil];
        if (self.actionlogOut) {
            self.actionlogOut();
        }
    }
}
- (void)back{
    if (isEdit) {
        [SVProgressHUD showErrorWithStatus:@"您还未保存修改"];

    }else{
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
