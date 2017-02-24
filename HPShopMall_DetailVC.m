
#import "HPShopMall_DetailVC.h"
#import "HP_SMDetailCell.h"
#import "UINavigationBar+Awesome.h"
#import "CountDown.h"
#import "RequestUtil.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "ProductModel.h"
#import "LaoKRefeshHeader.h"
#import "LaoKNavigationController.h"
#import "GFWhatPlatConsignVC.h"
#import "HPSM_AuctionRecordController.h"
#import "User.h"
#import <UIImageView+WebCache.h>
#import "GFDepositPayVC.h"
#import "NSDictionary+ValueNoNull.h"
#import "GFLoginController.h"
#import "GFShareTool.h"
#import "GFVerifyPhoneNumVC.h"
#import <WebKit/WebKit.h>
//*****************************************************************************************//
@interface BuyBZJView : UIView

/**<##>购买保证金按钮 */
@property(nonatomic,strong)UIButton * buyBZJButton;

@end


@implementation BuyBZJView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 50 *LaokRatio)];
    if (self) {
        [self setbuyBaozhengjin];
        self.backgroundColor = ThemeBackGroundColor;
    }
    return self;
}

- (void)setbuyBaozhengjin
{
    _buyBZJButton = [[UIButton alloc] init];
    _buyBZJButton.customBackGrandColor = ThemeBtnBrownColor;
    _buyBZJButton.nomalColor = [UIColor whiteColor];
    [self addSubview:_buyBZJButton];
    
    _buyBZJButton.sd_layout.centerYEqualToView(self).centerXEqualToView(self).heightIs(36 *LaokRatio).widthIs(345 *LaokRatio);
    _buyBZJButton.sd_cornerRadiusFromHeightRatio = @(0.1);
//    _buyBZJButton.titleLabel.font = [Font fontWithType:2 size:28];
}

@end
//*****************************************************************************************//






//*****************************************************************************************//
@interface ChujiaView : UIView

/**<##>关闭按钮 */
@property(nonatomic,strong)UIButton * openBtn;
/**<##>关闭背景按钮 */
@property(nonatomic,strong)UIButton * backOpenBtn;
/** 出价按钮 */
@property(nonatomic,strong)UIButton * chujiaButton;
/**<##>图片 */
@property(nonatomic,strong)UIImageView * paipinView;
/**<##>当前价 */
@property(nonatomic,strong)UILabel * dangqianPriceLB;
/**<##>加价幅度 */
@property(nonatomic,strong)UILabel * fuduPriceLB;

/**当前的加价 */
@property(nonatomic,weak)UILabel * jiajiaPriceLB;
/**<##>模型 */
@property(nonatomic,strong)ProductModel * chujiaModel;

/**当前价 */
@property(nonatomic,assign)CGFloat  dangqianPrice;

/**<##>底部 */
@property(nonatomic,strong)UIView * bottomView;

@end


@implementation ChujiaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setchujia];
        self.backgroundColor = [LaokColor(@"#000000") colorWithAlphaComponent:0.6];
    }
    return self;
}


- (void)setChujiaModel:(ProductModel *)chujiaModel
{
    _chujiaModel = chujiaModel;
    NSURL *url = [NSURL URLWithString:chujiaModel.img];
 
    [self.paipinView sd_setImageWithURL:url placeholderImage:ListPlaceHolderImage];
    self.fuduPriceLB.text =[NSString stringWithFormat:@"加价幅度 ¥%.00f",chujiaModel.offset];
    self.dangqianPriceLB.text = chujiaModel.winnerPrice.length > 0 ? [NSString stringWithFormat:@"当前价 ¥%@",chujiaModel.winnerPrice] : [NSString stringWithFormat:@"当前价 ¥%@",chujiaModel.price];
    self.dangqianPrice = chujiaModel.winnerPrice.length > 0 ?chujiaModel.winnerPrice.floatValue: chujiaModel.price.floatValue;
    
    self.jiajiaPriceLB.text = [NSString stringWithFormat:@"%.00f",chujiaModel.offset + self.dangqianPrice];

}

