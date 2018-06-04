//
//  NewDeclearController.m
//  DingEr
//
//  Created by Tcy on 2018/4/20.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "NewDeclearController.h"
#import "DeclearController.h"
#import "EnclusureView.h"
#import "FormView.h"

#import "EquipModel.h"
#import "EquipCell.h"
#import "KindCell.h"

#import "PersonView.h"

#import "ContactController.h"



@interface NewDeclearController ()<UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    UITableView *_kdView;
    
    UIScrollView *_scroller;
    UIView *_bodyView;
    
    CGFloat scroHig,progressHig,fromHig,shenPHig;
    CGFloat enclusureHig,bodHig,secHig;
    
    NSMutableArray *_imageArr;//附件
    NSInteger _imageNum;//附件标示
    
    NSMutableArray *_equipArr;//上报设备
    NSMutableArray *_numArray;//上报数量
    
    NSMutableArray *_dataArray;//添加设备
    
    NSMutableArray *_perArray;//审批人
    
    NSMutableArray *_equipLib;//设备库
    
    BOOL isNoResult;
    
}
@property (strong, nonatomic) PersonView *shenPiView;
@property (strong, nonatomic) FormView *formView;
@property (strong, nonatomic) EnclusureView *enclusureView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footView;

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *seaField;
@property (weak, nonatomic) IBOutlet UIButton *seaBtn;

@property (weak, nonatomic) IBOutlet UILabel *unity;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *kind;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab
;
@property (weak, nonatomic) IBOutlet UILabel *titlab;
@property (weak, nonatomic) IBOutlet UILabel *kindLab;



@end

@implementation NewDeclearController
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
    _perArray=[[NSMutableArray alloc]init];//审批人
    
    _numArray=[[NSMutableArray alloc]init];//设备数量
    _dataArray=[[NSMutableArray alloc]init];//获取的设备
    
    _imageArr=[[NSMutableArray alloc]init];//附件
    _equipArr=[[NSMutableArray alloc]init];//已添加的设备
    _equipLib=[[NSMutableArray alloc]init];//设备库
    _imageNum=0;//附件标示
    secHig=50;//段头高度
    isNoResult=NO;

    [self createUI];
    [self createSearchView];
    [self prepareEquipLibeary];
}
- (void)prepareEquipLibeary{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:@"root" forKey:@"pid"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appCategory/showCategoryList"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"--%@",dic);
        
        
        [_equipLib removeAllObjects];
        NSArray *arr1=dic[0][@"children"];
        for (NSDictionary *dic1 in arr1) {
            NSArray *arr2=dic1[@"children"];
            if (arr2.count>0) {
                for (NSDictionary *dic2 in arr2) {
                    NSArray *arr3=dic2[@"children"];
                    if (arr3.count>0) {
                        for (NSDictionary *dic4 in arr3) {
                            NSArray *arr5=dic4[@"children"];
                            if (arr5.count>0) {
                                for (NSDictionary *dic6 in arr5) {
                                    NSArray *arr7=dic6[@"children"];
                                    if (arr7.count>0) {
                                        
                                    }else{
                                        [_equipLib addObject:dic6[@"name"]];
                                    }
                                }
                            }else{
                                [_equipLib addObject:dic4[@"name"]];
                            }
                        }
                    }else{
                        [_equipLib addObject:dic2[@"name"]];
                    }
                }
            }else{
                [_equipLib addObject:dic1[@"name"]];
            }
        }
        [_kdView reloadData];
        //if ([dic[0][@"code"] floatValue]==20000) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"设备分类获取失败！"];
    }];
    
}


