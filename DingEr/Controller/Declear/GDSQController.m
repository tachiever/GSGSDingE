//
//  GDSQController.m
//  DingEr
//
//  Created by Tcy on 2018/5/11.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "GDSQController.h"
#import "KindCell.h"

@interface GDSQController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIScrollView *_scroller;
    CGFloat fW,kHig;
    UITableView *_kdView;
    NSMutableArray *_optionArr;
    NSInteger tag;
}
@property (strong, nonatomic) IBOutlet UIView *evaView;
@property (weak, nonatomic) IBOutlet UILabel *jieguo;
@property (weak, nonatomic) IBOutlet UILabel *jishixing;
@property (weak, nonatomic) IBOutlet UILabel *taidu;
@property (weak, nonatomic) IBOutlet UILabel *zhiliang;
@property (weak, nonatomic) IBOutlet UILabel *shuiping;
@property (weak, nonatomic) IBOutlet UILabel *xiaoguo;


@property (weak, nonatomic) IBOutlet UITextView *wenti;
@property (weak, nonatomic) IBOutlet UITextView *yijian;
@property (weak, nonatomic) IBOutlet UILabel *xiangyincha;
@property (weak, nonatomic) IBOutlet UILabel *xiufucha;


@property (strong, nonatomic) IBOutlet UIView *footView;
@end

@implementation GDSQController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPageTitle:@"评价"];
    [self prepareDate];
    [self createPageUI];
}
- (void)prepareDate{
    tag=0;
    NSArray *arr=@[@[@"  已解决",@"  未解决"],
                   @[@"  好",@"  较好",@"  一般",@"  差"],
                   @[@"  好",@"  较好",@"  一般",@"  差"],
                   @[@"  好",@"  较好",@"  一般",@"  差"],
                   @[@"  好",@"  较好",@"  一般",@"  差"],
                   @[@"  好",@"  较好",@"  一般",@"  差"]];
    _optionArr=[NSMutableArray new];
    [_optionArr addObjectsFromArray:arr];
    
}
- (void)createPageUI{
    fW=(SCREEN_WIDTH>320)?80:76;
    kHig=(SCREEN_WIDTH>320)?((SCREEN_WIDTH>375)?145:150):156;
    
    _scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW)];
    _scroller.backgroundColor=RGBACOLOR(245, 245, 245,1);
    _scroller.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scroller];
    _scroller.contentSize=CGSizeMake(0, 600);
    
    _footView.frame=CGRectMake(0, SCREEN_HEIGHT-fW, SCREEN_WIDTH, fW);
    [self.view addSubview:_footView];
    
    _evaView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 600);
    [_scroller addSubview:_evaView];
    
    _wenti.delegate=self;
    _yijian.delegate=self;
    _jieguo.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    _jishixing.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    _taidu.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    _zhiliang.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    _shuiping.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    _xiaoguo.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    _xiangyincha.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    _xiufucha.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    _wenti.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    _yijian.layer.borderColor=RGBCOLOR(240, 240, 240).CGColor;
    
    _wenti.text = @"遗留问题";
    _wenti.textColor = [UIColor lightGrayColor];
    
    _yijian.text = @"其他意见";
    _yijian.textColor = [UIColor lightGrayColor];
    
    _kdView = [[UITableView alloc] initWithFrame:CGRectMake(104, 38,_jieguo.frame.size.width, 0) style:UITableViewStylePlain];
    _kdView.dataSource = self;
    _kdView.delegate = self;
    _kdView.bounces = NO;
    
    _kdView.layer.masksToBounds=YES;
    _kdView.layer.cornerRadius=6;
    _kdView.showsVerticalScrollIndicator=NO;
    // _tableView.backgroundColor=RGBCOLOR(199, 199, 199);
    _kdView.backgroundColor=[UIColor clearColor];
    _kdView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_evaView addSubview:_kdView];
    [_kdView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_kdView registerNib:[UINib nibWithNibName:@"KindCell" bundle:nil] forCellReuseIdentifier:@"KindCell"];//xib定制cell
    _xiangyincha.text=_infor[@"respond_time"];
    _xiufucha.text=_infor[@"repairt_time"];
    
}


