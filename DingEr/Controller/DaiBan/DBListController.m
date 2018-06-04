//
//  DBListController.m
//  DingEr
//
//  Created by Tcy on 2018/5/21.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DBListController.h"
#import "DBCell.h"

@interface DBListController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_readArray;
    CGFloat hig;
    
}

@end

@implementation DBListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    hig=SCREEN_WIDTH>320?(SCREEN_WIDTH>375?130:140):160;
    _dataArray=[NSMutableArray new];
    [self getMassageList:_userInfor];
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
    return [_dataArray count];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // [self.navigationController pushViewController:[[DBDetailController alloc]init] animated:YES];
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(8, 74, SCREEN_WIDTH-16, SCREEN_HEIGHT-74) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"DBCell" bundle:nil] forCellReuseIdentifier:@"DBCell"];//xib定制cell
    
//    [_tableView addHeaderWithTarget:self action:@selector(refresh)];
//    [_tableView setHeaderRefreshingText:@"正在刷新..."];
//    [_tableView addFooterWithTarget:self action:@selector(refresh)];
//    [_tableView setFooterRefreshingText:@"加载更多..."];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DBCell *cell=[tableView dequeueReusableCellWithIdentifier:@"DBCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    
    cell.sendStation.text=[NSString stringWithFormat:@"接受单位：%@",_dataArray[indexPath.row][@"send"]];
    cell.time.text=[NSString stringWithFormat:@"发起时间：%@",_dataArray[indexPath.row][@"create_time"]];
    cell.mes.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"message"]];
    cell.statue.text=[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"state"]];
    if ([_dataArray[indexPath.row][@"state"] isEqualToString:@"已读"]) {
        cell.statue.textColor=RGBCOLOR(58, 134, 79);
    }else{
        
        cell.statue.textColor=RGBCOLOR(225, 0, 0);
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return hig;
}

- (void)refresh{
    
    NSLog(@"刷新......");
    //  [self downLoadData:_useDic];
}
- (void)loadMore{
    
    NSLog(@"加载......");
    
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
        [_dataArray removeAllObjects];
        for (NSDictionary *dicte in dic) {
            [_dataArray addObject:dicte];
        }
        [_tableView reloadData];
       // NSLog(@"--设备%@",dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"设备列表获取失败！"];
    }];
    
}
- (IBAction)bk:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
