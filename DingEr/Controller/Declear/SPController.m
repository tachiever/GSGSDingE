//
//  SPController.m
//  DingEr
//
//  Created by Tcy on 2018/5/11.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import "SPController.h"
#import "EquipModel.h"
#import "EquipCell.h"
#import "KindCell.h"
#import "EnclusureView.h"
#import "PersonView.h"

#import "FormView.h"
#import "SheBei.h"

#import "GDSQController.h"
#import "SQController.h"

#import "MyPicker.h"


@interface SPController ()<UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,DateTimePickerViewDelegate,MyPickerDelegate>{
    UITableView *_tableView;
    UITableView *_kdView;
    
    UITableView *_maTabView;
    
    UITableView *_whgsTabView;
    
    UIScrollView *_scroller;
    CGFloat fW,kHig,gzHig,faHig,yjHig,disAgreeHig,agreeHig,shebHig,dingerHig,secHig,fujianHig,shenpiHig,optionHig,gongDanHig,dingEFJHig,juHig,chuHig;
    BOOL isNoResult,isChange;
    NSMutableArray *_imageArr;//附件
    NSInteger _imageNum;//附件标示
    
    NSMutableArray *_shenQinFujianArr;//附件
    NSInteger _shenQinFujianNum;//附件标示
    
    NSMutableArray *_equipArr;//上报设备
    
    NSMutableArray *_numArray;//上报数量
    
    NSMutableArray *_dingeArr;//上报定额设备
    NSMutableArray *_dingeNumArr;//上报定额设备数量
    
    NSMutableArray *_equipKind;//搜索设备库种类
    
    NSMutableArray *_dataArray;//搜索结果
    
    NSMutableArray *_perArray;//审批人
    
    NSMutableArray *_sheBeiArr;//审批人
    
    NSMutableArray *_whgsArr;//审批人
    
    NSInteger _sbNum,_ceStatue,timerLoca;
    NSMutableArray *_weizhiArr;//维护设备位置
    NSMutableArray *_mingchenArr;//维护设备名称
    NSMutableDictionary *_machineDic;
    
    NSMutableDictionary *_shenpiDic;
    
}
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@property (nonatomic, strong) MyPicker *fanweiPicker;
@property (nonatomic, strong) MyPicker *jibiePicker;


@property (strong, nonatomic) IBOutlet UIView *inPut;
@property (weak, nonatomic) IBOutlet UILabel *iconTitle;
@property (weak, nonatomic) IBOutlet UILabel *titlab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *unity;
@property (weak, nonatomic) IBOutlet UILabel *placeField;
@property (weak, nonatomic) IBOutlet UILabel *numField;
@property (strong, nonatomic) IBOutlet UIView *phenoView;
@property (weak, nonatomic) IBOutlet UILabel *phenoLab;
@property (strong, nonatomic) IBOutlet UIView *solutionView;
@property (weak, nonatomic) IBOutlet UILabel *solutionLab;
@property (strong, nonatomic) IBOutlet UIView *disAgree;
@property (weak, nonatomic) IBOutlet UITextView *disAgreeText;
@property (weak, nonatomic) IBOutlet UIImageView *sign1;
@property (weak, nonatomic) IBOutlet UILabel *disAgreeTim;

@property (strong, nonatomic) IBOutlet UIView *yusuanShenpi;
@property (weak, nonatomic) IBOutlet UITextView *ysOption;
@property (weak, nonatomic) IBOutlet UIImageView *sign2;
@property (weak, nonatomic) IBOutlet UILabel *ysOptionTime;

@property (strong, nonatomic) IBOutlet UIView *ysSure;


@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *seaField;
@property (weak, nonatomic) IBOutlet UILabel *kindLab;


@property (strong, nonatomic) IBOutlet UIView *chooseMachineView;
@property (weak, nonatomic) IBOutlet UILabel *bumen;
@property (weak, nonatomic) IBOutlet UILabel *weizhi;
@property (weak, nonatomic) IBOutlet UILabel *mingchen;

@property (strong, nonatomic) IBOutlet UIView *whGongSiVIew;
@property (weak, nonatomic) IBOutlet UILabel *whGongSiName;

@property (strong, nonatomic) IBOutlet UIView *gongDanView;
@property (weak, nonatomic) IBOutlet UILabel *fanwei;
@property (weak, nonatomic) IBOutlet UILabel *jibie;
@property (weak, nonatomic) IBOutlet UILabel *daodashijian;
@property (weak, nonatomic) IBOutlet UILabel *likaishijian;
@property (weak, nonatomic) IBOutlet UITextView *yiliuwenti;
@property (weak, nonatomic) IBOutlet UIImageView *engineerSign;


@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (strong, nonatomic) IBOutlet UIView *chuOption;
@property (weak, nonatomic) IBOutlet UIImageView *chuSign;
@property (weak, nonatomic) IBOutlet UITextView *chuDisOption;
@property (weak, nonatomic) IBOutlet UILabel *chuTime;

@property (strong, nonatomic) IBOutlet UIView *juOption;
@property (weak, nonatomic) IBOutlet UIImageView *juSign;
@property (weak, nonatomic) IBOutlet UITextView *juDisOption;
@property (weak, nonatomic) IBOutlet UILabel *juTime;




@property (strong, nonatomic) IBOutlet UIView *xgFoot;
@property (strong, nonatomic) IBOutlet UIView *spFoot;
@property (weak, nonatomic) IBOutlet UIView *tjFoot;


@property (nonatomic ) SheBei *sheBeiView;
@property (nonatomic ) FormView *dingEView;
@property (strong, nonatomic) PersonView *shenPiView;
@property (strong, nonatomic) EnclusureView *fujianView;
@property (strong, nonatomic) EnclusureView *zhanFuJianView;

@property (nonatomic, strong) UIImagePickerController *imagePicker;



@end

