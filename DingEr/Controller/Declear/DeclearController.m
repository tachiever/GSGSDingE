//
//  DeclearController.m
//  DingEr
//
//  Created by Tcy on 2018/4/13.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "DeclearController.h"
#import "DCDteailController.h"
#import "DeclearViewCell.h"
#import "NewDeclearController.h"

#import "SQController.h"
#import "SPController.h"
#import "GDSQController.h"

#import "ListModel.h"

@interface DeclearController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSString *Url;
    UIButton *addBtn;
    NSInteger _page;
    BOOL _isRefresh;
}

@end

@implementation DeclearController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPageTitle:@"申请审核"];
    _dataArray=[[NSMutableArray alloc]init];
    [self createTableView];
    _page=1;
    _isRefresh=YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    _page=1;
    _isRefresh=YES;
    NSMutableDictionary *dic=[NSMutableDictionary new];
    if ([_user[@"type"] isEqualToString:@"维护公司"]) {
        Url=[NSString stringWithFormat:URLHOST,@"appApply/showApplyListC"];
        [dic setValue:[NSString stringWithFormat:@"%@",_user[@"deptid"]] forKey:@"deptid"];
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"page"];
        [dic setValue:@"15" forKey:@"size"];
    }else{
        Url=[NSString stringWithFormat:URLHOST,@"appApply/showApplyList"];
        [dic setValue:[NSString stringWithFormat:@"%@",_user[@"deptid"]] forKey:@"deptid"];
        [dic setValue:[NSString stringWithFormat:@"%@",_user[@"level"]] forKey:@"level"];
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"page"];
        [dic setValue:@"15" forKey:@"size"];
    }
    [self loadData:dic];
    NSLog(@"---%@",_user[@"type"]);
    if ([_user[@"type"] isEqualToString:@"站"]) {
        addBtn.hidden=NO;
    }else{
        addBtn.hidden=YES;
        
    }
    
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
    
    //return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SPController *spvc=[[SPController alloc]init];
    spvc.infor=[_dataArray[indexPath.row] mutableCopy];
    spvc.user=[_user mutableCopy];
    if ([_user[@"type"] isEqualToString:@"站"]) {
        spvc.kind=@"站";
        [spvc setActionGetBack:^(BOOL isgetBack) {
            if (isgetBack) {
                NSLog(@"撤回操作");
            }else{
                NSLog(@"修改操作");
            }
        }];
    }
    if ([[NSString stringWithFormat:@"%@",_user[@"type"]]isEqualToString:@"所"]) {
        spvc.kind=@"所";
    }
    if ([_user[@"type"] isEqualToString:@"处"]) {
        spvc.kind=@"处";
    }
    if ([_user[@"type"] isEqualToString:@"局"]) {
        spvc.kind=@"局";
    }
    if ([_user[@"type"] isEqualToString:@"维护公司"]) {
        spvc.kind=@"维护公司";
    }
    [self.navigationController pushViewController:spvc animated:YES];
}

- (void)createTableView{
    addBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80,36,50,28)];
    addBtn.backgroundColor=[UIColor clearColor];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    addBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    addBtn.layer.masksToBounds=NO;
    addBtn.layer.cornerRadius=6;
    addBtn.layer.borderWidth=1;
    addBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    [addBtn addTarget:self action:@selector(addNewClear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.backgroundColor=RGBCOLOR(240, 240, 240);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"DeclearViewCell" bundle:nil] forCellReuseIdentifier:@"DeclearViewCell"];//xib定制cell
    
    [_tableView addHeaderWithTarget:self action:@selector(refresh)];
    [_tableView setHeaderRefreshingText:@"正在刷新..."];
    [_tableView addFooterWithTarget:self action:@selector(refresh)];
    [_tableView setFooterRefreshingText:@"加载更多..."];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeclearViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"DeclearViewCell"];
    NSDictionary *dic=_dataArray[indexPath.row];
    
    cell.dayLab.text=[[NSString stringWithFormat:@"%@",dic[@"create_time"]] substringWithRange:NSMakeRange(8, 2)];
    cell.yandMLab.text=[[NSString stringWithFormat:@"%@",dic[@"create_time"]] substringWithRange:NSMakeRange(0, 7)];
    cell.timeLab.text=[NSString stringWithFormat:@"创建时间：%@",[[NSString stringWithFormat:@"%@",dic[@"create_time"]] substringWithRange:NSMakeRange(11, 8)]];
    
    cell.pointLab.text=[NSString stringWithFormat:@"%@维护申请",dic[@"customer"]];
    cell.numLab.text=[NSString stringWithFormat:@"申请单号：%@",dic[@"code"]];
    
    [cell setStatue:[NSString stringWithFormat:@"%@",dic[@"audit_state"]]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)refresh{
    _isRefresh=YES;
    _page=1;
    NSMutableDictionary *dic=[NSMutableDictionary new];
    
    if ([_user[@"type"] isEqualToString:@"维护公司"]) {
        Url=[NSString stringWithFormat:URLHOST,@"appApply/showApplyListC"];
        [dic setValue:[NSString stringWithFormat:@"%@",_user[@"deptid"]] forKey:@"deptid"];
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"page"];
        [dic setValue:@"15" forKey:@"size"];
    }else{
        Url=[NSString stringWithFormat:URLHOST,@"appApply/showApplyList"];
        [dic setValue:[NSString stringWithFormat:@"%@",_user[@"deptid"]] forKey:@"deptid"];
        [dic setValue:[NSString stringWithFormat:@"%@",_user[@"level"]] forKey:@"level"];
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"page"];
        [dic setValue:@"15" forKey:@"size"];
    }
    [self loadData:dic];
    
}
- (void)loadMore{
    _isRefresh=NO;
    _page++;
    NSMutableDictionary *dic=[NSMutableDictionary new];
    
    if ([_user[@"type"] isEqualToString:@"维护公司"]) {
        Url=[NSString stringWithFormat:URLHOST,@"appApply/showApplyListC"];
        [dic setValue:[NSString stringWithFormat:@"%@",_user[@"deptid"]] forKey:@"deptid"];
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"page"];
        [dic setValue:@"15" forKey:@"size"];
    }else{
        Url=[NSString stringWithFormat:URLHOST,@"appApply/showApplyList"];
        [dic setValue:[NSString stringWithFormat:@"%@",_user[@"deptid"]] forKey:@"deptid"];
        [dic setValue:[NSString stringWithFormat:@"%@",_user[@"level"]] forKey:@"level"];
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"page"];
        [dic setValue:@"15" forKey:@"size"];
    }
    [self loadData:dic];
}


- (void)loadData:(NSMutableDictionary *)dict{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:Url parameters:dict success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (_isRefresh) {
            [_dataArray removeAllObjects];
        }
        if (dict[@"total"]>0) {
            for (NSDictionary *dic in dict[@"rows"]) {
                [_dataArray addObject:dic];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"暂无数据！"];
        }
        [_tableView reloadData];

        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败！"];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    }];
}

- (void)addNewClear{
    //NewDeclearController *neDec=[[NewDeclearController alloc]init];
    SQController *neDec=[[SQController alloc]init];
    neDec.isChange=NO;
    neDec.user=[_user mutableCopy];
    [self.navigationController pushViewController:neDec animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
