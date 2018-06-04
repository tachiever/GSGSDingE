//
//  SQController.m
//  DingEr
//
//  Created by Tcy on 2018/5/10.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "SQController.h"
#import "KindCell.h"
#import "EnclusureView.h"
#import "DeclearController.h"

@interface SQController ()<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIScrollView *_scroller;
    
    CGFloat fW,kHig,fujianHig;
    NSInteger _imageNum;
    
    NSMutableArray *_imageArr;
}

@property (strong, nonatomic) IBOutlet UIView *inPut;
@property (weak, nonatomic) IBOutlet UILabel *iconTitle;
@property (weak, nonatomic) IBOutlet UILabel *titlab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *unity;
@property (weak, nonatomic) IBOutlet UITextField *placeField;
@property (weak, nonatomic) IBOutlet UITextField *numField;
@property (weak, nonatomic) IBOutlet UITextView *pheno;
@property (weak, nonatomic) IBOutlet UITextView *solution;
@property (strong, nonatomic) IBOutlet UIView *footView;
@property (strong, nonatomic) EnclusureView *fujianView;

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation SQController
- (UIImagePickerController *)imagePicker{
    if (nil == _imagePicker) {
        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
        {
            self.navigationController.navigationBar.translucent = NO;
        }
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.modalPresentationStyle = UIModalPresentationCustom;
        
        _imagePicker.view.backgroundColor = [UIColor whiteColor];
        [_imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"photoHeader.png"] forBarMetrics:UIBarMetricsDefault];
        _imagePicker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
        [[UINavigationBar appearance] setTintColor:RGBCOLOR(255, 255, 255)];
        
        
        //  _imagePicker.navigationBar.backgroundColor=RGBCOLOR(48, 88, 123);
    }
    return _imagePicker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isChange) {
        [self setPageTitle:@"修改申请"];
        
    }else{
        [self setPageTitle:@"申请"];
        
    }
    
    _imageArr=[NSMutableArray new];
    [self createPageUI];
    _imageNum=0;
    NSLog(@"%@----%@",_user[@"station"],_user[@"deptid"]);
}

- (void)createPageUI{
    __block SQController *blockSelf = self;
    
    fW=(SCREEN_WIDTH>320)?80:76;
    kHig=(SCREEN_WIDTH>320)?((SCREEN_WIDTH>375)?145:150):156;
    fujianHig=14+SCREEN_WIDTH/3;
    
    
    _scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW)];
    _scroller.contentSize=CGSizeMake(0, 658+fujianHig);
    _scroller.backgroundColor=RGBACOLOR(245, 245, 245,1);
    _scroller.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scroller];
    
    _inPut.frame=CGRectMake(0, 0, SCREEN_WIDTH, 640);
    [_scroller addSubview:_inPut];
    
    _numField.enabled=NO;
    _numField.text=[NSString nowTimeStyle4];
    
    _fujianView =[[EnclusureView alloc]initWithFrame:CGRectMake(0,656, SCREEN_WIDTH, fujianHig)];
    _fujianView.backgroundColor=[UIColor whiteColor];
    [_scroller addSubview:_fujianView];
    _fujianView.isEdit=YES;
    [_imageArr addObject:[UIImage imageNamed:@"fujian.png"]];
    [_fujianView updateWithImageArr:_imageArr];
    [_fujianView setActionAddImage:^(NSInteger tag) {
        _imageNum=tag;
        
        [blockSelf showActSheet];
    }];
    
    
    
    _unity.layer.masksToBounds=YES;
    _unity.layer.cornerRadius=4;
    _unity.layer.borderWidth=1;
    _unity.layer.borderColor=RGBACOLOR(240, 240, 240, 1).CGColor;
    
    
    _footView.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
    [self.view addSubview:_footView];
    
    _placeField.delegate=self;
    _numField.delegate=self;
    _pheno.delegate=self;
    _solution.delegate=self;
    
    if (!_isChange) {
        _pheno.text=@"请对故障现象进行描述";
        _pheno.textColor=[UIColor grayColor];
        _solution.text=@"请对服务需求进行描述";
        _solution.textColor=[UIColor grayColor];
        _titlab.text=[NSString stringWithFormat:@"%@维护申请",_user[@"station"]];
        _iconTitle.text=_user[@"station"];
        _unity.text=_user[@"place"];
    }else{
        
        _pheno.text=_infor[@"machine_state"];
        _pheno.textColor=[UIColor blackColor];
        _solution.text=_infor[@"servicing"];
        _solution.textColor=[UIColor blackColor];
        _titlab.text=[NSString stringWithFormat:@"%@维护申请",_infor[@"customer"]];
        _iconTitle.text=_infor[@"customer"];
        _unity.text=_infor[@"station_name"];
        _placeField.text=_infor[@"service_address"];
        _numField.text=_infor[@"code"];
    }
}