@implementation SPController
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
    
    [self setPageTitle:@"申请"];
    [self prepareDate];
    if ([self.kind isEqualToString:@"维护公司"]){
        [self prepareEquipLibeary];
    }
    [self createBasePart];
    if ([_infor[@"audit_state"] isEqualToString:@"待审核"]&&[self.kind isEqualToString:@"所"]) {
        [self getWeiHuGongSiList];
        [self createChooseWHGSView];
        
    }
    if ([self.kind isEqualToString:@"维护公司"]) {
        if ([_infor[@"audit_state"] isEqualToString:@"待预算"]||[_infor[@"audit_state"] rangeOfString:@"未通过"].location != NSNotFound) {
            [self createSearchView];
            [self createChooseMachineView];
        }
        if ([_infor[@"audit_state"] isEqualToString:@"已通过"]) {
            [self createSearchView];
            [self createPicker];
        }
    }
    NSLog(@"====%@",_infor[@"audit_state"]);
    NSLog(@"%@----%@",_user[@"station"],_user[@"deptid"]);
}
- (void)createPicker{
    self.datePickerView = [[DateTimePickerView alloc] init];
    _datePickerView.delegate = self;
    _datePickerView.pickerViewMode = DatePickerViewDateTimeMode;
    [self.view addSubview:_datePickerView];
    
    self.fanweiPicker = [[MyPicker alloc] init];
    _fanweiPicker.delegate = self;
    _fanweiPicker.dataArr =@[@"日常",@"肇事",@"被损被盗",@"专项",@"其他"];
    [self.view addSubview:_fanweiPicker];
    
    self.jibiePicker = [[MyPicker alloc] init];
    _jibiePicker.dataArr =@[@"一级",@"二级",@"三级",@"四级",@"五级"];
    _jibiePicker.delegate = self;
    [self.view addSubview:_jibiePicker];
    
    
}
- (void)prepareDate{
    _equipArr=[[NSMutableArray alloc]init];
    _numArray=[[NSMutableArray alloc]init];
    _imageArr=[[NSMutableArray alloc]init];
    
    _dingeArr=[[NSMutableArray alloc]init];
    _dingeNumArr=[[NSMutableArray alloc]init];
    
    _dataArray=[[NSMutableArray alloc]init];
    _perArray=[[NSMutableArray alloc]init];
    _equipKind=[[NSMutableArray alloc]init];
    
    _weizhiArr=[[NSMutableArray alloc]init];
    _mingchenArr=[[NSMutableArray alloc]init];
    _machineDic=[NSMutableDictionary new];
    _shenpiDic=[NSMutableDictionary new];
    
    _whgsArr=[[NSMutableArray alloc]init];
    _shenQinFujianArr=[[NSMutableArray alloc]init];
    
    _shenQinFujianNum=0;
    _sbNum=1;
    secHig=50;//段头高度
    isChange=NO;
    isNoResult=NO;
    fW=(SCREEN_WIDTH>320)?80:70;
    kHig=(SCREEN_WIDTH>320)?((SCREEN_WIDTH>375)?160:150):156;
    gzHig=64+[NSString stringHight:_infor[@"machine_state"] font:16 width:SCREEN_WIDTH-44];
    faHig=64+[NSString stringHight:_infor[@"servicing"] font:16 width:SCREEN_WIDTH-44];
    yjHig=64+22;
    
    chuHig=0;
    juHig=0;
    
    agreeHig=94+33;
    disAgreeHig=(SCREEN_WIDTH/2-24)*200/343+100;
    optionHig=(SCREEN_WIDTH/2-24)*200/343+100;
    shebHig=80+(_equipArr.count+1)*35;
    
    dingerHig=120+(_dingeArr.count+1)*35;
    
    fujianHig=50+SCREEN_WIDTH/4;
    dingEFJHig=50+SCREEN_WIDTH/4;
    //enclusureHig=(SCREEN_WIDTH>320)?((SCREEN_WIDTH>375)?135:135*375/414):145*320/414;
    shenpiHig=32+SCREEN_WIDTH/4;
    
    gongDanHig=315+40;
    timerLoca=2;
    
}
- (void)createBasePart{
    _scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW)];
    _scroller.backgroundColor=RGBACOLOR(245, 245, 245,1);
    _scroller.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scroller];
    
    
    _inPut.frame=CGRectMake(0, 0, SCREEN_WIDTH, 258);
    [_scroller addSubview:_inPut];
    
    _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig);
    
    /*
     绑定头部固定数据
     */
    _iconTitle.text=_infor[@"customer"];
    _titlab.text=[NSString stringWithFormat:@"%@维修申请",_infor[@"customer"]];
    _statusLab.text=_infor[@"audit_state"];
    if ([_infor[@"audit_state"] rangeOfString:@"未通过"].location != NSNotFound) {
        _statusLab.textColor=RGBCOLOR(227, 0, 0);
    }
    else if ([_infor[@"audit_state"] isEqualToString:@"已确认"]) {
        _statusLab.textColor=RGBCOLOR(0, 171,98);
    }else{
        _statusLab.textColor=[UIColor orangeColor];
    }
    _unity.text=_infor[@"station_name"];
    _placeField.text=_infor[@"service_address"];
    _numField.text=_infor[@"code"];
    _phenoLab.text=_infor[@"machine_state"];
    _solutionLab.text=_infor[@"servicing"];
    
    _phenoView.frame=CGRectMake(0, 258,SCREEN_WIDTH , gzHig);
    [_scroller addSubview:_phenoView];
    
    _solutionView.frame=CGRectMake(0, 258+gzHig,SCREEN_WIDTH , faHig);
    [_scroller addSubview:_solutionView];
    
    
    _zhanFuJianView =[[EnclusureView alloc]initWithFrame:CGRectMake(0,258+gzHig+faHig, SCREEN_WIDTH, fujianHig)];
    _zhanFuJianView.backgroundColor=[UIColor whiteColor];
    _zhanFuJianView.isEdit=YES;
    [_shenQinFujianArr addObject:[UIImage imageNamed:@"fujian.png"]];
    [_zhanFuJianView updateWithImageArr:_shenQinFujianArr];
    
    [_zhanFuJianView setActionAddImage:^(NSInteger tag) {
        _imageNum=tag;
        
        NSLog(@"浏览图片!!!");
    }];
    [_scroller addSubview:_zhanFuJianView];
    // _scroller.contentSize=CGSizeMake(0, 258+fujianHig);
    
    if ([_infor[@"audit_state"] isEqualToString:@"待审核"]) {
        
        if ([self.kind isEqualToString:@"站"]) {
            _xgFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_xgFoot];
        }else if ([self.kind isEqualToString:@"所"]) {
            _spFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_spFoot];
            //审批意见部分创建
            [self prepareOptionView:nil isedi:YES];
        }else if ([self.kind isEqualToString:@"维护公司"]) {
            
        }
        
    }else if ([_infor[@"audit_state"] isEqualToString:@"审核未通过"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        //审批意见部分创建
        [self prepareOptionView:optStr isedi:NO];
        if ([self.kind isEqualToString:@"站"]) {
            _xgFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_xgFoot];
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
        }else if ([self.kind isEqualToString:@"所"]) {
            
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
            
        }
        
    }else if ([_infor[@"audit_state"] isEqualToString:@"预算未通过"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        //审批意见部分创建
        [self prepareOptionView:optStr isedi:NO];
        
        [self prepareYuSuanOption:optStr isedi:NO];

        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            if ([_infor[@"checkTwo_reason"] length]>1) {
                [self prepareChuOption:optStr isedi:NO];
            }
            
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            if ([_infor[@"checkThree_reason"] length]>1) {
                [self prepareChuOption:optStr isedi:NO];
                [self prepareJuOption:optStr isedi:NO];
            }else{
                if ([_infor[@"checkTwo_reason"] length]>1) {
                    [self prepareChuOption:optStr isedi:NO];
                }
            }
        }
        
        if ([self.kind isEqualToString:@"维护公司"]) {
            _tjFoot.frame=CGRectMake(0, SCREEN_HEIGHT,SCREEN_WIDTH , fW);
            [self.view addSubview:_tjFoot];
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
            UIButton *addBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80,36,50,28)];
            addBtn.backgroundColor=[UIColor clearColor];
            [addBtn setTitle:@"修改" forState:UIControlStateNormal];
            addBtn.titleLabel.font=[UIFont systemFontOfSize:16];
            [addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            addBtn.layer.masksToBounds=NO;
            addBtn.layer.cornerRadius=6;
            addBtn.layer.borderWidth=1;
            addBtn.layer.borderColor=[UIColor whiteColor].CGColor;
            [addBtn addTarget:self action:@selector(xiuGaiYuSuan:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:addBtn];
        }else {
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
        }
        [self createWeiHuShebeiPart:NO dinge:NO];
        [self getDingEData];
        
    }else if ([_infor[@"audit_state"] isEqualToString:@"预算处级未通过"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        //审批意见部分创建
        [self prepareOptionView:optStr isedi:NO];
        
        [self prepareYuSuanOption:optStr isedi:NO];

        
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            [self prepareChuOption:optStr isedi:NO];
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            if ([_infor[@"checkThree_reason"] length]>1) {
                [self prepareChuOption:optStr isedi:NO];
                [self prepareJuOption:optStr isedi:NO];
            }else{
                [self prepareChuOption:optStr isedi:NO];

            }
        }
        if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"处"]||[self.kind isEqualToString:@"维护公司"]||[self.kind isEqualToString:@"局"]) {
            
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
        }else if ([self.kind isEqualToString:@"所"]) {
            _ysSure.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_ysSure];
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
            
        }
        [self createWeiHuShebeiPart:NO dinge:NO];
        [self getDingEData];
        
    }else if ([_infor[@"audit_state"] isEqualToString:@"预算局级未通过"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        //审批意见部分创建
        [self prepareOptionView:optStr isedi:NO];
        
        [self prepareYuSuanOption:optStr isedi:NO];
        [self prepareChuOption:optStr isedi:NO];
        [self prepareJuOption:optStr isedi:NO];
        
        if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"所"]||[self.kind isEqualToString:@"维护公司"]||[self.kind isEqualToString:@"局"]) {
            
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
        }else if ([self.kind isEqualToString:@"处"]) {
            _ysSure.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_ysSure];
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);

        }
        [self createWeiHuShebeiPart:NO dinge:NO];
        [self getDingEData];
        
    }else if ([_infor[@"audit_state"] isEqualToString:@"待预算"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        //审批意见部分创建
        [self prepareOptionView:optStr isedi:NO];
        if ([self.kind isEqualToString:@"站"]) {
            
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
        }else if ([self.kind isEqualToString:@"所"]) {
            
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
            
        }else if ([self.kind isEqualToString:@"维护公司"]) {
            _tjFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_tjFoot];
            [self createWeiHuShebeiPart:YES dinge:YES];
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
        }
        
    } else if ([_infor[@"audit_state"] isEqualToString:@"已预算"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        [self prepareOptionView:optStr isedi:NO];
        [self createWeiHuShebeiPart:NO dinge:NO];
        [self getDingEData];
        
        if ([self.kind isEqualToString:@"站"]) {
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
            
        }else if ([self.kind isEqualToString:@"所"]) {
            [self prepareYuSuanOption:nil isedi:YES];
            _spFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_spFoot];
            
        }else if ([self.kind isEqualToString:@"维护公司"]) {
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
            
        }
        
    } else if ([_infor[@"audit_state"] isEqualToString:@"已预算一审"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        [self prepareOptionView:optStr isedi:NO];
        [self prepareYuSuanOption:optStr isedi:NO];
        
        if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"维护公司"]||[self.kind isEqualToString:@"所"]) {
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
            
        }else if ([self.kind isEqualToString:@"处"]) {
            _spFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_spFoot];
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
            [self prepareChuOption:nil isedi:YES];
        }
        [self createWeiHuShebeiPart:NO dinge:NO];
        [self getDingEData];
        
    } else if ([_infor[@"audit_state"] isEqualToString:@"已预算二审"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        [self prepareOptionView:optStr isedi:NO];
        [self prepareYuSuanOption:optStr isedi:NO];
        [self prepareChuOption:optStr isedi:NO];
        
        if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"维护公司"]||[self.kind isEqualToString:@"所"]||[self.kind isEqualToString:@"处"]) {
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
            
        }else if ([self.kind isEqualToString:@"局"]) {
            _spFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_spFoot];
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
            [self prepareJuOption:nil isedi:YES];
        }
        [self createWeiHuShebeiPart:NO dinge:NO];
        [self getDingEData];
        
    } else if ([_infor[@"audit_state"] isEqualToString:@"已通过"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        [self prepareOptionView:optStr isedi:NO];
        [self prepareYuSuanOption:optStr isedi:NO];
        
        if ([_infor[@"maintenance_type"] isEqualToString:@"未超额"]) {
            if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"所"]) {
                _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
                [self createWeiHuShebeiPart:NO dinge:NO];
                [self getDingEData];
            }else if ([self.kind isEqualToString:@"维护公司"]) {
                _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
                _tjFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
                [self.view addSubview:_tjFoot];
                [self createWeiHuShebeiPart:NO dinge:YES];
                [self getDingEData];
                [self prepareGongZuoDanView:YES];
            }
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            [self prepareChuOption:optStr isedi:NO];
            
            if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"所"]||[self.kind isEqualToString:@"处"]) {
                _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
                [self createWeiHuShebeiPart:NO dinge:NO];
                [self getDingEData];
            }else if ([self.kind isEqualToString:@"维护公司"]) {
                _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
                _tjFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
                [self.view addSubview:_tjFoot];
                [self createWeiHuShebeiPart:NO dinge:YES];
                [self getDingEData];
                [self prepareGongZuoDanView:YES];
            }
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            [self prepareChuOption:optStr isedi:NO];
            [self prepareJuOption:optStr isedi:NO];
            if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"所"]||[self.kind isEqualToString:@"处"]||[self.kind isEqualToString:@"局"]) {
                _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
                [self createWeiHuShebeiPart:NO dinge:NO];
                [self getDingEData];
            }else if ([self.kind isEqualToString:@"维护公司"]) {
                _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
                _tjFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
                [self.view addSubview:_tjFoot];
                [self createWeiHuShebeiPart:NO dinge:YES];
                [self getDingEData];
                [self prepareGongZuoDanView:YES];
            }
        }
        
    }else if ([_infor[@"audit_state"] isEqualToString:@"待评价"]) {
        
        _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        [self prepareOptionView:optStr isedi:NO];
        [self prepareYuSuanOption:optStr isedi:NO];
        [self prepareGongZuoDanView:NO];
        
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            [self prepareChuOption:optStr isedi:NO];
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            [self prepareChuOption:optStr isedi:NO];
            [self prepareJuOption:optStr isedi:NO];
        }
        [self createWeiHuShebeiPart:NO dinge:NO];
        [self getDingEData];
        if ([self.kind isEqualToString:@"站"]) {
            UIButton *addBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80,36,50,28)];
            addBtn.backgroundColor=[UIColor clearColor];
            [addBtn setTitle:@"评价" forState:UIControlStateNormal];
            addBtn.titleLabel.font=[UIFont systemFontOfSize:16];
            [addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            addBtn.layer.masksToBounds=NO;
            addBtn.layer.cornerRadius=6;
            addBtn.layer.borderWidth=1;
            addBtn.layer.borderColor=[UIColor whiteColor].CGColor;
            [addBtn addTarget:self action:@selector(evalauteService) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:addBtn];
        }
        
    } else if ([_infor[@"audit_state"] isEqualToString:@"待确认"]) {
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        [self prepareOptionView:optStr isedi:NO];
        [self prepareYuSuanOption:optStr isedi:NO];
        [self prepareGongZuoDanView:NO];
        if ([self.kind isEqualToString:@"所"]) {
            _ysSure.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            [self.view addSubview:_ysSure];
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
        }else{
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
            
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            [self prepareChuOption:optStr isedi:NO];
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            [self prepareChuOption:optStr isedi:NO];
            [self prepareJuOption:optStr isedi:NO];
        }
        [self createWeiHuShebeiPart:NO dinge:NO];
        [self getDingEData];
        
    } else if ([_infor[@"audit_state"] isEqualToString:@"已确认"]) {
        _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
        
        NSString *optStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"back_reason"]].length==0) {
            optStr=@"无";
        }else{
            optStr=[NSString stringWithFormat:@"%@",_infor[@"back_reason"]];
        }
        [self prepareOptionView:optStr isedi:NO];
        [self prepareYuSuanOption:optStr isedi:NO];
        [self prepareGongZuoDanView:NO];
        
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            [self prepareChuOption:optStr isedi:NO];
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            [self prepareChuOption:optStr isedi:NO];
            [self prepareJuOption:optStr isedi:NO];
        }
        [self createWeiHuShebeiPart:NO dinge:NO];
        [self getDingEData];
    }
}

