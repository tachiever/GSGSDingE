//
//  MainPageViewController.m
//  DingEr
//
//  Created by Tcy on 2018/4/10.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "MainPageViewController.h"
#import "IconView.h"
#import "IconBtn.h"

#import "MianDaibanCell.h"

#import "LoginController.h"
#import "PersonalController.h"
#import "DaiBanController.h"
#import "DeclearController.h"
#import "ContactController.h"

#import "SignController.h"
#import "MYDrawView.h"

#import "DBListController.h"


@interface MainPageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    UILabel *_mindLab;
    UIImage *bgImg;
    NSMutableDictionary *_user;
    NSMutableArray *_dataArr;
}

@property (strong, nonatomic)  IconView *daiBan;
@property (strong, nonatomic)  IconView *shenQing;
@property (strong, nonatomic)  IconView *shenPi;
@property (strong, nonatomic)  IconView *baoBiao;
@property (strong, nonatomic)  IconView *pinJia;
@property (strong, nonatomic)  IconView *me;
@property (strong, nonatomic)  IconView *zuZhi;

@property (strong, nonatomic)  UIView *menuView;

@property (strong, nonatomic)  IconBtn *mindBtn;

@property (strong, nonatomic) IBOutlet UIView *signView;
@property (weak, nonatomic) IBOutlet MYDrawView *drawView;




@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
//    UIColor *topleftColor = [UIColor colorWithRed:210/255.0f green:227/255.0f blue:255/255.0f alpha:1.0f];
//    UIColor *bottomrightColor = [UIColor colorWithRed:210/255.0f green:227/255.0f blue:255/255.0f alpha:1.0f];
//    UIColor *topleftColor = [UIColor colorWithRed:48/255.0f green:88/255.0f blue:123/255.0f alpha:1.0f];
//    UIColor *bottomrightColor = [UIColor colorWithRed:58/255.0f green:62/255.0f blue:108/255.0f alpha:1.0f];
//    bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(300, 100)];
//    self.view.layer.contents = (id)bgImg.CGImage;
    
    self.view.backgroundColor=RGBCOLOR(190, 230, 245);
    
    _user=[[NSMutableDictionary alloc]init];
    _dataArr=[[NSMutableArray alloc]init];
    [self createPage];

    if ([[DataDefault shareInstance]userInfor]==nil) {
        LoginController *lvc=[[LoginController alloc]init];
        [self presentViewController:lvc animated:YES completion:^{
            
        }];
        [lvc setLoginSuccess:^(NSMutableDictionary *userInfo) {
            _user=[userInfo mutableCopy];
            [self getMassageList:_user];
        }];
        
        [lvc setCheckSignImage:^() {
            _signView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_HEIGHT, SCREEN_HEIGHT);
            [self.view addSubview:_signView];
            _signView.layer.contents = (id)bgImg.CGImage;
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未录入签名，请先录入签名！" preferredStyle:UIAlertControllerStyleAlert];
            // UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    _signView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                    
                } completion:^(BOOL finished) {
                    
                }];
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }else{
        _user=[[[DataDefault shareInstance]userInfor] mutableCopy];
        [[DataDefault shareInstance]setUserInfor:_user];
        [self getMassageList:_user];

    }
   // NSLog(@"%@",_user);
}
- (void)viewWillAppear:(BOOL)animated{
    if ([[DataDefault shareInstance]userInfor]!=nil) {
        _user=[[[DataDefault shareInstance]userInfor] mutableCopy];
        [self getMassageList:_user];
        
    }
}
- (void)createPage{
    PersonalController *pvc=[[PersonalController alloc]init];
    ContactController *cvc=[[ContactController alloc]init];
    DeclearController *dvc=[[DeclearController alloc]init];
    __block MainPageViewController *blockSelf = self;
    
    CGFloat headHig=SCREEN_WIDTH/414*220;
    CGFloat listHig=SCREEN_WIDTH>320?(SCREEN_WIDTH>375?230:210):180;
    CGFloat titFont=SCREEN_WIDTH>320?(SCREEN_WIDTH>375?21:19):18;

    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(16, headHig+40, SCREEN_WIDTH-32,listHig)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.masksToBounds=NO;
    bgView.layer.cornerRadius=4;
    bgView.layer.shadowColor=RGBCOLOR(0, 0, 0).CGColor;
    bgView.layer.shadowOffset=CGSizeMake(4, 5);
    bgView.layer.shadowOpacity=0.6;
    bgView.layer.shadowRadius=4.f;
    [self.view addSubview:bgView];
    
    _mindLab= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-32,listHig)];
    _mindLab.font = [UIFont systemFontOfSize:22];
    _mindLab.text=@"暂无待办事项";
    _mindLab.textColor=RGBCOLOR(187, 187, 187);
    _mindLab.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:_mindLab];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-32,listHig) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.layer.masksToBounds=YES;
    _tableView.layer.cornerRadius=8;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.bounces=NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [bgView addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"MianDaibanCell" bundle:nil] forCellReuseIdentifier:@"MianDaibanCell"];//xib定制cell
    
    _shenQing=[[IconView alloc]initWithFrame:CGRectMake(12,(headHig+34+listHig)+15, (SCREEN_WIDTH-24)*3/5-2, (SCREEN_HEIGHT-(headHig+34+listHig)-30)/2)];
    [self.view addSubview:_shenQing];
    [_shenQing setBgColor:RGBCOLOR(245, 245, 245)];
    [_shenQing setTitle:@"申请审批" font:titFont icon:@"shenqing.png"];
    [_shenQing updateNumStatue:@"0"];
    _shenQing.tag=1;
    [_shenQing setActionShowDetail:^(NSInteger tag) {
        dvc.user=[_user mutableCopy];
        [blockSelf.navigationController pushViewController:dvc animated:YES];
        
    }];
    
    _daiBan=[[IconView alloc]initWithFrame:CGRectMake(15+(SCREEN_WIDTH-24)*3/5,(headHig+34+listHig)+15, (SCREEN_WIDTH-24)*2/5, (SCREEN_HEIGHT-(headHig+34+listHig)-30)/2)];
    [self.view addSubview:_daiBan];
    [_daiBan setBgColor:RGBCOLOR(245, 245, 245)];
    [_daiBan setTitle:@"人员" font:titFont icon:@"renyuan.png"];
    [_daiBan updateNumStatue:@"0"];
    _daiBan.tag=2;
    [_daiBan setActionShowDetail:^(NSInteger tag) {
        NSLog(@"tag:%zd",tag);
        
        
        DaiBanController *dbvc=[[DaiBanController alloc]init];
        [blockSelf.navigationController pushViewController:dbvc animated:YES];

    }];
    
    _baoBiao=[[IconView alloc]initWithFrame:CGRectMake(12,(headHig+34+listHig)+20+(SCREEN_HEIGHT-(headHig+34+listHig)-30)/2, (SCREEN_WIDTH-24)*2/5-3, (SCREEN_HEIGHT-(headHig+34+listHig)-30)/2)];
    [self.view addSubview:_baoBiao];
    [_baoBiao setBgColor:RGBCOLOR(245, 245, 245)];
    [_baoBiao setTitle:@"报表" font:titFont icon:@"bb.png"];
    [_baoBiao updateNumStatue:@"0"];
    _baoBiao.tag=3;
    [_baoBiao setActionShowDetail:^(NSInteger tag) {
        NSLog(@"tag:%zd",tag);
        
    }];
    
    _me=[[IconView alloc]initWithFrame:CGRectMake(14+(SCREEN_WIDTH-24)*2/5,(headHig+34+listHig)+20+(SCREEN_HEIGHT-(headHig+34+listHig)-30)/2, (SCREEN_WIDTH-24)*3/5, (SCREEN_HEIGHT-(headHig+34+listHig)-30)/2)];
    [self.view addSubview:_me];
    [_me setBgColor:RGBCOLOR(245, 245, 245)];
    [_me setTitle:@"账号信息" font:titFont icon:@"geren.png"];
    [_me updateNumStatue:@"0"];
    _me.tag=4;
    [_me setActionShowDetail:^(NSInteger tag) {
        [blockSelf.navigationController pushViewController:pvc animated:YES];
        
    }];
    
    [pvc setActionlogOut:^{
        LoginController *lvc=[[LoginController alloc]init];
        
        [self presentViewController:lvc animated:YES completion:^{
            
        }];
        [lvc setLoginSuccess:^(NSMutableDictionary *userInfo) {
            _user=[userInfo mutableCopy];
            [self getMassageList:_user];

        }];
        [lvc setCheckSignImage:^() {
            _signView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_HEIGHT, SCREEN_HEIGHT);
            [self.view addSubview:_signView];
            _signView.layer.contents = (id)bgImg.CGImage;
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未录入签名，请先录入签名！" preferredStyle:UIAlertControllerStyleAlert];
            // UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    _signView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                    
                } completion:^(BOOL finished) {
                    
                }];
                
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }];
    }];
    
}