- (void)createUI{
    __block NewDeclearController *blockSelf = self;
    
    CGFloat fW=(SCREEN_WIDTH>320)?90:86;
    
    enclusureHig=00+SCREEN_WIDTH/3;
    //enclusureHig=(SCREEN_WIDTH>320)?((SCREEN_WIDTH>375)?135:135*375/414):145*320/414;
    fromHig=165;
    shenPHig=10+SCREEN_WIDTH/4;
    //shenPHig=(SCREEN_WIDTH>320)?((SCREEN_WIDTH>375)?120:110):90;
    scroHig=SCREEN_HEIGHT-84-fW;
    bodHig=enclusureHig+fromHig+40+shenPHig;
    
    _footView.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
    [self.view addSubview:_footView];
    
    _scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(8, 84, SCREEN_WIDTH-16, scroHig)];
    _scroller.layer.masksToBounds=YES;
    _scroller.layer.cornerRadius=6;
    _scroller.contentSize=CGSizeMake(SCREEN_WIDTH-16, 230+bodHig);
    _scroller.backgroundColor=RGBACOLOR(222, 222, 222,0);
    _scroller.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scroller];
    
    _bodyView=[[UIView alloc]initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH-16,  bodHig)];
    _bodyView.backgroundColor=RGBCOLOR(250, 250, 250);
    _bodyView.layer.masksToBounds=NO;
    _bodyView.layer.cornerRadius=6;
    _bodyView.layer.shadowColor=[UIColor blackColor].CGColor;
    _bodyView.layer.shadowOffset=CGSizeMake(4, 5);
    _bodyView.layer.shadowOpacity=0.5;
    _bodyView.layer.shadowRadius=4.f;
    [_scroller addSubview:_bodyView];
    
    _headerView.frame=CGRectMake(0, 0, SCREEN_WIDTH-16, 210);
    _headerView.backgroundColor=RGBCOLOR(250, 250, 250);
    _headerView.layer.masksToBounds=NO;
    _headerView.layer.cornerRadius=6;
    _headerView.layer.shadowColor=[UIColor blackColor].CGColor;
    _headerView.layer.shadowOffset=CGSizeMake(4, 5);
    _headerView.layer.shadowOpacity=0.5;
    _headerView.layer.shadowRadius=4.f;
    [_scroller addSubview:_headerView];
    
    _formView=[[FormView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-16, fromHig)];
    _formView.backgroundColor=[UIColor clearColor];
    [_bodyView addSubview:_formView];
    [_formView setActionAddForm:^(NSInteger tag) {
        
        
        // [blockSelf addFormViewCell];
        
        [UIView animateWithDuration:0.3 animations:^{
            blockSelf.searchView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }];
    [_formView setActionCloseForm:^(NSInteger tag) {
        [_equipArr removeObjectAtIndex:tag];
        [self addFormViewCell:_equipArr];
    }];
    
    
    _enclusureView =[[EnclusureView alloc]initWithFrame:CGRectMake(0,fromHig+20, SCREEN_WIDTH-16, enclusureHig)];
    _enclusureView.backgroundColor=[UIColor clearColor];
    [_bodyView addSubview:_enclusureView];
    _enclusureView.isEdit=YES;
    [_imageArr addObject:[UIImage imageNamed:@"fujian.png"]];
    [_enclusureView updateWithImageArr:_imageArr];
    [_enclusureView setActionAddImage:^(NSInteger tag) {
        _imageNum=tag;
        
        [blockSelf showActSheet];
    }];
    
    _shenPiView =[[PersonView alloc]initWithFrame:CGRectMake(0,fromHig+15+enclusureHig, SCREEN_WIDTH-16, shenPHig)];
    _shenPiView.backgroundColor=[UIColor clearColor];
    [_bodyView addSubview:_shenPiView];
    _shenPiView.isEdit=YES;
    _shenPiView.title=@"审批人";
    [_shenPiView updateWithPersonArr:_perArray];
    [_shenPiView setActionAddPerson:^(NSInteger tag) {
        [blockSelf addOrminusPerson:tag];
    }];
}
- (void)addOrminusPerson:(NSInteger )tag{
    if (tag==0) {
        NSLog(@"添加审批人");
        ContactController *convc=[[ContactController alloc]init];
        convc.isPush=NO;
        [self.navigationController presentViewController:convc animated:YES completion:^{
            
        }];
        
        
    }else{
        [_perArray removeAllObjects];
        tag=0;
        [_shenPiView updateWithPersonArr:_perArray];
    }
    
}

- (void)addFormViewCell:(NSMutableArray *)arr{ 
    fromHig=165+arr.count*35;
    bodHig=enclusureHig+fromHig+40+shenPHig;
    _formView.frame=CGRectMake(0, 0, SCREEN_WIDTH-16, fromHig);
    _bodyView.frame=CGRectMake(0, 220, SCREEN_WIDTH-16,  bodHig);
    _scroller.contentSize=CGSizeMake(SCREEN_WIDTH-16, 230+bodHig);
    _enclusureView.frame=CGRectMake(0,fromHig+20, SCREEN_WIDTH-16, enclusureHig);
    _shenPiView.frame=CGRectMake(0,fromHig+15+enclusureHig, SCREEN_WIDTH-16, shenPHig);
    
    [_formView updateWithImageArr:arr];
}

- (void)createSearchView{
    _searchView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:_searchView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(16, 170, SCREEN_WIDTH-32, SCREEN_HEIGHT-175) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.layer.masksToBounds=YES;
    _tableView.layer.cornerRadius=6;
    _tableView.showsVerticalScrollIndicator=NO;
    // _tableView.backgroundColor=RGBCOLOR(199, 199, 199);
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_searchView addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"EquipCell" bundle:nil] forCellReuseIdentifier:@"EquipCell"];//xib定制cell
    _seaField.delegate=self;
    
    _kdView = [[UITableView alloc] initWithFrame:CGRectMake(16, 123, SCREEN_WIDTH-32, 0) style:UITableViewStylePlain];
    _kdView.dataSource = self;
    _kdView.delegate = self;
    _kdView.bounces = NO;

    _kdView.layer.masksToBounds=YES;
    _kdView.layer.cornerRadius=6;
    _kdView.showsVerticalScrollIndicator=NO;
    // _tableView.backgroundColor=RGBCOLOR(199, 199, 199);
    _kdView.backgroundColor=[UIColor clearColor];
    _kdView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_searchView addSubview:_kdView];
    [_kdView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_kdView registerNib:[UINib nibWithNibName:@"KindCell" bundle:nil] forCellReuseIdentifier:@"KindCell"];//xib定制cell
    
}