- (void)xiuGaiYuSuan:(UIButton *)btn{
    if (!isChange) {
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.3 animations:^{
            _tjFoot.frame=CGRectMake(0, SCREEN_HEIGHT-fW,SCREEN_WIDTH , fW);
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW);
        } completion:^(BOOL finished) {
            _sheBeiView.isEdit=YES;
            _dingEView.isEdit=YES;
            [self addSheBeiViewCell:_equipArr];
            [self addFormViewCell:_dingeArr];
            _yusuanShenpi.hidden=YES;
            _chuOption.hidden=YES;
            _juOption.hidden=YES;
            _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+dingerHig+shebHig+dingEFJHig);
        }];
        
    }else{
        [btn setTitle:@"修改" forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.3 animations:^{
            _tjFoot.frame=CGRectMake(0, SCREEN_HEIGHT,SCREEN_WIDTH , fW);
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74);
        } completion:^(BOOL finished) {
            _sheBeiView.isEdit=NO;
            _dingEView.isEdit=NO;
            _yusuanShenpi.hidden=NO;
            _chuOption.hidden=NO;
            _juOption.hidden=NO;
            [self addSheBeiViewCell:_equipArr];
            [self addFormViewCell:_dingeArr];
        }];
    }
    isChange=!isChange;
}

- (void)getDingEData{
    //添加定额详细信息
    dispatch_queue_t queue = dispatch_queue_create("GetData", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        // 模拟耗时操作
        [self getSheBeiList];
    });
    dispatch_async(queue, ^{
        // 模拟耗时操作
        [self getDingEList];
    });
}

- (void)prepareGongZuoDanView:(BOOL)isEdit{
    if (SCREEN_WIDTH==320) {
        _daodashijian.font=[UIFont systemFontOfSize:14];
        _likaishijian.font=[UIFont systemFontOfSize:14];
    }else if (SCREEN_WIDTH==375) {
        _daodashijian.font=[UIFont systemFontOfSize:16];
        _likaishijian.font=[UIFont systemFontOfSize:16];
    }
    else{
        _daodashijian.font=[UIFont systemFontOfSize:17];
        _likaishijian.font=[UIFont systemFontOfSize:17];
    }
    
    if (isEdit) {
        _yiliuwenti.text=@"描述维护过程";
        _yiliuwenti.textColor=[UIColor grayColor];
        gongDanHig=312+40+(SCREEN_WIDTH-100)*200/343+50;
    }else{
        gongDanHig=315+20+[NSString stringHight:_infor[@"machine_state"] font:16 width:SCREEN_WIDTH-45]+(SCREEN_WIDTH-100)*200/343+50;
        _fanwei.text=_infor[@"service_range"];
        _jibie.text=_infor[@"service_level"];
        _daodashijian.text=_infor[@"arrive_date"];
        _likaishijian.text=_infor[@"leave_date"];
        _yiliuwenti.text=_infor[@"service_content"];
        _yiliuwenti.textColor=[UIColor blackColor];
        _yiliuwenti.editable=NO;
        _btn1.hidden=YES;
        _btn2.hidden=YES;
        _btn3.hidden=YES;
        _btn4.hidden=YES;
    }
    
    [_engineerSign setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ImageUrl,_infor[@"engineer"]]]];
    _gongDanView.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , gongDanHig);
    _yiliuwenti.delegate=self;
    [_scroller addSubview:_gongDanView];
    _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+gongDanHig);
    
}

- (void)prepareYuSuanOption:(NSString *)option isedi:(BOOL )isedi {
    // yjHig=64+[NSString stringHight:option font:16 width:SCREEN_WIDTH-44];
    if (isedi) {
        _ysOption.text=@"请输入审批意见";
        _ysOption.textColor=[UIColor grayColor];
        _ysOptionTime.hidden=YES;
        optionHig=(SCREEN_WIDTH/2-24)*200/343+66;
    }else{
        NSString *ysOptStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"checkone_reason"]].length==0) {
            ysOptStr=@"无";
        }else{
            ysOptStr=[NSString stringWithFormat:@"%@",_infor[@"checkone_reason"]];
        }
        optionHig=(SCREEN_WIDTH/2-24)*200/343+100;
        _ysOption.text=ysOptStr;
        _ysOption.textColor=[UIColor blackColor];
        _ysOption.editable=NO;
        _ysOptionTime.text=[NSString stringWithFormat:@"%@提交\n%@审批,%@",_infor[@"checko_time"],_infor[@"checkt_time"],[NSString beginTime:_infor[@"checko_time"] endtime:_infor[@"checkt_time"]]];
    }
    [_sign2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ImageUrl,_infor[@"checkone_sign"]]]];

    _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
    _ysOption.delegate=self;
    [_scroller addSubview:_yusuanShenpi];
    _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig);
}

- (void)prepareChuOption:(NSString *)option isedi:(BOOL )isedi {
    // yjHig=64+[NSString stringHight:option font:16 width:SCREEN_WIDTH-44];
    if (isedi) {
        _chuDisOption.text=@"请输入审批意见";
        _chuDisOption.textColor=[UIColor grayColor];
        _chuTime.hidden=YES;
        chuHig=(SCREEN_WIDTH/2-24)*200/343+66;
    }else{
        NSString *chuOptStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"checkTwo_reason"]].length==0) {
            chuOptStr=@"无";
        }else{
            chuOptStr=[NSString stringWithFormat:@"%@",_infor[@"checkTwo_reason"]];
        }
        chuHig=(SCREEN_WIDTH/2-24)*200/343+100;
        _chuDisOption.text=chuOptStr;
        _chuDisOption.textColor=[UIColor blackColor];
        _chuDisOption.editable=NO;
        _chuTime.text=[NSString stringWithFormat:@"%@提交\n%@审批,%@",_infor[@"checkt_time"],_infor[@"checkth_time"],[NSString beginTime:_infor[@"checkt_time"] endtime:_infor[@"checkth_time"]]];
    }
    [_chuSign setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ImageUrl,_infor[@"checktwo_sign"]]]];

    _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
    _chuDisOption.delegate=self;
    [_scroller addSubview:_chuOption];
    _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig);
}

- (void)prepareJuOption:(NSString *)option isedi:(BOOL )isedi {
    // yjHig=64+[NSString stringHight:option font:16 width:SCREEN_WIDTH-44];
    if (isedi) {
        _juDisOption.text=@"请输入审批意见";
        _juDisOption.textColor=[UIColor grayColor];
        _juTime.hidden=YES;
        juHig=(SCREEN_WIDTH/2-24)*200/343+66;
    }else{
        NSString *juOptStr;
        if ([NSString stringWithFormat:@"%@",_infor[@"checkThree_reason"]].length==0) {
            juOptStr=@"无";
        }else{
            juOptStr=[NSString stringWithFormat:@"%@",_infor[@"checkThree_reason"]];
        }
        juHig=(SCREEN_WIDTH/2-24)*200/343+100;
        _juDisOption.text=juOptStr;
        _juDisOption.textColor=[UIColor blackColor];
        _juDisOption.editable=NO;
        _juTime.text=[NSString stringWithFormat:@"%@提交\n%@审批,%@",_infor[@"checkth_time"],_infor[@"checkf_time"],[NSString beginTime:_infor[@"checkth_time"] endtime:_infor[@"checkf_time"]]];
    }
    [_juSign setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ImageUrl,_infor[@"checkThree_sign"]]]];

    _juOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig,SCREEN_WIDTH , juHig);
    _juDisOption.delegate=self;
    [_scroller addSubview:_juOption];
    _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig+juHig);
}