- (void)setchujia
{
    _bottomView = [[UIView alloc] init];
    _backOpenBtn = [[UIButton alloc] init];
    _backOpenBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_backOpenBtn];
    [self addSubview:_bottomView];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _backOpenBtn.sd_layout.topEqualToView(self).leftEqualToView(self).rightEqualToView(self).bottomSpaceToView(self,238 *LaokRatio);
    _bottomView.sd_layout.leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightIs(238 *LaokRatio);
    
    
    _openBtn = [[UIButton alloc] init];
    [_openBtn setBackgroundImage:[UIImage imageNamed:@"spaceBtn"] forState:UIControlStateNormal];
    
    _paipinView = [[UIImageView alloc] init];
    
    _paipinView.sd_cornerRadiusFromHeightRatio = @(0.1);
    _paipinView.clipsToBounds = YES;
    _paipinView.contentMode = UIViewContentModeScaleAspectFill;
    
    _paipinView.layer.borderWidth = 2;
    _paipinView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    _dangqianPriceLB = [[UILabel alloc] init];
    _dangqianPriceLB.textColor = ThemeRedColor;
    _dangqianPriceLB.font =[Font fontWithType:2 size:32];
    
    
    _fuduPriceLB = [[UILabel alloc] init];
    _fuduPriceLB.textColor = LaokColor(@"#333333");
    _fuduPriceLB.font = [Font fontWithType:2 size:24];
    
    
    UILabel * jiajiaLB = [[UILabel alloc] init];
    jiajiaLB.text = @"加价金额";
    jiajiaLB.font = [Font fontWithType:2 size:24];
    jiajiaLB.textColor = LaokColor(@"#333333");

    UIButton * reduceBtn = [[UIButton alloc] init];
    [reduceBtn setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
    UIButton * addBtn = [[UIButton alloc] init];
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    
    UILabel * chujiaPriceLB = [[UILabel alloc] init];
    self.jiajiaPriceLB = chujiaPriceLB;
    chujiaPriceLB.text = @"8888";
    chujiaPriceLB.textColor = ThemeRedColor;
    chujiaPriceLB.font = [Font fontWithType:2 size:32];
    chujiaPriceLB.textAlignment = 1;

    _chujiaButton = [[UIButton alloc] init];
    _chujiaButton.backgroundColor = ThemeBtnRedColor;
    _chujiaButton.normalText = @"确认出价";
    
    [_bottomView sd_addSubviews:@[_openBtn,_paipinView,_dangqianPriceLB,_fuduPriceLB,jiajiaLB,reduceBtn,chujiaPriceLB,addBtn,_chujiaButton]];
    _openBtn.sd_layout.rightSpaceToView(_bottomView,8 * LaokRatio).topSpaceToView(_bottomView,8 *LaokRatio).heightIs(20 *LaokRatio).widthEqualToHeight();
    //布局
    _paipinView.sd_layout.leftSpaceToView(_bottomView,13 *LaokRatio).topSpaceToView(_bottomView, -25 * LaokRatio).heightIs(114 *LaokRatio).widthEqualToHeight();
    _paipinView.image = [UIImage imageNamed:@"2"];
    
    _dangqianPriceLB.sd_layout.leftSpaceToView(_paipinView,15 *LaokRatio).topSpaceToView(_bottomView,30 *LaokRatio).widthIs(150 *LaokRatio).autoHeightRatio(0);
    
    _dangqianPriceLB.text = @"当前价";
    
    _fuduPriceLB.sd_layout.topSpaceToView(_dangqianPriceLB,10 *LaokRatio).leftEqualToView(_dangqianPriceLB).widthIs(150 *LaokRatio).autoHeightRatio(0);
    _fuduPriceLB.text = @"加价幅度";
    
    jiajiaLB.sd_layout.topSpaceToView(_paipinView,43 *LaokRatio).leftSpaceToView(_bottomView,15 *LaokRatio).widthIs(100*LaokRatio).heightIs(22 *LaokRatio);
    
    addBtn.sd_layout.rightSpaceToView(_bottomView, 15 *LaokRatio).topEqualToView(jiajiaLB).heightIs(22 *LaokRatio).widthEqualToHeight();
    
    chujiaPriceLB.sd_layout.rightSpaceToView(addBtn,0).topEqualToView(addBtn).widthIs(110 *LaokRatio).heightIs(22 *LaokRatio);
    
    reduceBtn.sd_layout.rightSpaceToView(chujiaPriceLB,0).topEqualToView(addBtn).heightIs(22 * LaokRatio).widthEqualToHeight();
    
    //减
    LKWeak
    [[reduceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LKStrong
        CGFloat cj = self.jiajiaPriceLB.text.floatValue;
        if(self.jiajiaPriceLB.text.floatValue <= self.dangqianPrice + self.chujiaModel.offset)
        {
            return ;
        }
        self.jiajiaPriceLB.text = [NSString stringWithFormat:@"%.00f",cj - self.chujiaModel.offset];
        
        
    }];
    
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LKStrong
        CGFloat cj = self.jiajiaPriceLB.text.floatValue;
        self.jiajiaPriceLB.text = [NSString stringWithFormat:@"%.00f",cj + self.chujiaModel.offset];
    }];
    
    _chujiaButton.sd_layout.centerXEqualToView(_bottomView).bottomSpaceToView(_bottomView,7 *LaokRatio).widthIs(345 *LaokRatio).heightIs(36 *LaokRatio);
    _chujiaButton.sd_cornerRadiusFromHeightRatio = @(0.1);
