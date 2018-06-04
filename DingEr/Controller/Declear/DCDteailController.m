//
//  DCDteailController.m
//  DingEr
//
//  Created by Tcy on 2018/4/13.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DCDteailController.h"
#import "NewDeclearController.h"

@interface DCDteailController ()<UIScrollViewDelegate>{
    UIScrollView *_scroller;
    CGFloat scroHig,progressHig;

}
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titLab;
@property (weak, nonatomic) IBOutlet UILabel *staLab;

@property (strong, nonatomic) IBOutlet UIView *footView;

@property (strong, nonatomic) IBOutlet UIView *zongjieView;

@property (strong, nonatomic) IBOutlet UIView *progressView;

@property (weak, nonatomic) IBOutlet UIImageView *icon0;
@property (weak, nonatomic) IBOutlet UILabel *titLab0;
@property (weak, nonatomic) IBOutlet UILabel *time0;

@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UILabel *titLab1;
@property (weak, nonatomic) IBOutlet UILabel *time1;

@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UILabel *titLab2;
@property (weak, nonatomic) IBOutlet UILabel *time2;

@property (weak, nonatomic) IBOutlet UIImageView *icon3;
@property (weak, nonatomic) IBOutlet UILabel *titLab3;
@property (weak, nonatomic) IBOutlet UILabel *time3;

@property (weak, nonatomic) IBOutlet UIImageView *icon4;
@property (weak, nonatomic) IBOutlet UILabel *titLab4;
@property (weak, nonatomic) IBOutlet UILabel *time4;

@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;



@end

@implementation DCDteailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPageTitle:@"申请详情"];
    [self prepareDate];
    [self createUI];
    
}
- (void)prepareDate{
    int i=4;
    progressHig=85+i*95;
    if (i==1) {
        _line1.hidden=YES;
        _titLab1.textColor=RGBCOLOR(255, 179, 81);
        [_titLab1 setText:@"等待审核"];
        
    }
    if (i==2) {
        _line2.hidden=YES;
        _titLab1.textColor=RGBCOLOR(0, 198, 134);
        [_titLab1 setText:@"审核通过"];
        
        _titLab2.textColor=RGBCOLOR(255, 147, 0);
        [_titLab2 setText:@"等待审核"];
    }
    if (i==3) {
        _line3.hidden=YES;
        _titLab1.textColor=RGBCOLOR(0, 198, 134);
        [_titLab1 setText:@"审核通过"];
        _titLab2.textColor=RGBCOLOR(0, 198, 134);
        [_titLab2 setText:@"审核通过"];
        
        _titLab3.textColor=RGBCOLOR(255, 147, 0);
        [_titLab3 setText:@"等待审核"];
    }
    if (i==4) {
        _titLab1.textColor=RGBCOLOR(0, 198, 134);
        [_titLab1 setText:@"审核通过"];
        _titLab2.textColor=RGBCOLOR(0, 198, 134);
        [_titLab2 setText:@"审核通过"];
        _titLab3.textColor=RGBCOLOR(0, 198, 134);
        [_titLab3 setText:@"审核通过"];
        
        _titLab4.textColor=RGBCOLOR(255, 147, 0);
        [_titLab4 setText:@"等待审核"];
    }
    
    

}
- (void)createUI{
    BOOL isEnd=YES;
    CGFloat fW=(SCREEN_WIDTH>320)?90:86;
    if (!isEnd) {
        scroHig=SCREEN_HEIGHT-84;
    }else{
        scroHig=SCREEN_HEIGHT-84-fW;
        _footView.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
        [self.view addSubview:_footView];

    }
    _scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(8, 84, SCREEN_WIDTH-16, scroHig)];
    _scroller.layer.masksToBounds=YES;
    _scroller.layer.cornerRadius=6;
    _scroller.contentSize=CGSizeMake(SCREEN_WIDTH-16, 300+progressHig);
    _scroller.backgroundColor=RGBACOLOR(222, 222, 222,0);
    _scroller.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scroller];

    UIView *bodyView=[[UIView alloc]initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH-16,  progressHig+80)];
    bodyView.backgroundColor=RGBCOLOR(250, 250, 250);
    bodyView.layer.masksToBounds=NO;
    bodyView.layer.cornerRadius=6;
    bodyView.layer.shadowColor=[UIColor blackColor].CGColor;
    bodyView.layer.shadowOffset=CGSizeMake(4, 5);
    bodyView.layer.shadowOpacity=0.5;
    bodyView.layer.shadowRadius=4.f;
    [_scroller addSubview:bodyView];
    
    _headerView.frame=CGRectMake(0, 0, SCREEN_WIDTH-16, 200);
    _headerView.backgroundColor=RGBCOLOR(250, 250, 250);
    _headerView.layer.masksToBounds=NO;
    _headerView.layer.cornerRadius=6;
    _headerView.layer.shadowColor=[UIColor blackColor].CGColor;
    _headerView.layer.shadowOffset=CGSizeMake(4, 5);
    _headerView.layer.shadowOpacity=0.5;
    _headerView.layer.shadowRadius=4.f;
    [_scroller addSubview:_headerView];
    

    _progressView.frame=CGRectMake(0, 0, SCREEN_WIDTH-16, progressHig);
    _progressView.layer.masksToBounds=YES;
    _progressView.layer.cornerRadius=6;
    [bodyView addSubview:_progressView];

    _zongjieView.frame=CGRectMake(0, progressHig,SCREEN_WIDTH-16 , 80);
    _zongjieView.layer.masksToBounds=YES;
    _zongjieView.layer.cornerRadius=6;
    [bodyView addSubview:_zongjieView];


}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-16, 210)];
    header.backgroundColor=[UIColor clearColor];

    [header addSubview:_headerView];
    
    return header;
}




- (void)loadData:(NSMutableDictionary *)dict{
    
    // NSLog(@"sss%@",dict[@"cnty"]);
    
    
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
      //  [_dataArray removeAllObjects];
        
        // NSLog(@"--%@",dic);
        if ([dic[0][@"code"] floatValue]==20000) {
            for (NSDictionary *dict in dic[1]) {
              //  [_dataArray addObject:dict];
            }
          //  [_tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[0][@"msg"]];
        }
        
       // [_tableView headerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
       // [_tableView headerEndRefreshing];
        [SVProgressHUD showErrorWithStatus:@"请求失败！"];
        
    }];
}

- (IBAction)Getback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.actionGetBack) {
        self.actionGetBack(YES);
    }
    
}
- (IBAction)modify:(id)sender {
    NewDeclearController *ndvc=[[NewDeclearController alloc]init];
    ndvc.isChange=YES;
    [ndvc setChangeDeclearAction:^{
        [self.navigationController popViewControllerAnimated:YES];
        if (self.actionGetBack) {
            self.actionGetBack(NO);
        }
    }];
    [self.navigationController pushViewController:ndvc animated:YES];
    
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