- (void)prepareOptionView:(NSString *)option isedi:(BOOL )isedi {
    // yjHig=64+[NSString stringHight:option font:16 width:SCREEN_WIDTH-44];
    if (isedi) {
        _disAgreeText.text=@"请输入审批意见";
        _disAgreeText.textColor=[UIColor grayColor];
        _disAgreeTim.hidden=YES;
        disAgreeHig=(SCREEN_WIDTH/2-24)*200/343+66;
    }else{
        disAgreeHig=(SCREEN_WIDTH/2-24)*200/343+100;
        _disAgreeText.text=option;
        _disAgreeText.textColor=[UIColor blackColor];
        _disAgreeText.editable=NO;
        _disAgreeTim.text=[NSString stringWithFormat:@"%@提交\n%@审批,%@",_infor[@"create_time"],_infor[@"checko_time"],[NSString beginTime:_infor[@"create_time"] endtime:_infor[@"checko_time"]]];
    }
    [_sign1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ImageUrl,_infor[@"checkone_sign"]]]];
    _disAgree.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig,SCREEN_WIDTH , disAgreeHig);
    _disAgreeText.delegate=self;
    [_scroller addSubview:_disAgree];
    _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig);
}

- (void)createWeiHuShebeiPart:(BOOL)isEdit dinge:(BOOL)edit{
    __block SPController *blockSelf = self;
    _sheBeiView=[[SheBei alloc]initWithFrame:CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig, SCREEN_WIDTH, shebHig)];
    _sheBeiView.isEdit=isEdit;
    _sheBeiView.backgroundColor=[UIColor whiteColor];
    [_scroller addSubview:_sheBeiView];
    
    [_sheBeiView setActionAddForm:^(NSInteger tag) {
        [UIView animateWithDuration:0.3 animations:^{
            blockSelf.chooseMachineView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [blockSelf getSheBeiWeiZhiLieBiao];
        }];
    }];
    
    [_sheBeiView setActionCloseForm:^(NSInteger tag) {
        [_equipArr removeObjectAtIndex:tag];
        [self addSheBeiViewCell:_equipArr];
    }];
    
    
    _dingEView=[[FormView alloc]initWithFrame:CGRectMake(0,258+fujianHig+gzHig+faHig+disAgreeHig+shebHig, SCREEN_WIDTH, dingerHig)];
    _dingEView.isEdit=edit;
    _dingEView.backgroundColor=[UIColor whiteColor];
    [_scroller addSubview:_dingEView];
    
    [_dingEView setActionAddForm:^(NSInteger tag) {
        [UIView animateWithDuration:0.3 animations:^{
            blockSelf.searchView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }];
    
    [_dingEView setActionCloseForm:^(NSInteger tag) {
        [_dingeArr removeObjectAtIndex:tag];
        [self addFormViewCell:_dingeArr];
    }];
    
    [_dingEView setGetChaoEStatues:^(NSInteger statue) {
        _ceStatue=statue;
    }];
    
    _fujianView =[[EnclusureView alloc]initWithFrame:CGRectMake(0,258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig, SCREEN_WIDTH, dingEFJHig)];
    _fujianView.backgroundColor=[UIColor whiteColor];
    _fujianView.isEdit=isEdit;
    [_imageArr addObject:[UIImage imageNamed:@"fujian.png"]];
    [_fujianView updateWithImageArr:_imageArr];
    
    [_fujianView setActionAddImage:^(NSInteger tag) {
        _imageNum=tag;
        [blockSelf showActSheet];
    }];
    [_scroller addSubview:_fujianView];
    _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+dingerHig+shebHig+dingEFJHig);
    
}

- (void)prepareShenPiRen{
    _shenPiView =[[PersonView alloc]initWithFrame:CGRectMake(0,258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig, SCREEN_WIDTH, shenpiHig)];
    _shenPiView.backgroundColor=[UIColor whiteColor];
    [_scroller addSubview:_shenPiView];
    //_shenPiView.isEdit=isEdit;
    _shenPiView.title=@"审批人";
    [_shenPiView updateWithPersonArr:_perArray];
    
    [_shenPiView setActionAddPerson:^(NSInteger tag) {
        
    }];
    
    _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+dingerHig+shebHig+dingEFJHig+shenpiHig);
}

- (void)addSheBeiViewCell:(NSMutableArray *)arr{
    [self updatePageHight];
    [_sheBeiView updateWithImageArr:arr];
    
}
- (void)addFormViewCell:(NSMutableArray *)arr{
    [self updatePageHight];
    [_dingEView updateWithImageArr:arr];
    
}
- (void)updatePageHight{
    CGFloat hig = 0.0;
    shebHig=80+(_equipArr.count+1)*35;
    dingerHig=116+(_dingeArr.count+1)*35;
    
    _sheBeiView.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig, SCREEN_WIDTH, shebHig);
    _dingEView.frame=CGRectMake(0,258+fujianHig+gzHig+faHig+disAgreeHig+shebHig, SCREEN_WIDTH, dingerHig);
    _fujianView.frame=CGRectMake(0,258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig, SCREEN_WIDTH, dingEFJHig);
    
    if ([_infor[@"audit_state"] isEqualToString:@"审核未通过"]) {
        if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"所"]) {
            hig=0;
        }
    }else if ([_infor[@"audit_state"] isEqualToString:@"待预算"]) {
        if ([self.kind isEqualToString:@"站"]) {
            hig=0;
        }else if ([self.kind isEqualToString:@"所"]) {
            hig=0;
        }else if ([self.kind isEqualToString:@"维护公司"]) {
            hig=0;
        }
    }else if ([_infor[@"audit_state"] isEqualToString:@"预算未通过"]) {
        
        _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
        
        hig=optionHig;
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            if ([_infor[@"checkTwo_reason"] length]>1) {
        _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
                hig=optionHig+chuHig;
            }
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            if ([_infor[@"checkThree_reason"] length]>1) {
                _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
                _juOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig,SCREEN_WIDTH , juHig);
                hig=optionHig+chuHig+juHig;

            }else{
                if ([_infor[@"checkTwo_reason"] length]>1) {
                    _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
                    hig=optionHig+chuHig;

                }
            }
        }
        
    }else if ([_infor[@"audit_state"] isEqualToString:@"预算处级未通过"]) {
        
        _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
        
        hig=optionHig;
        
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
            hig=optionHig+chuHig;
            
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            if ([_infor[@"checkThree_reason"] length]>1) {
                _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
                _juOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig,SCREEN_WIDTH , juHig);
                hig=optionHig+chuHig+juHig;
            }else{
                _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
                hig=optionHig+chuHig;
            }
        }
    }else if ([_infor[@"audit_state"] isEqualToString:@"预算局级未通过"]) {
        _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
        _juOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig,SCREEN_WIDTH , juHig);
        hig=optionHig+chuHig+juHig;
    }else if ([_infor[@"audit_state"] isEqualToString:@"已预算"]) {
        if ([self.kind isEqualToString:@"站"]) {
            hig=0;
        }else if ([self.kind isEqualToString:@"所"]) {
            _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
            hig=optionHig;
        }else if ([self.kind isEqualToString:@"维护公司"]) {
            hig=0;
        }
    } else if ([_infor[@"audit_state"] isEqualToString:@"已预算一审"]) {
        if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"维护公司"]||[self.kind isEqualToString:@"所"]) {
            _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
            hig=optionHig;
        }else if ([self.kind isEqualToString:@"处"]) {
            _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
            _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
            hig=optionHig+chuHig;
        }else if ([self.kind isEqualToString:@"局"]) {
            hig=0;
        }
        
    } else if ([_infor[@"audit_state"] isEqualToString:@"已预算二审"]) {
        if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"维护公司"]||[self.kind isEqualToString:@"所"]||[self.kind isEqualToString:@"处"]) {
            _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
            _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
            hig=optionHig+chuHig;
        }else if ([self.kind isEqualToString:@"局"]) {
            _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
            hig=optionHig;
        }
        
    }else if ([_infor[@"audit_state"] isEqualToString:@"已通过"]) {
        if ([_infor[@"maintenance_type"] isEqualToString:@"未超额"]) {
            if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"所"]) {
                _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
                hig=optionHig;
            }else if ([self.kind isEqualToString:@"维护公司"]) {
                _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
                _gongDanView.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+ chuHig,SCREEN_WIDTH , gongDanHig);
                hig=optionHig+gongDanHig;
            }
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"所"]||[self.kind isEqualToString:@"处"]) {
                _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
                _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
                hig=optionHig+chuHig;
            }else if ([self.kind isEqualToString:@"维护公司"]) {
                _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
                _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
                _gongDanView.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+ chuHig,SCREEN_WIDTH , gongDanHig);
                hig=optionHig+chuHig+gongDanHig;
            }
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            if ([self.kind isEqualToString:@"站"]||[self.kind isEqualToString:@"所"]||[self.kind isEqualToString:@"处"]||[self.kind isEqualToString:@"局"]) {
                _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
                _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
                _juOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig,SCREEN_WIDTH , juHig);
                hig=optionHig+chuHig+juHig;
            }else if ([self.kind isEqualToString:@"维护公司"]) {
                _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
                _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
                _juOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig,SCREEN_WIDTH , juHig);
                _gongDanView.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+ chuHig,SCREEN_WIDTH , gongDanHig);
                hig=optionHig+chuHig+juHig+gongDanHig;
            }
        }
    } else if ([_infor[@"audit_state"] isEqualToString:@"待评价"]||[_infor[@"audit_state"] isEqualToString:@"已确认"]||[_infor[@"audit_state"] isEqualToString:@"待确认"]) {
        if ([_infor[@"maintenance_type"] isEqualToString:@"未超额"]) {
            
            _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
            _gongDanView.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+ chuHig,SCREEN_WIDTH , gongDanHig);
            hig=optionHig+gongDanHig;
            
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
            _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
            _gongDanView.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig,SCREEN_WIDTH , gongDanHig);
            hig=optionHig+chuHig+gongDanHig;
        }
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额三级"]) {
            _yusuanShenpi.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig,SCREEN_WIDTH , optionHig);
            _chuOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig,SCREEN_WIDTH , chuHig);
            _juOption.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig,SCREEN_WIDTH , juHig);
            _gongDanView.frame=CGRectMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+shebHig+dingerHig+dingEFJHig+optionHig+chuHig+juHig,SCREEN_WIDTH , gongDanHig);
            hig=optionHig+chuHig+juHig+gongDanHig;
        }
    }
    _scroller.contentSize=CGSizeMake(0, 258+fujianHig+gzHig+faHig+disAgreeHig+dingerHig+shebHig+dingEFJHig+hig);
}

