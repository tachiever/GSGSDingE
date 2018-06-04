//
//  DBDetailController.m
//  DingEr
//
//  Created by Tcy on 2018/4/13.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DBDetailController.h"
#import "FormReadView.h"


#import "DeclearController.h"
#import "EnclusureView.h"
#import "EquipModel.h"

@interface DBDetailController (){
    UITableView *_tableView;
    
    UIScrollView *_scroller;
    UIView *_bodyView;
    
    CGFloat scroHig,progressHig,fromHig,headHig;
    CGFloat enclusureHig,bodHig,secHig;
    
    NSMutableArray *_imageArr;//附件
    NSInteger _imageNum;//附件标示
    
    NSMutableArray *_equipArr;//上报设备
    NSMutableArray *_numArray;//上报数量
    
    NSMutableArray *_dataArray;//添加设备
    
    NSMutableArray *_perArray;//审批人
    
    BOOL isNoResult;
    
}

@property (strong, nonatomic) FormReadView *formView;
@property (strong, nonatomic) EnclusureView *enclusureView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footView;

@property (weak, nonatomic) IBOutlet UILabel *unity;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *kind;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab
;
@property (weak, nonatomic) IBOutlet UILabel *titlab;

@end

@implementation DBDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setPageTitle:@"待办详情"];

    _perArray=[[NSMutableArray alloc]init];//审批人
    
    _numArray=[[NSMutableArray alloc]init];//设备数量
    _dataArray=[[NSMutableArray alloc]init];//获取的设备
    
    _imageArr=[[NSMutableArray alloc]init];//附件
    _equipArr=[[NSMutableArray alloc]init];//已添加的设备
    
    [_equipArr addObject:@"s"];
    [_equipArr addObject:@"s"];
    [_equipArr addObject:@"s"];
    _imageNum=0;//附件标示
    secHig=50;//段头高度
    headHig=230;
    isNoResult=NO;
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createUI{
    
    CGFloat fW=(SCREEN_WIDTH>320)?90:86;
    
    enclusureHig=00+SCREEN_WIDTH/3;
    fromHig=140;
    headHig=220;
    scroHig=SCREEN_HEIGHT-84-fW;
    bodHig=enclusureHig+fromHig+20;
    
    _footView.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
    [self.view addSubview:_footView];
    
    _scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(8, 84, SCREEN_WIDTH-16, scroHig)];
    _scroller.layer.masksToBounds=YES;
    _scroller.layer.cornerRadius=6;
    _scroller.contentSize=CGSizeMake(SCREEN_WIDTH-16, headHig+bodHig);
    _scroller.backgroundColor=RGBACOLOR(222, 222, 222,0);
    _scroller.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scroller];
    
    _bodyView=[[UIView alloc]initWithFrame:CGRectMake(0, headHig+10, SCREEN_WIDTH-16,  bodHig)];
    _bodyView.backgroundColor=RGBCOLOR(250, 250, 250);
    _bodyView.layer.masksToBounds=NO;
    _bodyView.layer.cornerRadius=6;
    _bodyView.layer.shadowColor=[UIColor blackColor].CGColor;
    _bodyView.layer.shadowOffset=CGSizeMake(4, 5);
    _bodyView.layer.shadowOpacity=0.5;
    _bodyView.layer.shadowRadius=4.f;
    [_scroller addSubview:_bodyView];
    
    _headerView.frame=CGRectMake(0, 0, SCREEN_WIDTH-16, headHig);
    _headerView.backgroundColor=RGBCOLOR(250, 250, 250);
    _headerView.layer.masksToBounds=NO;
    _headerView.layer.cornerRadius=6;
    _headerView.layer.shadowColor=[UIColor blackColor].CGColor;
    _headerView.layer.shadowOffset=CGSizeMake(4, 5);
    _headerView.layer.shadowOpacity=0.5;
    _headerView.layer.shadowRadius=4.f;
    [_scroller addSubview:_headerView];
    
    _formView=[[FormReadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-16, fromHig)];
    _formView.backgroundColor=[UIColor clearColor];
    [_bodyView addSubview:_formView];

    
    [self addFormViewCell:_equipArr];

    _enclusureView =[[EnclusureView alloc]initWithFrame:CGRectMake(0,fromHig+20, SCREEN_WIDTH-16, enclusureHig)];
    _enclusureView.backgroundColor=[UIColor clearColor];
    [_bodyView addSubview:_enclusureView];
    _enclusureView.isEdit=YES;
    [_imageArr addObject:[UIImage imageNamed:@"egImage.png"]];
    [_enclusureView updateWithImageArr:_imageArr];
    [_enclusureView setActionAddImage:^(NSInteger tag) {
        NSLog(@"现实附件");
        _imageNum=tag;
        

    }];
    

}


- (void)addFormViewCell:(NSMutableArray *)arr{
    fromHig=140+arr.count*35;
    bodHig=enclusureHig+fromHig+20;
    _formView.frame=CGRectMake(0, 0, SCREEN_WIDTH-16, fromHig);
    _bodyView.frame=CGRectMake(0, headHig+10, SCREEN_WIDTH-16,  bodHig);
    _scroller.contentSize=CGSizeMake(SCREEN_WIDTH-16, headHig+20+bodHig);
    _enclusureView.frame=CGRectMake(0,fromHig+20, SCREEN_WIDTH-16, enclusureHig);
    
    [_formView updateWithImageArr:arr];
}
- (IBAction)disAgree:(id)sender {
    
}

- (IBAction)agree:(id)sender {
    
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

@end