- (IBAction)uploadClear:(id)sender {
    if (_placeField.text.length>2) {
        if (_numField.text.length>2) {
            if (_pheno.text.length>3) {
                if (_solution.text.length>3) {
                    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                    [dict setValue:_user[@"id"] forKey:@"loginid"];
                    [dict setValue:_user[@"username"] forKey:@"loginname"];
                    if (!_isChange) {
                        [dict setValue:@"" forKey:@"id"];
                    }else{
                        [dict setValue:_infor[@"id"] forKey:@"id"];
                    }
                    [dict setValue:_user[@"place"] forKey:@"stationName"];
                    [dict setValue:_user[@"station"] forKey:@"userName"];
                    [dict setValue:_user[@"deptid"] forKey:@"userId"];
                    [dict setValue:_placeField.text forKey:@"lcationName"];
                    [dict setValue:_numField.text forKey:@"code"];
                    [dict setValue:_pheno.text forKey:@"fault"];
                    [dict setValue:_solution.text forKey:@"service"];
                    [self uploadData:dict];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"服务需求描述过短！"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"故障现象描述过短！"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"编号过短！"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"服务地点描述过短！"];
    }
}
- (void)uploadData:(NSMutableDictionary *)dict{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/saveOrUpdate"] parameters:dict success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"--%@",dict);
        if ([dict[@"success"] integerValue]==1) {
            if (!_isChange) {
                [SVProgressHUD showSuccessWithStatus:@"发送成功！"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"修改成功！"];
                [self.navigationController popViewControllerAnimated:YES];
                if (self.successChange) {
                    self.successChange();
                }
            }
        }else{
            if (!_isChange) {
                [SVProgressHUD showErrorWithStatus:@"发送失败！"];
            }else{
                
                [SVProgressHUD showErrorWithStatus:@"修改失败！"];
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (!_isChange) {
            [SVProgressHUD showErrorWithStatus:@"发送失败！"];
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"修改失败！"];
        }
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (_scroller.frame.size.height!=SCREEN_HEIGHT-74-fW) {
        _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
        
    }
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView==_pheno) {
        if([_pheno.text isEqualToString:@"请对故障现象进行描述"]){
            _pheno.text=@"";
            _pheno.textColor=[UIColor blackColor];
        }
        _scroller.contentOffset=CGPointMake(0, 506-(SCREEN_HEIGHT-74-fW-kHig));
        
    }
    if (textView==_solution) {
        if([_solution.text isEqualToString:@"请对服务需求进行描述"]){
            _solution.text=@"";
            _solution.textColor=[UIColor blackColor];
        }
        _scroller.contentOffset=CGPointMake(0, 640-(SCREEN_HEIGHT-74-fW-kHig));
        
    }
    if (_scroller.frame.size.height!=SCREEN_HEIGHT-74-fW-kHig) {
        [UIView animateWithDuration:0.3 animations:^{
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW-kHig);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(_pheno.text.length < 1){
        _pheno.text = @"请对故障现象进行描述";
        _pheno.textColor = [UIColor lightGrayColor];
        
    }
    if(_solution.text.length < 1){
        _solution.text = @"请对服务需求进行描述";
        _solution.textColor = [UIColor lightGrayColor];
    }
    if (_scroller.frame.size.height!=SCREEN_HEIGHT-74-fW) {
        _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
        
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if (_scroller.frame.size.height!=SCREEN_HEIGHT-74-fW) {
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
            
        }
        return NO;
    }
    return YES;
}
- (void)showActSheet{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"添加附件图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    
    [mediaTypes addObject:( NSString *)kUTTypeImage];
    
    [mediaTypes addObject:( NSString *)kUTTypeMovie];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册选取" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePicker.mediaTypes = [NSArray arrayWithObject:mediaTypes[0]];//设置媒体类型为public.image
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        } else {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在iPhone的“设置-隐私”选项中，允许访问您的相册。" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        BOOL hasPermission = YES;
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
            hasPermission = NO;
        }
        if (!hasPermission) {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在iPhone的“设置-隐私”选项中，允许访问您的相机。" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        } else {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePicker.mediaTypes =[NSArray arrayWithObject:mediaTypes[0]];//设置媒体类型为public.image
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:self.imagePicker animated:YES completion:nil];
            } else {
                NSLog(@"camera is no available!");
            }
        }
        
    }];
    
    [alertC addAction:action0];
    [alertC addAction:action1];
    [alertC addAction:action2];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *simpleImg = [UIImage simpleImage:orgImage];
    
    [_imageArr replaceObjectAtIndex:_imageNum withObject:simpleImg];
    if (_imageArr.count<3) {
        [_imageArr addObject:[UIImage imageNamed:@"fujian.png"]];
    }
    [_fujianView updateWithImageArr:_imageArr];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