- (void)addOrminusPerson:(NSInteger )tag{
    if (tag==0) {
        NSLog(@"添加审批人");
        
    }else{
        [_perArray removeAllObjects];
        tag=0;
        [_shenPiView updateWithPersonArr:_perArray];
    }
    
}

- (void)createChooseMachineView{
    _chooseMachineView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:_chooseMachineView];
    
    _bumen.text=_infor[@"customer"];
    
    _maTabView = [[UITableView alloc] initWithFrame:CGRectMake(63, 174, SCREEN_WIDTH-79, 0) style:UITableViewStylePlain];
    _maTabView.dataSource = self;
    _maTabView.delegate = self;
    _maTabView.bounces = NO;
    
    _maTabView.layer.masksToBounds=YES;
    _maTabView.layer.cornerRadius=6;
    _maTabView.showsVerticalScrollIndicator=NO;
    // _tableView.backgroundColor=RGBCOLOR(199, 199, 199);
    _maTabView.backgroundColor=[UIColor whiteColor];
    _maTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_chooseMachineView addSubview:_maTabView];
    [_maTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_maTabView registerNib:[UINib nibWithNibName:@"KindCell" bundle:nil] forCellReuseIdentifier:@"KindCell"];//xib定制cell
    
}

- (void)createChooseWHGSView{
    _whGongSiVIew.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:_whGongSiVIew];
    
    _whgsTabView = [[UITableView alloc] initWithFrame:CGRectMake(16, 136, SCREEN_WIDTH-32, SCREEN_HEIGHT-136-90) style:UITableViewStylePlain];
    _whgsTabView.dataSource = self;
    _whgsTabView.delegate = self;
    _whgsTabView.bounces = NO;
    _whgsTabView.layer.masksToBounds=YES;
    _whgsTabView.layer.cornerRadius=6;
    _whgsTabView.showsVerticalScrollIndicator=NO;
    _whgsTabView.backgroundColor=[UIColor whiteColor];
    _whgsTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_whGongSiVIew addSubview:_whgsTabView];
    [_whgsTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_whgsTabView registerNib:[UINib nibWithNibName:@"KindCell" bundle:nil] forCellReuseIdentifier:@"KindCell"];//xib定制cell
    
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
    _kdView.backgroundColor=[UIColor whiteColor];
    _kdView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_searchView addSubview:_kdView];
    [_kdView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_kdView registerNib:[UINib nibWithNibName:@"KindCell" bundle:nil] forCellReuseIdentifier:@"KindCell"];//xib定制cell
    
}

