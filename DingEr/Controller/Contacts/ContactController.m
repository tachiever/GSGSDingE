//
//  ContactController.m
//  DingEr
//
//  Created by Tcy on 2018/4/13.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "ContactController.h"
#import "ContactCell.h"

@interface ContactController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_statArray;

    NSMutableArray *_readArray;
    NSInteger _num;

}

@end

@implementation ContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPageTitle:@"组织人员"];
    
   // NSLog(@"%@",_isPush);
    if (!_isPush) {
        [self hiddenBackBtnNoTitle];
        [self createCancleBtn];
    }
    [self createTableView];
    
    _num=10000000;

}

- (void)createCancleBtn{

    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(9,32,58,30)];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    backBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}
- (void)goBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(8, 0,SCREEN_WIDTH-16 ,80)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.masksToBounds=NO;
    bgView.layer.cornerRadius=4;
    bgView.layer.shadowColor=[UIColor grayColor].CGColor;
    bgView.layer.shadowOffset=CGSizeMake(0, 0);
    bgView.layer.shadowOpacity=0.8;
    bgView.layer.shadowRadius=4.f;
    
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // return [_dataArray count];
    
    
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)createTableView{

    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(8, 80, SCREEN_WIDTH-16, SCREEN_HEIGHT-80) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ContactCell" bundle:nil] forCellReuseIdentifier:@"ContactCell"];//xib定制cell
    
    [_tableView addHeaderWithTarget:self action:@selector(refresh)];
    [_tableView setHeaderRefreshingText:@"正在刷新..."];
    [_tableView addFooterWithTarget:self action:@selector(refresh)];
    [_tableView setFooterRefreshingText:@"加载更多..."];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContactCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}

- (void)refresh{
    
    NSLog(@"刷新......");
    //  [self downLoadData:_useDic];
}
- (void)loadMore{
    
    NSLog(@"加载......");
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
