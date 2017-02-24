#import "LKWheelController.h"
#import "SubController1.h"
#import "SubController2.h"
#import "SubController3.h"
#import "SubController4.h"
#import "LKWheelCell.h"
//颜色
#define LKRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define LKRGBAColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define LKRandomColor LKRGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define LKScreenHeight [UIScreen mainScreen].bounds.size.height
#define LKScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface LKWheelController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property(nonatomic,weak)UICollectionView * titleView;/** titleView作为标引界面 */
@property(nonatomic,weak)UICollectionViewFlowLayout * baseFlowLayout;/** titleView的自定义布局 */
@property(nonatomic,strong)UIScrollView *scrollSubView;/** 作为subvc展示界面 */
@property(nonatomic,strong)NSArray<UIViewController *>* childVcs;/**<##>childVC */
@property(nonatomic,assign)NSInteger selectIndex;/**索引 */
@end

@implementation LKWheelController

- (NSArray *)childVcs
{
    if(!_childVcs)
        _childVcs = @[[SubController1 new],[SubController2 new],[SubController3 new],[SubController4 new]];
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
    //titleView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    self.baseFlowLayout = layout;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, LKScreenWidth, 44) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor redColor];
    [collectionView registerClass:[LKWheelCell class] forCellWithReuseIdentifier:@"wheel"];
    collectionView.bounces = NO;
    self.titleView = collectionView;
    [self.view addSubview:collectionView];
    //subvcs
    _scrollSubView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, LKScreenWidth, LKScreenHeight - 64 - 44)];
    _scrollSubView.contentSize=CGSizeMake(LKScreenWidth*4, 0);
    _scrollSubView.backgroundColor = [UIColor greenColor];
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
    LKWheelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wheel" forIndexPath:indexPath];
    cell.isSelect = indexPath.item == self.selectIndex;
    return cell;
}
/**
 *  cell点击 调用subvc滚动方法
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_scrollSubView setContentOffset:CGPointMake(indexPath.item * LKScreenWidth, 0) animated:YES];
}
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提:使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.selectIndex =  _scrollSubView.contentOffset.x / LKScreenWidth;
    NSLog(@"调用  %zd",self.selectIndex);
    [self.titleView reloadData];
    if ([self.childVcs[self.selectIndex] isViewLoaded]) return;
    self.childVcs[self.selectIndex].view.frame = _scrollSubView.bounds;
    [_scrollSubView addSubview:self.childVcs[self.selectIndex].view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.childVcs[0] isViewLoaded]) return;
    [self scrollViewDidEndScrollingAnimation:_scrollSubView];
}

- (void)dealloc
{
   NSLog(@"LKWheel销毁");
}
@end