//    _chujiaButton.titleLabel.font = [Font fontWithType:2 size:28];
}

@end
//*****************************************************************************************//

@interface HPShopMall_DetailVC ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
/**baseView */
@property(nonatomic,strong)UITableView * baseView;
/**<##>倒计时 */
@property(nonatomic,strong)CountDown * countDown;

/** 确保不在加载  */
@property(nonatomic,assign)NSInteger  refreshIndex;


/**<##>数据 */
@property(nonatomic,strong)NSArray * baseDatas;

@property (nonatomic, strong) UIImage *shadowImage;

/** 保证金View */
@property(nonatomic,strong)BuyBZJView * bzjView;

/**<##>出价界面 */
@property(nonatomic,strong)ChujiaView * chujiaview;



/**是否结束的标记 */
@property(nonatomic,copy)NSString * endStr;

/**<##>webview */
@property(nonatomic,strong)UIWebView * detailWebView;

@property(nonatomic, assign)NSInteger updata;
@end

@implementation HPShopMall_DetailVC

- (NSArray *)baseDatas
{
    if(_baseDatas==nil)
    {
        _baseDatas = [NSArray array];
    }
    return _baseDatas;
}





-(void)newMessageTips{
    [self setNetData];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setbaseView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //每秒调用一次倒计时
    _countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    ///每秒回调一次
    [_countDown countDownWithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];
    
    _detailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 1)];
    _detailWebView.delegate = self;
    _detailWebView.scrollView.scrollEnabled = NO;
    _detailWebView.userInteractionEnabled = NO;
    _detailWebView.backgroundColor = [UIColor whiteColor];

//    [self setNetData];
    
    //navigation

    
    self.navigationItem.leftBarButtonItem = [LaoKNavigationController itemWithImage:@"smBack" selectImage:@"smBack" target:self action:@selector(backPop)];
    
//    LaoKNavigationController *nav = (LaoKNavigationController *)self.navigationController;
//    nav.isPop = NO;
//    nav.interactivePopGestureRecognizer.delegate = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessageTips) name:kNewMessageNotification object:nil];
}