#pragma mark TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==_kdView||tableView==_maTabView) {
        return nil;
    }else{
        if (tableView==_whgsTabView) {
            UIView *secView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-32, secHig)];
            secView.backgroundColor=RGBCOLOR(10, 143, 255);
            
            UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 123, secHig)];
            lab1.text=@"维护公司";
            lab1.textColor=[UIColor whiteColor];
            lab1.textAlignment=NSTextAlignmentLeft;
            [secView addSubview:lab1];
            
            return secView;
        }else{
            UIView *secView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-32, secHig)];
            secView.backgroundColor=RGBCOLOR(10, 143, 255);
            
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-123-32, 0, 1, secHig)];
            line.backgroundColor=RGBCOLOR(92, 94, 102);
            [secView addSubview:line];
            
            UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 123, secHig)];
            lab1.text=@"定额";
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==_kdView||tableView==_maTabView) {
        return 0.0001;
    }else{
        return secHig;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_whgsTabView) {
        return [_whgsArr count];
        
    }else  if (tableView==_maTabView) {
        
        if (_sbNum==1) {
            return [_weizhiArr count];
            
        }else{
            return [_mingchenArr count];
            
        }
    }else    if (tableView==_kdView) {
        return [_equipKind count];
    }else{
        if (_dataArray.count==0) {
            return 1;
            
        }else{
            // return 20;
            return [_dataArray count];
            
        }
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_whgsTabView) {
        _whGongSiName.text=_whgsArr[indexPath.row][@"name"];
        
        [_shenpiDic setValue:_whgsArr[indexPath.row][@"name"] forKey:@"companyName"];
        [_shenpiDic setValue:_whgsArr[indexPath.row][@"id"] forKey:@"companyId"];
        [_shenpiDic setValue:_user[@"id"] forKey:@"loginid"];
        [_shenpiDic setValue:_user[@"username"] forKey:@"loginname"];
        [_shenpiDic setValue:_infor[@"id"] forKey:@"id"];
        [_shenpiDic setValue:@"待预算" forKey:@"state"];
        if ([_disAgreeText.text isEqualToString:@"请输入审批意见"]) {
            [_shenpiDic setValue:@"" forKey:@"backReason"];
            
        }else{
            [_shenpiDic setValue:_disAgreeText.text forKey:@"backReason"];
        }
        
    }else if (tableView==_maTabView) {
        [UIView animateWithDuration:0.3 animations:^{
            _maTabView.frame=CGRectMake(63, 126+_sbNum*48, SCREEN_WIDTH-79, 0);
        } completion:^(BOOL finished) {
            if (_sbNum==1) {
                _weizhi.text=_weizhiArr[indexPath.row][@"machine_place"];
                [self getSheBeiMingChengLieBiao:_weizhiArr[indexPath.row][@"machine_place"]];
                [_machineDic setObject:_weizhiArr[indexPath.row][@"machine_place"] forKey:@"locatinName"];
                _mingchen.text=@"请选择";
            }else{
                _mingchen.text=_mingchenArr[indexPath.row][@"machine_name"];
                [_machineDic setObject:_mingchenArr[indexPath.row][@"machine_name"] forKey:@"machineName"];
                [_machineDic setObject:_mingchenArr[indexPath.row][@"id"] forKey:@"machineId"];
                
            }
        }];
    }else if (tableView==_kdView) {
        [UIView animateWithDuration:0.3 animations:^{
            _kdView.frame=CGRectMake(16, 123, SCREEN_WIDTH-32, 0);
        } completion:^(BOOL finished) {
            _kindLab.text=_equipKind[indexPath.row];
        }];
    }else{
        if(_dataArray.count==0){
            
        }else{
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"您选择添加的定额是:%@\n级别:%@\n单价：%.2f\n数量:%@",_dataArray[indexPath.row][@"name"],_dataArray[indexPath.row][@"standard"],[_dataArray[indexPath.row][@"price"] floatValue],_numArray[indexPath.row]] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *calAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *sig=[NSString stringWithFormat:@"%.2f",[_dataArray[indexPath.row][@"price"] floatValue]*[_numArray[indexPath.row] floatValue]];
                NSMutableDictionary *deDIC=[NSMutableDictionary new];
                [deDIC setValue:@"" forKey:@"system"];
                [deDIC setValue:_kindLab.text forKey:@"category"];
                [deDIC setValue:_dataArray[indexPath.row][@"name"] forKey:@"machineName"];
                [deDIC setValue:_dataArray[indexPath.row][@"standard"] forKey:@"serviceLevel"];
                [deDIC setValue:_dataArray[indexPath.row][@"price"] forKey:@"price"];
                [deDIC setValue:_numArray[indexPath.row] forKey:@"serviceNum"];
                [deDIC setValue:sig forKey:@"singleTotal"];
                [deDIC setValue:@"" forKey:@"remarks"];
                [deDIC setValue:@"主要费用" forKey:@"type"];
                
                [_dingeArr addObject:deDIC];
                [self addFormViewCell:_dingeArr];
                [UIView animateWithDuration:0.3 animations:^{
                    _searchView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                } completion:^(BOOL finished) {
                    _kindLab.text=@"请选择";
                    [_dataArray removeAllObjects];
                    [_numArray removeAllObjects];
                    [_tableView reloadData];
                    _seaField.text=nil;
                }];
            }];
            [alertController addAction:calAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_whgsTabView) {
        KindCell *cell=[tableView dequeueReusableCellWithIdentifier:@"KindCell"];
        cell.backgroundColor=RGBCOLOR(255, 255, 255);
        cell.nameLab.text=_whgsArr[indexPath.row][@"name"];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (tableView==_maTabView) {
        KindCell *cell=[tableView dequeueReusableCellWithIdentifier:@"KindCell"];
        cell.backgroundColor=RGBCOLOR(255, 255, 255);
        if (_sbNum==1) {
            cell.nameLab.text=_weizhiArr[indexPath.row][@"machine_place"];
            
        }else{
            cell.nameLab.text=_mingchenArr[indexPath.row][@"machine_name"];
            
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (tableView==_kdView) {
        
        KindCell *cell=[tableView dequeueReusableCellWithIdentifier:@"KindCell"];
        cell.backgroundColor=RGBCOLOR(255, 255, 255);
        cell.nameLab.text=_equipKind[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if(_dataArray.count==0){
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.textLabel.text=@"没有搜索到相关设备";
            cell.backgroundColor=RGBCOLOR(255, 255, 255);
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            EquipCell *cell=[tableView dequeueReusableCellWithIdentifier:@"EquipCell"];
            cell.backgroundColor=RGBCOLOR(255, 255, 255);
            cell.nameLab.text=[NSString stringWithFormat:@"%@   %@   %.2f",_dataArray[indexPath.row][@"name"],_dataArray[indexPath.row][@"standard"],[_dataArray[indexPath.row][@"price"] floatValue]];
            cell.numLab.text=_numArray[indexPath.row];
            [cell setChangeNumAction:^(NSInteger sig) {
                NSLog(@"%ld,%ld",(long)sig,(long)indexPath.row);
                [_numArray replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%ld",(long)sig]];
            }];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_kdView||tableView==_maTabView) {
        return 50;
    }else{
        return 60;
    }
}


//Button Method
- (void)evalauteService{
    GDSQController *evavc=[[GDSQController alloc]init];
    evavc.user=[_user mutableCopy];
    evavc.infor=[_infor mutableCopy];
    [evavc setFinishedEvlaution:^(){
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navigationController pushViewController:evavc animated:YES];
}


- (IBAction)gongZuoDanTianBao:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    if (sender.tag==0) {
        timerLoca=0;
        [_fanweiPicker showDateTimePickerView];
    }else if (sender.tag==1) {
        timerLoca=1;
        [_jibiePicker showDateTimePickerView];
    }else if (sender.tag==2) {
        timerLoca=2;
        [_datePickerView showDateTimePickerView];
        
    }else if (sender.tag==3) {
        timerLoca=3;
        [_datePickerView showDateTimePickerView];
        
    }
}

#pragma mark - MyPicker delegate
-(void)didClickFinishMyPicker:(NSString *)str{
    // NSLog(@"%@",str);
    if (timerLoca==0) {
        [_fanwei setText:str];
    }
    if (timerLoca==1) {
        [_jibie setText:str];
    }
    
}
#pragma mark - DatePicker delegate
- (void)didClickFinishDateTimePickerView:(NSString *)date{
    NSLog(@"%@",date);
    if (timerLoca==2) {
        [_daodashijian setText:[NSString stringWithFormat:@"%@:00",date]];
    }
    if (timerLoca==3) {
        [_likaishijian setText:[NSString stringWithFormat:@"%@:00",date]];
    }
}

//撤回
- (IBAction)getSQBack:(id)sender {
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:_infor[@"deptid"] forKey:@"loginid"];
    [dic setValue:_infor[@"create_user"] forKey:@"loginname"];
    [dic setValue:_infor[@"id"] forKey:@"ids"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/del"] parameters:dic success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",dict);
        if ([dict[@"success"] integerValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"撤回成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"撤回失败！"];
        }
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"撤回失败！"];
        NSLog(@"%@",error);
        
    }];
    
}

//修改
- (IBAction)change:(id)sender {
    SQController *sqvc=[[SQController alloc]init];
    sqvc.infor=[_infor mutableCopy];
    sqvc.isChange=YES;
    sqvc.user=[_user mutableCopy];
    [sqvc setSuccessChange:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:sqvc animated:YES];
}

- (IBAction)disAgree:(id)sender {
    if ([self.kind isEqualToString:@"所"]) {
        if([_infor[@"audit_state"] isEqualToString:@"待审核"]) {
            NSLog(@"申请不通过");
            if (![_disAgreeText.text isEqualToString:@"请输入审批意见"]) {
                if ([_disAgreeText.text length]>2) {
                    [_shenpiDic setValue:@"" forKey:@"companyName"];
                    [_shenpiDic setValue:@"" forKey:@"companyId"];
                    [_shenpiDic setValue:_user[@"id"] forKey:@"loginid"];
                    [_shenpiDic setValue:_user[@"username"] forKey:@"loginname"];
                    [_shenpiDic setValue:_infor[@"id"] forKey:@"id"];
                    [_shenpiDic setValue:@"审核未通过" forKey:@"state"];
                    [_shenpiDic setValue:_disAgreeText.text forKey:@"backReason"];
                    [self uploadShenQingShenPi];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"意见过短！"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"意见不能为空！"];
            }
        }else{
            NSLog(@"预算不通过");
            if (![_ysOption.text isEqualToString:@"请输入审批意见"]) {
                if ([_disAgreeText.text length]>2) {
                    [_shenpiDic setValue:_infor[@"company_name"] forKey:@"companyName"];
                    [_shenpiDic setValue:_infor[@"company_id"] forKey:@"companyId"];
                    [_shenpiDic setValue:_user[@"id"] forKey:@"loginid"];
                    [_shenpiDic setValue:_user[@"username"] forKey:@"loginname"];
                    [_shenpiDic setValue:_infor[@"id"] forKey:@"id"];
                    [_shenpiDic setValue:@"预算未通过" forKey:@"state"];
                    [_shenpiDic setValue:_ysOption.text forKey:@"backReason"];
                    [self uploadShenQingShenPi];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"意见过短！"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"意见不能为空！"];
            }
        }
    }
    
    
    if ([self.kind isEqualToString:@"处"]) {
        NSLog(@"处--预算不通过");
        if (![_chuDisOption.text isEqualToString:@"请输入审批意见"]) {
            if ([_chuDisOption.text length]>2) {
                NSMutableDictionary *dic=[NSMutableDictionary new];
                [dic setValue:_infor[@"company_name"] forKey:@"companyName"];
                [dic setValue:_infor[@"company_id"] forKey:@"companyId"];
                [dic setValue:_user[@"id"] forKey:@"loginid"];
                [dic setValue:_user[@"username"] forKey:@"loginname"];
                [dic setValue:_infor[@"id"] forKey:@"id"];
                [dic setValue:@"预算处级未通过" forKey:@"state"];
                [dic setValue:_chuDisOption.text forKey:@"backReason"];
                [self UploadChuJuShenPi:dic Url:[NSString stringWithFormat:URLHOST,@"appApply/checkTwo"]];
            }else{
                [SVProgressHUD showErrorWithStatus:@"意见过短！"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"意见不能为空！"];
        }
    }
    if ([self.kind isEqualToString:@"局"]) {
        NSLog(@"局--预算不通过");
        if (![_juDisOption.text isEqualToString:@"请输入审批意见"]) {
            if ([_juDisOption.text length]>2) {
                NSMutableDictionary *dic=[NSMutableDictionary new];
                [dic setValue:_infor[@"company_name"] forKey:@"companyName"];
                [dic setValue:_infor[@"company_id"] forKey:@"companyId"];
                [dic setValue:_user[@"id"] forKey:@"loginid"];
                [dic setValue:_user[@"username"] forKey:@"loginname"];
                [dic setValue:_infor[@"id"] forKey:@"id"];
                [dic setValue:@"预算局级未通过" forKey:@"state"];
                [dic setValue:_juDisOption.text forKey:@"backReason"];
                [self UploadChuJuShenPi:dic Url:[NSString stringWithFormat:URLHOST,@"appApply/checkThree"]];
            }else{
                [SVProgressHUD showErrorWithStatus:@"意见过短！"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"意见不能为空！"];
        }
    }
    
}


- (IBAction)agree:(id)sender {
    if ([self.kind isEqualToString:@"所"]) {
        if([_infor[@"audit_state"] isEqualToString:@"待审核"]) {
            NSLog(@"申请通过");
            [UIView animateWithDuration:0.3 animations:^{
                _whGongSiVIew.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
        }else{
            NSLog(@"预算通过");
            [_shenpiDic setValue:_infor[@"company_name"] forKey:@"companyName"];
            [_shenpiDic setValue:_infor[@"company_id"] forKey:@"companyId"];
            [_shenpiDic setValue:_user[@"id"] forKey:@"loginid"];
            [_shenpiDic setValue:_user[@"username"] forKey:@"loginname"];
            [_shenpiDic setValue:_infor[@"id"] forKey:@"id"];
            
            if ([_infor[@"maintenance_type"] isEqualToString:@"未超额"]) {
                [_shenpiDic setValue:@"已通过" forKey:@"state"];
            }else{
                [_shenpiDic setValue:@"已预算一审" forKey:@"state"];
            }
            
            if ([_ysOption.text isEqualToString:@"请输入审批意见"]) {
                [_shenpiDic setValue:@"" forKey:@"backReason"];
            }else{
                [_shenpiDic setValue:_ysOption.text forKey:@"backReason"];
            }
            [self uploadShenQingShenPi];
        }
    }
    
    if ([self.kind isEqualToString:@"处"]) {
        NSLog(@"处---预算通过");
        NSMutableDictionary *dic=[NSMutableDictionary new];
        [dic setValue:_infor[@"company_name"] forKey:@"companyName"];
        [dic setValue:_infor[@"company_id"] forKey:@"companyId"];
        [dic setValue:_user[@"id"] forKey:@"loginid"];
        [dic setValue:_user[@"username"] forKey:@"loginname"];
        [dic setValue:_infor[@"id"] forKey:@"id"];
        if ([_infor[@"maintenance_type"] isEqualToString:@"超额二级"]) {
            [dic setValue:@"已通过" forKey:@"state"];
        }else{
            [dic setValue:@"已预算二审" forKey:@"state"];
        }
        if ([_chuDisOption.text isEqualToString:@"请输入审批意见"]) {
            [dic setValue:@"" forKey:@"backReason"];
        }else{
            [dic setValue:_chuDisOption.text forKey:@"backReason"];
        }
        [self UploadChuJuShenPi:dic Url:[NSString stringWithFormat:URLHOST,@"appApply/checkTwo"]];
        
    }
    if ([self.kind isEqualToString:@"局"]) {
        NSLog(@"局---预算通过");
        NSMutableDictionary *dic=[NSMutableDictionary new];
        [dic setValue:_infor[@"company_name"] forKey:@"companyName"];
        [dic setValue:_infor[@"company_id"] forKey:@"companyId"];
        [dic setValue:_user[@"id"] forKey:@"loginid"];
        [dic setValue:_user[@"username"] forKey:@"loginname"];
        [dic setValue:_infor[@"id"] forKey:@"id"];
        [dic setValue:@"已通过" forKey:@"state"];
        if ([_juDisOption.text isEqualToString:@"请输入审批意见"]) {
            [dic setValue:@"" forKey:@"backReason"];
        }else{
            [dic setValue:_juDisOption.text forKey:@"backReason"];
        }
        [self UploadChuJuShenPi:dic Url:[NSString stringWithFormat:URLHOST,@"appApply/checkThree"]];
    }
}

- (void)UploadChuJuShenPi:(NSMutableDictionary *)dic Url:(NSString *)url{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"success"] intValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"审批成功！"];

        }else{
            [SVProgressHUD showErrorWithStatus:@"审批失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"审批失败！"];
    }];
    
}

//确认评价----确认上级不同意意见
- (IBAction)allProgressIsOK:(id)sender {
    if ([self.kind isEqualToString:@"所"]) {
        if ([_infor[@"audit_state"] isEqualToString:@"待确认"]) {
            [self suoQueRenPingJia];
        }else{
            [_shenpiDic setValue:_infor[@"company_name"] forKey:@"companyName"];
            [_shenpiDic setValue:_infor[@"company_id"] forKey:@"companyId"];
            [_shenpiDic setValue:_user[@"id"] forKey:@"loginid"];
            [_shenpiDic setValue:_user[@"username"] forKey:@"loginname"];
            [_shenpiDic setValue:_infor[@"id"] forKey:@"id"];
            [_shenpiDic setValue:@"预算未通过" forKey:@"state"];
            [_shenpiDic setValue:_ysOption.text forKey:@"backReason"];
            [self uploadShenQingShenPi];
        }
    }
    
    if ([self.kind isEqualToString:@"处"]) {
        NSMutableDictionary *dic=[NSMutableDictionary new];
        [dic setValue:_infor[@"company_name"] forKey:@"companyName"];
        [dic setValue:_infor[@"company_id"] forKey:@"companyId"];
        [dic setValue:_user[@"id"] forKey:@"loginid"];
        [dic setValue:_user[@"username"] forKey:@"loginname"];
        [dic setValue:_infor[@"id"] forKey:@"id"];
        [dic setValue:@"预算处级未通过" forKey:@"state"];
        [dic setValue:_chuDisOption.text forKey:@"backReason"];
        [self UploadChuJuShenPi:dic Url:[NSString stringWithFormat:URLHOST,@"appApply/checkTwo"]];
    }
}

- (void)suoQueRenPingJia{
    NSMutableDictionary *okDic=[NSMutableDictionary new];
    [okDic setValue:_infor[@"company_name"] forKey:@"companyName"];
    [okDic setValue:_infor[@"company_id"] forKey:@"companyId"];
    [okDic setValue:_user[@"id"] forKey:@"loginid"];
    [okDic setValue:_user[@"username"] forKey:@"loginname"];
    [okDic setValue:_infor[@"id"] forKey:@"id"];
    [okDic setValue:@"已确认" forKey:@"state"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/updateState"] parameters:okDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // NSLog(@"--%@",dic);
        if ([dic[@"success"] intValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"确认成功！"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"确认失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"确认失败！"];
    }];
}


- (IBAction)uploadDinge:(id)sender {
    if (isChange) {
        
        [self upLoadDingeAndEquip];
        
    }else{
        if ([_infor[@"audit_state"] isEqualToString:@"待预算"]) {
            [self upLoadDingeAndEquip];
        }if ([_infor[@"audit_state"] isEqualToString:@"已通过"]) {
            if (![_fanwei.text isEqualToString:@"请选择"]) {
                if (![_jibie.text isEqualToString:@"请选择"]) {
                    if (![_daodashijian.text isEqualToString:@"请选择"]) {
                        if (![_likaishijian.text isEqualToString:@"请选择"]) {
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *arr=[dateFormatter dateFromString:_daodashijian.text];
                            NSDate *lev=[dateFormatter dateFromString:_likaishijian.text];
                            NSTimeInterval arrInt = [arr timeIntervalSince1970];
                            NSTimeInterval leaInt = [lev timeIntervalSince1970];
                            NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
                            
                            if (arrInt<leaInt&&now>=leaInt) {
                                NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                                [dict setValue:_user[@"id"] forKey:@"loginid"];
                                [dict setValue:_user[@"username"] forKey:@"loginname"];
                                [dict setValue:_infor[@"id"] forKey:@"pid"];
                                [dict setValue:_fanwei.text forKey:@"serviceArea"];
                                [dict setValue:_jibie.text forKey:@"serviceLevel"];
                                
                                [dict setValue:_daodashijian.text forKey:@"arriveTime"];
                                [dict setValue:_likaishijian.text forKey:@"leaveTime"];
                                
                                [dict setValue:[NSString HourstimeBegin:_infor[@"create_time"] timeEnd:_daodashijian.text] forKey:@"respondTime"];
                                [dict setValue:[NSString HourstimeBegin:_daodashijian.text timeEnd:_likaishijian.text] forKey:@"repairtTime"];
                                
                                [dict setObject:[self toJSONString:_dingeArr] forKey:@"obj"];
                                [dict setObject:@"" forKey:@"objOther"];
                                
                                if (![_yiliuwenti.text isEqualToString:@"描述维护过程"]) {
                                    [dict setValue:_yiliuwenti.text forKey:@"machineState"];
                                }else{
                                    [dict setValue:@"" forKey:@"machineState"];
                                }
                                
                                NSLog(@"---%@",dict);
                                [self uploadGongdan:dict];
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"时间填写错误！"];
                            }
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"请选择离开时间！"];
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"请选择到达时间！"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请选择维护级别！"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请选择维护范围！"];
            }
        }
        
    }
}

- (IBAction)search:(id)sender {
    if (![_kindLab.text isEqualToString:@"请选择"]) {
        if (_seaField.text.length>0) {
            [_seaField resignFirstResponder];
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:_kindLab.text forKey:@"subsystem"];
            [dict setValue:_seaField.text forKey:@"name"];
            AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
            manger.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            manger.requestSerializer.timeoutInterval = 20.f;
            [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/getMachineName"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                [_numArray removeAllObjects];
                [_dataArray removeAllObjects];
                if (dic.count>0) {
                    for (NSDictionary *dict in dic) {
                        [_dataArray addObject:dict];
                        [_numArray addObject:@"1"];
                    }
                    
                    [_tableView reloadData];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"未搜索到结果！"];
                    
                }
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                [SVProgressHUD showErrorWithStatus:@"搜索失败！"];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"搜索关键字不能为空！"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请先选择设备分类！"];
    }
}
- (IBAction)showList:(id)sender {
    if (_kdView.frame.size.height==0) {
        [UIView animateWithDuration:0.3 animations:^{
            _kdView.frame=CGRectMake(16, 123, SCREEN_WIDTH-32, 200);
            
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _kdView.frame=CGRectMake(16, 123, SCREEN_WIDTH-32, 0);
            
        }];
    }
}
- (IBAction)cancleSearchView:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _searchView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        _kindLab.text=@"请选择";
        [_dataArray removeAllObjects];
        [_numArray removeAllObjects];
        [_tableView reloadData];
        _seaField.text=nil;
    }];
}


- (IBAction)chooseMachine:(UIButton *)sender {
    if (sender.tag==_sbNum) {
        if (_maTabView.frame.size.height>0) {
            [UIView animateWithDuration:0.3 animations:^{
                _maTabView.frame=CGRectMake(63, 126+sender.tag*48, SCREEN_WIDTH-79, 0);
            } completion:^(BOOL finished) {
                
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                _maTabView.frame=CGRectMake(63, 126+sender.tag*48, SCREEN_WIDTH-79,240);
            } completion:^(BOOL finished) {
            }];
        }
    }else{
        if (sender.tag==2&&[_weizhi.text isEqualToString:@"请选择"]) {
            [SVProgressHUD showErrorWithStatus:@"请先选择位置！"];
            
        }else{
            if (_maTabView.frame.size.height>0) {
                
                [UIView animateWithDuration:0.2 animations:^{
                    _maTabView.frame=CGRectMake(63, 126+_sbNum*48, SCREEN_WIDTH-79, 0);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.0 animations:^{
                        _maTabView.frame=CGRectMake(63, 126+sender.tag*48, SCREEN_WIDTH-79, 0);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                            _maTabView.frame=CGRectMake(63, 126+sender.tag*48, SCREEN_WIDTH-79, 240);
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }else{
                [UIView animateWithDuration:0.0 animations:^{
                    _maTabView.frame=CGRectMake(63, 126+sender.tag*48, SCREEN_WIDTH-79, 0);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        _maTabView.frame=CGRectMake(63, 126+sender.tag*48, SCREEN_WIDTH-79, 240);
                    } completion:^(BOOL finished) {
                        
                    }];
                }];
            }
            _sbNum=sender.tag;
            [_maTabView reloadData];
            
        }
    }
}
- (IBAction)sureSelectMeachine:(id)sender {
    
    if ( ![_weizhi.text isEqualToString:@"请选择"]) {
        if (![_mingchen.text isEqualToString:@"请选择"]) {
            NSMutableDictionary *ddd=[NSMutableDictionary new];
            [ddd setObject:_infor[@"deptid"] forKey:@"deptId"];
            [ddd setObject:_infor[@"customer"] forKey:@"deptName"];
            [ddd setObject:_machineDic[@"locatinName"] forKey:@"locatinName"];
            [ddd setObject:_machineDic[@"machineName"] forKey:@"machineName"];
            [ddd setObject:_machineDic[@"machineId"] forKey:@"machineId"];
            
            [_equipArr addObject:ddd];
            
            [UIView animateWithDuration:0.3 animations:^{
                _chooseMachineView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                _maTabView.frame=CGRectMake(63, 126+_sbNum*48, SCREEN_WIDTH-79, 0);
            } completion:^(BOOL finished) {
                _weizhi.text=@"请选择";
                _mingchen.text=@"请选择";
                _sbNum=1;
                _maTabView.frame=CGRectMake(63, 126+_sbNum*48, SCREEN_WIDTH-79, 0);
                [_maTabView reloadData];
            }];
            
            [self addSheBeiViewCell:_equipArr];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请选择设备名称！"];
            
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请选择位置！"];
        
    }
}

- (IBAction)cancleMachineView:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _chooseMachineView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        _maTabView.frame=CGRectMake(63, 126+_sbNum*48, SCREEN_WIDTH-79, 0);
    } completion:^(BOOL finished) {
        _weizhi.text=@"请选择";
        _mingchen.text=@"请选择";
        _sbNum=1;
        _maTabView.frame=CGRectMake(63, 126+_sbNum*48, SCREEN_WIDTH-79, 0);
        [_maTabView reloadData];
    }];
}

