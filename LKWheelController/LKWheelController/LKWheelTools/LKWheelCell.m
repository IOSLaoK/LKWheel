#import "LKWheelCell.h"
#import "SDAutoLayout.h"
@interface LKWheelCell()
/**<##>文字 */
@property(nonatomic,strong)UILabel * indexText_LB;

/**下标 */
@property(nonatomic,strong)UIView * bottomIndex_V;
@end


@implementation LKWheelCell



- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setup
{
    _indexText_LB = [[UILabel alloc]init];
    _indexText_LB.textAlignment = 1;
    _indexText_LB.textColor = [UIColor blackColor];
    _bottomIndex_V = [[UIView alloc]init];
    _bottomIndex_V.backgroundColor = [UIColor redColor];
    [self.contentView sd_addSubviews:@[_indexText_LB,_bottomIndex_V]];
    _indexText_LB.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).topSpaceToView(self.contentView,2).bottomSpaceToView(self.contentView,2);
    _bottomIndex_V.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).bottomSpaceToView(self.contentView,1).heightIs(2);
    
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    self.bottomIndex_V.hidden = !isSelect;
    self.indexText_LB.textColor = isSelect  ? [UIColor redColor] : [[UIColor blackColor]colorWithAlphaComponent:1];

}
- (void)setIndex:(NSInteger)index
{
    _index = index;
    self.indexText_LB.text = [NSString stringWithFormat:@"索引%zd",index];
}
@end