- (void)setbaseView
{
    _baseView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_baseView];
    [_baseView registerClass:[HP_SMDetailCell class] forCellReuseIdentifier:@"smcell"];
    _baseView.delegate = self;
    _baseView.dataSource = self;
    _baseView .mj_header = [LaoKRefeshHeader headerWithRefreshingTarget:self refreshingAction:@selector(setNetData)];
    
    if(!self.isCurrentUser){
     self.baseView.contentInset = UIEdgeInsetsMake(0, 0, 49 *LaokRatio, 0);
    }
    
    _baseView.separatorStyle = 0;
}


-(void)updateTimeInVisibleCells{

    if ([self.endStr isEqualToString:@"     已经结束       "] )
    {
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
          [self.baseView reloadData];
        });
        return;
    }
    if(self.baseDatas.count )
    {
        NSArray  *visiCells = self.baseView.visibleCells; //取出屏幕可见ceLl
        for (UITableViewCell *cell in visiCells)
        {
            
            if ( [cell isKindOfClass:[HP_SMDetailCell class]])
            {
                
                HP_SMDetailCell * cells = (HP_SMDetailCell *)cell;
                if(!cells.endLabel.hidden) return;
                cells.houreLB.text = [LaoKTools compareCurrentTime:cells.model.dueTime  withType:2];
                cells.minLB.text = [LaoKTools compareCurrentTime:cells.model.dueTime  withType:3];
                cells.secLB.text = [LaoKTools compareCurrentTime:cells.model.dueTime  withType:4];
            }
        }
    }
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.baseDatas.count;
    if(self.baseDatas.count)
    {
        return 2;
    }else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
           return [self.baseView cellHeightForIndexPath:indexPath model:self.baseDatas[0] keyPath:@"model" cellClass:[HP_SMDetailCell class] contentViewWidth:self.view.width];
    }else
    {
        return _detailWebView.frame.size.height;
    }

}



//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 )
    {
        HP_SMDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"smcell" forIndexPath:indexPath];
        
        ProductModel * model = self.baseDatas[0];
        cell.model = model;
        
        
        if (cell.endLabel.hidden) {
            cell.houreLB.text = [LaoKTools compareCurrentTime:cell.model.dueTime  withType:2];
            cell.minLB.text = [LaoKTools compareCurrentTime:cell.model.dueTime  withType:3];
            cell.secLB.text = [LaoKTools compareCurrentTime:cell.model.dueTime  withType:4];
        }
        
        LKWeak
        [[[cell.paimaiXieyiButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            
            GFWhatPlatConsignVC *vc = [GFWhatPlatConsignVC new];
            //        vc.pathName = @"拍卖须知";
            vc.type = GFAgreementTypeAuctionQA;
            
            LaoKNavigationController *nav = [[LaoKNavigationController alloc] initWithRootViewController: vc];
            nav.defaultImage = @"backimgwhite";
            LKStrong
            [self presentViewController:nav animated:YES completion:nil];
            
        }];
        
        
        [[[cell.recodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            LKStrong
            ProductModel * model = self.baseDatas[0];
            HPSM_AuctionRecordController * vc = [[HPSM_AuctionRecordController alloc] init];
            vc.productId = model.productId;
            vc.isEnd = model.status == 1 ? NO : YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;

    }else{
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell.contentView addSubview:_detailWebView];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
   }


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.translucent = YES;
    self.shadowImage = self.navigationController.navigationBar.shadowImage;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIColor * color = LaokColor(@"#2f302f");
    
    self.navigationItem.rightBarButtonItem = [LaoKNavigationController itemWithImage:@"discoverShare" selectImage:@"discoverShare" target:self action:@selector(shared)];
    
    
    [self.navigationController.navigationBar laok_setBackgroundColor:[color colorWithAlphaComponent:0]];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self setNetData];
    

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics: UIBarMetricsDefault];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar laok_reset];
    self.navigationController.navigationBar.shadowImage = self.shadowImage;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"backTop"]forBarMetrics: UIBarMetricsDefault];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat x = 0;