#pragma mark TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_optionArr[tag] count];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [UIView animateWithDuration:0.3 animations:^{
        _kdView.frame=CGRectMake(104, 38+tag*43,_jieguo.frame.size.width, 0);
    } completion:^(BOOL finished) {
        if (tag==0) {
            _jieguo.text=_optionArr[tag][indexPath.row];
        }
        if (tag==1) {
            _jishixing.text=_optionArr[tag][indexPath.row];
        }
        if (tag==2) {
            _taidu.text=_optionArr[tag][indexPath.row];
        }
        if (tag==3) {
            _zhiliang.text=_optionArr[tag][indexPath.row];
        }
        if (tag==4) {
            _shuiping.text=_optionArr[tag][indexPath.row];
        }
        if (tag==5) {
            _xiaoguo.text=_optionArr[tag][indexPath.row];
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KindCell *cell=[tableView dequeueReusableCellWithIdentifier:@"KindCell"];
    cell.backgroundColor=RGBCOLOR(255, 255, 255);
    
    //        if (indexPath.row%2==0) {
    //            cell.backgroundColor=RGBCOLOR(255, 255, 255);
    //            cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //
    //        }else{
    cell.backgroundColor=RGBCOLOR(250, 250, 250);
    //            cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //
    //        }
    cell.nameLab.text=_optionArr[tag][indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (IBAction)chooseSelect:(UIButton *)sender {
    NSLog(@"%li",(long)sender.tag);
    CGFloat hig;
    if (sender.tag==0) {
        hig=100;
    }else{
        hig=200;
        
    }
    if (sender.tag==tag) {
        
        if (_kdView.frame.size.height>0) {
            [UIView animateWithDuration:0.3 animations:^{
                _kdView.frame=CGRectMake(104, 38+sender.tag*43,_jieguo.frame.size.width, 0);
            } completion:^(BOOL finished) {
                //_kindLab.text=_optionArr[indexPath.row];
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                _kdView.frame=CGRectMake(104, 38+sender.tag*43,_jieguo.frame.size.width, hig);
            } completion:^(BOOL finished) {
                //_kindLab.text=_optionArr[indexPath.row];
            }];
        }
    }else{
        
        if (_kdView.frame.size.height>0) {
            
            [UIView animateWithDuration:0.2 animations:^{
                _kdView.frame=CGRectMake(104,_kdView.frame.origin.y+30,_jieguo.frame.size.width, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.0 animations:^{
                    _kdView.frame=CGRectMake(104, 38+sender.tag*43,_jieguo.frame.size.width, 0);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        _kdView.frame=CGRectMake(104, 38+sender.tag*43,_jieguo.frame.size.width, hig);
                    } completion:^(BOOL finished) {
                        
                    }];
                }];
            }];
        }else{
            [UIView animateWithDuration:0.0 animations:^{
                _kdView.frame=CGRectMake(104, 38+sender.tag*43,_jieguo.frame.size.width, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    _kdView.frame=CGRectMake(104, 38+sender.tag*43,_jieguo.frame.size.width, hig);
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }
        tag=sender.tag;
        [_kdView reloadData];
    }
}


- (IBAction)upload:(id)sender {
    
    if (![_jieguo.text isEqualToString:@"请选择"]) {
        if (![_jishixing.text isEqualToString:@"请选择"]) {
            if (![_taidu.text isEqualToString:@"请选择"]) {
                if (![_zhiliang.text isEqualToString:@"请选择"]) {
                    if (![_shuiping.text isEqualToString:@"请选择"]) {
                        if (![_xiaoguo.text isEqualToString:@"请选择"]) {
                            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                            [dict setValue:_user[@"id"] forKey:@"loginid"];
                            [dict setValue:_user[@"username"] forKey:@"loginname"];
                            [dict setValue:_infor[@"id"] forKey:@"id"];
                            [dict setValue:_jieguo.text forKey:@"serviceResult"];
                            [dict setValue:_jishixing.text forKey:@"timliness"];
                            [dict setValue:_taidu.text forKey:@"serviceAttitude"];
                            [dict setValue:_zhiliang.text forKey:@"serviceQuality"];
                            [dict setValue:_shuiping.text forKey:@"techStandard"];
                            [dict setValue:_xiaoguo.text forKey:@"serviceEffect"];
                            
                            if (![_wenti.text isEqualToString:@"遗留问题"]) {
                                [dict setValue:_wenti.text forKey:@"reasons"];
                            }else{
                                [dict setValue:@"" forKey:@"reasons"];
                            }
                            if(![_yijian.text isEqualToString:@"其他意见"]){
                                [dict setValue:_yijian.text forKey:@"customerView"];
                            }else{
                                [dict setValue:@"" forKey:@"customerView"];
                            }
                            [dict setValue:_user[@"station"] forKey:@"station"];
                            [self uploadeEvalaute:dict];
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"请评价维护效果！"];
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"请评价技术水平！"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请评价维护质量！"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请评价服务态度！"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请评价及时性！"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请评价维护结果！"];
    }
}

- (void)uploadeEvalaute:(NSMutableDictionary *)dic{
    
    
    NSLog(@"----%@",dic);
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/updateEva"] parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"--%@",dic);
        
        if (dic.count>0) {
            [self.navigationController popViewControllerAnimated:YES];
            if (self.finishedEvlaution) {
                self.finishedEvlaution();
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"评价失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"评价失败！"];
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    //_scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
    
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_scroller.frame.size.height!=SCREEN_HEIGHT-74-fW-kHig) {
        [UIView animateWithDuration:0.3 animations:^{
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW-kHig);
        } completion:^(BOOL finished) {
            
        }];
    }
    if (textView==_wenti) {
        if([_wenti.text isEqualToString:@"遗留问题"]){
            _wenti.text=@"";
            _wenti.textColor=[UIColor blackColor];
        }
        _scroller.contentOffset=CGPointMake(0, 506-(SCREEN_HEIGHT-74-fW-kHig));
        
    }
    if (textView==_yijian ) {
        if([_yijian.text isEqualToString:@"其他意见"]){
            _yijian.text=@"";
            _yijian.textColor=[UIColor blackColor];
        }
        _scroller.contentOffset=CGPointMake(0, 620-(SCREEN_HEIGHT-74-fW-kHig));
        
    }
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(_wenti.text.length < 1){
        _wenti.text = @"遗留问题";
        _wenti.textColor = [UIColor lightGrayColor];
        
    }
    if(_yijian.text.length < 1){
        _yijian.text = @"其他意见";
        _yijian.textColor = [UIColor lightGrayColor];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