- (IBAction)cancleWeiHuGongSiView:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _whGongSiVIew.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        _whGongSiName.text=@"请选择";
        
    }];
}

- (IBAction)sureWeiHuGongSi:(id)sender {
    [self uploadShenQingShenPi];
}

- (void)uploadShenQingShenPi{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/checkOne"] parameters:_shenpiDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // NSLog(@"--%@",dic);
        
        if ([dic[@"success"] intValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"审批成功！"];
            [UIView animateWithDuration:0.3 animations:^{
                _whGongSiVIew.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                _whGongSiName.text=@"请选择";
            } completion:^(BOOL finished) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"审批失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"审批失败！"];
    }];
}

#pragma mark--HTTP Request
//上报工作单
- (void)uploadGongdan:(NSMutableDictionary *)dict{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/updateSheet"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"success"] intValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"工作单上报成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"工作单上报失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"工作单上报失败！"];
    }];
}
//上报设备和定额信息
- (void)upLoadDingeAndEquip{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:_user[@"id"] forKey:@"loginid"];
    [dict setValue:_user[@"username"] forKey:@"loginname"];
    [dict setValue:_infor[@"id"] forKey:@"id"];
    [dict setValue:_infor[@"station"] forKey:@"stationName"];
    [dict setValue:_infor[@"customer"] forKey:@"userName"];
    [dict setValue:_infor[@"deptid"] forKey:@"userId"];
    [dict setObject:[NSString stringWithFormat:@"%@",_infor[@"machine_state"]] forKey:@"fault"];
    [dict setValue:_infor[@"service_address"] forKey:@"lcationName"];
    [dict setValue:@"" forKey:@"deviceName"];
    [dict setValue:@"" forKey:@"deviceModel"];
    [dict setValue:_infor[@"servicing"] forKey:@"service"];
    [dict setObject:[self toJSONString:_dingeArr] forKey:@"obj"];
    [dict setObject:@"" forKey:@"objOther"];
    [dict setObject:[self toJSONString:_equipArr] forKey:@"objMachine"];
    [dict setValue:_infor[@"code"] forKey:@"numCard"];
    if (_ceStatue==0) {
        [dict setValue:@"未超额" forKey:@"maintenanceType"];
    }else if (_ceStatue==2) {
        [dict setValue:@"超额二级" forKey:@"maintenanceType"];
    }else if (_ceStatue==3) {
        [dict setValue:@"超额三级" forKey:@"maintenanceType"];
    }
    [dict setValue:@"已预算" forKey:@"state"];
    
    // NSLog(@"=====%@",dict);
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/saveOrUpdateSheet"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"success"] intValue]==1) {
            [SVProgressHUD showSuccessWithStatus:@"预算上报成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"预算报传失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"预算上报失败！"];
    }];
}