//    
//    LaoKLog(@"%f",scrollView.contentOffset.y);
//    
//    ProductModel * model = self.baseDatas[0];
//    if(scrollView.contentOffset.y > x)
//    {
//        self.navigationItem.title = [NSString stringWithFormat:@"当前价:¥%@",model.price];
//    }else
//    {
//        self.navigationItem.title = @"竞拍详情";
//    }
}


/**
 *  加载数据
 */


- (ChujiaView *)chujiaview
{
    if(!_chujiaview)
    {
        _chujiaview = [[ChujiaView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_chujiaview];
        [_chujiaview.chujiaButton addTarget:self action:@selector(chujia) forControlEvents:UIControlEventTouchUpInside];
        [[_chujiaview.openBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

            self.chujiaview.backOpenBtn.hidden = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.chujiaview.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
                _chujiaview.hidden = YES;
            }];
            
        }];
        
        [[_chujiaview.backOpenBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

            self.chujiaview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            self.chujiaview.backOpenBtn.hidden = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.chujiaview.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
                _chujiaview.hidden = YES;
            }];
            
        }];
    }
    _chujiaview.chujiaModel = self.baseDatas[0];
    return _chujiaview;
}

- (void)setNetData
{
    
    NSString * url = [NSString stringWithFormat:@"/shop/product/%@",self.productID];
    LKWeak
    [RequestUtil requestUseGetAFNWith:BaseURLAppendWith(url) parameters:nil timeout:30 isValidate:NO success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        NSDictionary *dataDict;
        NSInteger code = [responseObject getIntegerValueForKey:@"statusCode"];
        
        if (code != 200) {
            NSString *msg = [responseObject getStringValueForKey:@"statusMessage"];
            [SVProgressHUD showErrorWithStatus: msg];
            
            return;
            
        }else{
            
            NSString *data = [responseObject getStringValueForKey:@"data"];
            dataDict = @{@"data" : data};
        }
        
        LaoKLog(@"%@",responseObject);
        
        ProductModel * model = [ProductModel mj_objectWithKeyValues:responseObject[@"data"]];
        LKStrong
        self.baseDatas = @[model];
        
        
        
        self.isPayBaoZhengJin = model.margined;
        self.BaoZhengJin = model.margin;
        self.isCurrentUser = [model.userId isEqualToString: [User currentUser].id.description] ? YES : NO;
        
        
        [self.baseView.mj_header endRefreshing ];

        if(!self.isCurrentUser && model.dueTime.longLongValue > [model.sysTime longLongValue])
        {
            
            if(!self.bzjView)
            {
                _bzjView = [[BuyBZJView alloc] init];
                [self.view addSubview:_bzjView];
            }
            _bzjView.sd_layout.bottomEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(50 *LaokRatio);
            
            [_bzjView.buyBZJButton addTarget:self action:@selector(showchiujiaOrPayBZJ) forControlEvents:UIControlEventTouchUpInside];
            
            if(self.isPayBaoZhengJin){
                _bzjView.buyBZJButton.normalText = @"出价";
            }else{
                _bzjView.buyBZJButton.normalText = [NSString stringWithFormat:@"参拍保证金: ¥%@",self.BaoZhengJin];
            }
        }else
        {
            self.baseView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            if(self.bzjView)
            {
                self.bzjView.hidden = YES;
            }
        }
        
        /**
         *  第一次刷新
         */
        
        //预先加载url
        if (!_updata) {
            _updata = 0;
            NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div><body bgcolor=\"#f8f0ed\">", model.intro];
            [_detailWebView loadHTMLString:htmlcontent baseURL:nil];
        }else{
            [self.baseView reloadData];
        }
        
    

        
//          [self.baseView reloadData];

        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
    
}