#pragma mark TextFieldDelegate
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
     return [_dataArr count];
    
   // return 10;
    
    
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
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MianDaibanCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MianDaibanCell"];
    cell.backgroundColor=RGBCOLOR(255, 255, 255);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //cell.titLab.text=@"ddd";
    cell.titLab.text=_dataArr[indexPath.row][@"message"];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}

- (void)getMassageList:(NSMutableDictionary *)dictee{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:dictee[@"deptid"] forKey:@"deptid"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/getMsgList"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [_dataArr removeAllObjects];
        for (NSDictionary *dicte in dic) {
            [_dataArr addObject:dicte];
        }
        [_tableView reloadData];
         //NSLog(@"--设备%@",dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"设备列表获取失败！"];
    }];
    
}

- (IBAction)moreDaiban:(id)sender {
    DBListController *DBVC=[DBListController new];
    DBVC.userInfor=[_user mutableCopy];
    [self.navigationController pushViewController:DBVC animated:YES];
}

- (IBAction)clean:(id)sender {
    [self.drawView clear];
    
}

- (IBAction)sure:(id)sender {
    NSData * imageData = UIImageJPEGRepresentation([self imageWithUIView:_drawView],1);
    float length = [imageData length]/1024;
    
    if (length>4) {
        [UIView animateWithDuration:0.3 animations:^{
            _signView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            
            // NSString *encodedImageStr =[[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
            NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            
            _user=[[[DataDefault shareInstance]userInfor] mutableCopy];
            [_user setValue:encodedImageStr forKey:@"sign"];
            [[DataDefault shareInstance]setUserInfor:_user];
            [self uploadUserInfor:_user];
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
        if ([dic[@"success"] intValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"签字上传成功！"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"签字上传失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"签字上传失败！"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