//设备种类列表
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
        
        [_equipKind removeAllObjects];
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
                                        [_equipKind addObject:dic6[@"name"]];
                                    }
                                }
                            }else{
                                [_equipKind addObject:dic4[@"name"]];
                            }
                        }
                    }else{
                        [_equipKind addObject:dic2[@"name"]];
                    }
                }
            }else{
                [_equipKind addObject:dic1[@"name"]];
            }
        }
        [_kdView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"设备分类获取失败！"];
    }];
    
}

//维护公司列表
- (void)getWeiHuGongSiList{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/companyListBox"] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic.count>0) {
            [_whgsArr removeAllObjects];
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
                                            [_whgsArr addObject:dic6];
                                        }
                                    }
                                }else{
                                    [_whgsArr addObject:dic4];
                                }
                            }
                        }else{
                            [_whgsArr addObject:dic2];
                        }
                    }
                }else{
                    [_whgsArr addObject:dic1];
                }
            }
            [_whgsTabView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"维护公司获取失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"维护公司获取失败！"];
    }];
    
}

//设备定额列表
- (void)getDingEList{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:_infor[@"id"] forKey:@"pid"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/getListByPid"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        [_dingeArr removeAllObjects];
        
        //NSLog(@"--定额%@",dic);
        
        for (NSDictionary *dict in dic) {
            NSMutableDictionary *deDIC=[NSMutableDictionary new];
            [deDIC setValue:@"" forKey:@"system"];
            [deDIC setValue:dict[@"category"] forKey:@"category"];
            [deDIC setValue:dict[@"machine_name"] forKey:@"machineName"];
            [deDIC setValue:dict[@"service_level"] forKey:@"serviceLevel"];
            [deDIC setValue:dict[@"price"] forKey:@"price"];
            [deDIC setValue:dict[@"service_num"] forKey:@"serviceNum"];
            [deDIC setValue:dict[@"single_total"] forKey:@"singleTotal"];
            [deDIC setValue:dict[@"remarks"] forKey:@"remarks"];
            [deDIC setValue:dict[@"type"] forKey:@"type"];
            [_dingeArr addObject:deDIC];
        }
        [self addFormViewCell:_dingeArr];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"定额信息获取失败！"];
    }];
    
}

//设备列表
- (void)getSheBeiList{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:_infor[@"id"] forKey:@"pid"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/getListMachineByPid"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [_equipArr removeAllObjects];
        NSLog(@"slsllsls%@",dic);
        if (dic.count>0) {
            for (NSDictionary *dict in dic) {
                NSMutableDictionary *deDIC=[NSMutableDictionary new];
                [deDIC setValue:dict[@"dept_name"] forKey:@"deptName"];
                [deDIC setValue:dict[@"machine_name"] forKey:@"machineName"];
                [deDIC setValue:dict[@"dept_id"] forKey:@"deptId"];
                [deDIC setValue:dict[@"location_name"] forKey:@"locatinName"];
                [deDIC setValue:dict[@"machine_id"] forKey:@"machineId"];
                [_equipArr addObject:deDIC];
            }
        }else{
            // [SVProgressHUD showErrorWithStatus:@"设备列表获取失败！"];
            
        }
        [self addSheBeiViewCell:_equipArr];
        // NSLog(@"--设备%@",_equipArr);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"设备列表获取失败！"];
    }];
    
}

//位置列表
- (void)getSheBeiWeiZhiLieBiao{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:_infor[@"deptid"] forKey:@"deptId"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/getLocationByDeptName"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [_weizhiArr removeAllObjects];
        if (dic.count>0) {
            for (NSDictionary *dict in dic) {
                [_weizhiArr addObject:dict];
            }
            [_maTabView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"位置列表获取失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"位置列表获取失败！"];
    }];
}

//名称列表
- (void)getSheBeiMingChengLieBiao:(NSString *)loca{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:_infor[@"deptid"] forKey:@"deptId"];
    [dict setValue:loca forKey:@"location"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manger.requestSerializer.timeoutInterval = 20.f;
    [manger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [SVProgressHUD showWithStatus:@"该位置名称设备获取中..."  maskType:SVProgressHUDMaskTypeGradient];
    
    [manger POST:[NSString stringWithFormat:URLHOST,@"appApply/getMachineByDeptLoc"] parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [_mingchenArr removeAllObjects];
        NSLog(@"sslsl%@",dic);
        
        if (dic.count>0) {
            [SVProgressHUD showSuccessWithStatus:@"名称列表获取成功！"];
            
            for (NSDictionary *dict in dic) {
                [_mingchenArr addObject:dict];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"名称列表获取失败！"];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"名称列表获取失败！"];
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
    if (textView==_juDisOption) {
        if([_juDisOption.text isEqualToString:@"请输入审批意见"]){
            _juDisOption.text=@"";
            _juDisOption.textColor=[UIColor blackColor];
            
            _scroller.contentOffset=CGPointMake(0, _juOption.frame.origin.y-(SCREEN_HEIGHT-74-fW-kHig)+juHig);

        }
    } if (textView==_chuDisOption) {
        if([_chuDisOption.text isEqualToString:@"请输入审批意见"]){
            _chuDisOption.text=@"";
            _chuDisOption.textColor=[UIColor blackColor];
            
            _scroller.contentOffset=CGPointMake(0, _chuOption.frame.origin.y-(SCREEN_HEIGHT-74-fW-kHig)+chuHig);

        }
    }if (textView==_disAgreeText) {
        if([_disAgreeText.text isEqualToString:@"请输入审批意见"]){
            _disAgreeText.text=@"";
            _disAgreeText.textColor=[UIColor blackColor];
            
            _scroller.contentOffset=CGPointMake(0, _disAgree.frame.origin.y-(SCREEN_HEIGHT-74-fW-kHig)+disAgreeHig);

            
        }
    }
    if (textView==_ysOption) {
        if([_ysOption.text isEqualToString:@"请输入审批意见"]){
            _ysOption.text=@"";
            _ysOption.textColor=[UIColor blackColor];
            
            _scroller.contentOffset=CGPointMake(0, _yusuanShenpi.frame.origin.y-(SCREEN_HEIGHT-74-fW-kHig)+optionHig);
            
        }
    }
    if (textView==_yiliuwenti) {
        if([_yiliuwenti.text isEqualToString:@"描述维护过程"]){
            _yiliuwenti.text=@"";
            _yiliuwenti.textColor=[UIColor blackColor];
            
            _scroller.contentOffset=CGPointMake(0, _gongDanView.frame.origin.y-(SCREEN_HEIGHT-74-fW-kHig)+gongDanHig);
            
        }
        
    }
    if (_scroller.frame.size.height!=SCREEN_HEIGHT-74-fW-kHig) {
        [UIView animateWithDuration:0.5 animations:^{
            _scroller.frame=CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74-fW-kHig);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView==_yiliuwenti) {
        if(_yiliuwenti.text.length < 1){
            _yiliuwenti.text = @"描述维护过程";
            _yiliuwenti.textColor = [UIColor lightGrayColor];
        }
        
    }else{
        if(textView.text.length < 1){
            textView.text = @"请输入审批意见";
            textView.textColor = [UIColor lightGrayColor];
        }
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

#pragma mark ----showActionSheet
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



- (NSString *)toJSONString:(NSMutableArray *)arr {
    NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
