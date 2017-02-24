//颜色
#define LKRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define LKRGBAColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define LKRandomColor LKRGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define LKScreenHeight [UIScreen mainScreen].bounds.size.height
#define LKScreenWidth  [UIScreen mainScreen].bounds.size.width


#import "LKWheelController.h"


#import "SubController1.h"
#import "SubController2.h"
#import "SubController3.h"
#import "SubController4.h"

@interface LKWheelController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** collectionview作为最基层界面 */
@property(nonatomic,weak)UICollectionView * titleView;
/** collectionview的自定义布局 */
@property(nonatomic,weak)UICollectionViewFlowLayout * baseFlowLayout;

@property(nonatomic,strong)UIScrollView *scrollSubView;
/**<##>childVC */
@property(nonatomic,strong)NSArray * childVcs;

@end

@implementation LKWheelController

- (NSArray *)childVcs
{
    if(!_childVcs)
    {
        _childVcs = @[[SubController1 new],[SubController2 new],[SubController3 new],[SubController4 new]];
    }
    return _childVcs;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LKWHEEL";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupBaseView];
}

- (void)setupBaseView
{
    /**
     titleView
     */
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    self.baseFlowLayout = layout;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, LKScreenWidth, 44) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor redColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"wheel"];
    collectionView.bounces = NO;
    self.titleView = collectionView;
    [self.view addSubview:collectionView];
    /**
     subviews
     */
    _scrollSubView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, LKScreenWidth, 200)];
    _scrollSubView.contentSize=CGSizeMake(LKScreenWidth*4, 0);
    _scrollSubView.backgroundColor = LKRandomColor;
    _scrollSubView.pagingEnabled=YES;
    _scrollSubView.bounces=NO;
    _scrollSubView.delegate = self;
    [self.view addSubview:_scrollSubView];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
//itemSize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.baseFlowLayout.minimumLineSpacing = 0;
    self.baseFlowLayout.minimumInteritemSpacing = 0;
    self.baseFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return CGSizeMake(LKScreenWidth/4, 44);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wheel" forIndexPath:indexPath];
    cell.backgroundColor = LKRandomColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_scrollSubView setContentOffset:CGPointMake(indexPath.item * LKScreenWidth, 0) animated:YES];

    [self addChildVcViewWithIndex:indexPath.item];
}

//点击button跳到对应的页面
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.bounds.origin.x);
}

#pragma mark - 添加子控制器的view
- (void)addChildVcViewWithIndex:(NSInteger)index
{
    // 取出子控制器
    UIViewController *childVc = self.childVcs[index];
    
    if ([childVc isViewLoaded]) return;
    childVc.view.frame = _scrollSubView.bounds;
    [_scrollSubView addSubview:childVc.view];
}

@end