//出价 and 交保证金
- (void)showchiujiaOrPayBZJ
{
    if([_bzjView.buyBZJButton.normalText isEqualToString:@"出价"])
    {
        self.chujiaview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.chujiaview.hidden = NO;
        self.chujiaview.backOpenBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 238 *LaokRatio);
        self.chujiaview.backOpenBtn.hidden = NO;
        self.chujiaview.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 238 *LaokRatio);
        [UIView animateWithDuration:0.3 animations:^{
            
            self.chujiaview.bottomView.frame = CGRectMake(0, kScreenHeight - 238 *LaokRatio, kScreenWidth, 238 *LaokRatio);
            
        }];
        self.chujiaview.chujiaModel = self.baseDatas[0];
        
    }else
    {
        if([User currentUser].token.length < 1)
        {
            [GFLoginController modalInViewContrller:self];
            
            return;
        }
        
        if([User currentUser].bMobile.length<1)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"为保证您的账号安全，确保一些重要消息能在第一时间能通知给您，需要您绑定手机号后才可参加拍卖。"] preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                

                GFVerifyPhoneNumVC *vc = [GFVerifyPhoneNumVC new];
                
                LaoKNavigationController *nav = [[LaoKNavigationController alloc] initWithRootViewController: vc];
                nav.defaultImage = @"backimgwhite";
                [self presentViewController:nav animated:YES completion:nil];
                
            }]];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];

            return;
        }
        
        GFDepositPayVC * vc = [[GFDepositPayVC alloc] init];
        vc.productID = self.productID;
        vc.deposit = self.BaoZhengJin;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)chujia
{
    

    
//    LaoKLog(@"%@",self.chujiaview.jiajiaPriceLB.text);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"您确定出价吗?"] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSDictionary * dict = @{
                                @"price":_chujiaview.jiajiaPriceLB.text,
                                @"productId":_chujiaview.chujiaModel.productId
                                };
        LKWeak
        [RequestUtil requestUsePostAFNWith:BaseURLAppendWith(@"/shop/product/bid") parameters:dict timeout:5 isValidate:YES success:^(NSURLSessionDataTask *operation, NSDictionary* responseObject) {
            if([responseObject[@"statusCode"] integerValue]==200)
            {
                [SVProgressHUD showSuccessWithStatus:@"恭喜您出价成功"];
                LKStrong
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    self.chujiaview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                    self.chujiaview.backOpenBtn.hidden = YES;
                    [UIView animateWithDuration:0.3 animations:^{
                        self.chujiaview.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
                        _chujiaview.hidden = YES;
                        [self.baseView.mj_header beginRefreshing];
                    }];
                });

            }else
            {
                [SVProgressHUD showInfoWithStatus:responseObject[@"statusMessage"]];
               
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    self.chujiaview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                    self.chujiaview.backOpenBtn.hidden = YES;
                    [UIView animateWithDuration:0.3 animations:^{
                        self.chujiaview.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
                        _chujiaview.hidden = YES;
                        [self.baseView.mj_header beginRefreshing];
                    }];
                });
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"出价失败,请您重新出价"];
        }];

    }]];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    

    
}
//分享
- (void)shared
{
    LaoKLog(@"分享");
    ProductModel * model = self.baseDatas[0];
    [GFShareTool share: ShareContentTypeAuctionGood id:model.productId title:model.title content: model.title  image: model.img];
}
//返回
- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"竞拍详情销毁");
}

#pragma mark - UIWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取到webview的高度
    CGFloat height = [[self.detailWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];

        self.detailWebView.frame = CGRectMake(self.detailWebView.frame.origin.x+10*LaokRatio,self.detailWebView.frame.origin.y, kScreenWidth-20, height+20);
//    [self.detailWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
    [SVProgressHUD dismiss];
    [self.baseView reloadData];
    
    
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    //    [kSecValuePersistentRef]
    [SVProgressHUD showWithStatus:@"请稍后"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError===%@", error);
}
@end
