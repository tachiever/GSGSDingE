//
//  DaiBanController.m
//  DingEr
//
//  Created by Tcy on 2018/4/13.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DaiBanController.h"
#import "DaibanViewCell.h"
#import "DBDetailController.h"


@interface DaiBanController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_readArray;
    
}

@end

@implementation DaiBanController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setPageTitle:@"待办事件"];

    [self createTableView];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // return [_dataArray count];
    
    
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.navigationController pushViewController:[[DBDetailController alloc]init] animated:YES];
}

- (void)createTableView{
//    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(8, 70,SCREEN_WIDTH-16 ,SCREEN_HEIGHT-((SCREEN_WIDTH-16)/25*3+16)-70-14)];
//    bgView.backgroundColor=[UIColor clearColor];
//    bgView.layer.masksToBounds=YES;
//    bgView.layer.cornerRadius=4;
//    bgView.layer.shadowColor=[UIColor blackColor].CGColor;
//    bgView.layer.shadowOffset=CGSizeMake(0, 0);
//    bgView.layer.shadowOpacity=0.8;
//    bgView.layer.shadowRadius=4.f;
//    [self.view addSubview:bgView];
    
    

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(8, 74, SCREEN_WIDTH-16, SCREEN_HEIGHT-74) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableView];
    
    //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"DaibanViewCell" bundle:nil] forCellReuseIdentifier:@"DaibanViewCell"];//xib定制cell
    
    [_tableView addHeaderWithTarget:self action:@selector(refresh)];
    [_tableView setHeaderRefreshingText:@"正在刷新..."];
    [_tableView addFooterWithTarget:self action:@selector(refresh)];
    [_tableView setFooterRefreshingText:@"加载更多..."];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DaibanViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"DaibanViewCell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
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