#pragma mark TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==_kdView) {
        return nil;
    }else{
        UIView *secView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-32, secHig)];
        secView.backgroundColor=RGBCOLOR(10, 143, 255);
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-123-32, 0, 1, secHig)];
        line.backgroundColor=RGBCOLOR(92, 94, 102);
        [secView addSubview:line];
        
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 123, secHig)];
        lab1.text=@"设备名称";
        lab1.textColor=[UIColor whiteColor];
        lab1.textAlignment=NSTextAlignmentLeft;
        [secView addSubview:lab1];
        
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-123-31, 0, 123, secHig)];
        lab2.text=@"数量";
        lab2.textColor=[UIColor whiteColor];
        lab2.textAlignment=NSTextAlignmentCenter;
        [secView addSubview:lab2];
        
        return secView;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==_kdView) {
        return 0.0001;
    }else{
        return secHig;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==_kdView) {
        return 1;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // return [_dataArray count];
    if (tableView==_kdView) {
        return [_equipLib count];
    }else{
        if (isNoResult) {
            return 1;
            
        }else{
            return 20;
            
        }
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    /*
     EquipModel *model=[[EquipModel alloc]init];
     [model setValue:_dateArray[indexPath.row] forKey:@"name"];
     [model setValue:_numArray[indexPath.row] forKey:@"num"];
     [_equipArr addObject:model];
     [self addFormViewCell:_equipArr];
     
     [_dateArray removeAllObjects];
     [_numArray removeAllObjects];
     [_tableView reloadData];
     _seaField.text=nil;
     
     
     */
    if (tableView==_kdView) {
        [UIView animateWithDuration:0.3 animations:^{
            _kdView.frame=CGRectMake(16, 123, SCREEN_WIDTH-32, 0);
        } completion:^(BOOL finished) {
            _kindLab.text=_equipLib[indexPath.row];
        }];
    }else{
        if(isNoResult){
            
        }else{
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您选择添加XX设备xx件事否确定" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *calAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [_equipArr addObject:@"d"];
                [self addFormViewCell:_equipArr];
                [UIView animateWithDuration:0.3 animations:^{
                    _searchView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                }];
            }];
            [alertController addAction:calAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_kdView) {
        
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
        cell.nameLab.text=_equipLib[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        if(isNoResult){
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.textLabel.text=@"没有搜索到相关设备";
            cell.backgroundColor=RGBCOLOR(255, 255, 255);
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
            EquipCell *cell=[tableView dequeueReusableCellWithIdentifier:@"EquipCell"];
            cell.backgroundColor=RGBCOLOR(255, 255, 255);
            
            //        if (indexPath.row%2==0) {
            //            cell.backgroundColor=RGBCOLOR(255, 255, 255);
            //            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            //
            //        }else{
            //            cell.backgroundColor=RGBCOLOR(199, 199, 199);
            //            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            //
            //        }
            [cell setChangeNumAction:^(NSInteger sig) {
                NSLog(@"%ld,%ld",(long)sig,(long)indexPath.row);
                
                //  [ _numArray replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%ld",(long)sig]];
                
            }];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_kdView) {
        return 50;
    }else{
        return 60;
    }
}

- (IBAction)showListMenu:(id)sender {
    if (_kdView.frame.size.height==0) {
        [UIView animateWithDuration:0.3 animations:^{
            _kdView.frame=CGRectMake(16, 124, SCREEN_WIDTH-32, 200);

        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            _kdView.frame=CGRectMake(16, 123, SCREEN_WIDTH-32, 0);
            
        }];
    }
}


- (IBAction)seachEquip:(id)sender {
    
    
}

- (IBAction)cancleSearch:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _searchView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        _seaField.text=nil;
    }];
    
}

- (void)loadData:(NSMutableDictionary *)dict{
    
    
    [dict setObject:[NSString timeStr] forKey:@"time"];
    [dict setObject:[[DataDefault shareInstance]userInfor][@"token"] forKey:@"token"];
    [dict setObject:[NSString signStrWithToken:[[DataDefault shareInstance]userInfor][@"token"] tim:[NSString timeStr]] forKey:@"sign"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer setValue:@"android_client_sxphone_app" forHTTPHeaderField:@"User-Agent"];
    [manger.requestSerializer setValue:@"www.dfec.com" forHTTPHeaderField:@"Host"];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:WarnUrl parameters:dict success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [_dataArray removeAllObjects];
        
        // NSLog(@"--%@",dic);
        if ([dic[0][@"code"] floatValue]==20000) {
            for (NSDictionary *dict in dic[1]) {
                [_dataArray addObject:dict];
            }
            [_tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[0][@"msg"]];
        }
        
        [_tableView headerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [_tableView headerEndRefreshing];
        [SVProgressHUD showErrorWithStatus:@"请求失败！"];
        
    }];
}



- (IBAction)upLoad:(id)sender {
    if (_isChange) {
        [self.navigationController popViewControllerAnimated:YES];
        if (self.changeDeclearAction) {
            self.changeDeclearAction();
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    [_enclusureView updateWithImageArr:_imageArr];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
