//
//  LKWheelCell.m
//  LKWheelController
//
//  Created by GF on 17/2/24.
//  Copyright © 2017年 LK. All rights reserved.
//

#import "LKWheelCell.h"

@implementation LKWheelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UILabel * lb = [[UILabel alloc]initWithFrame:self.bounds];
    lb.text = @"索引";
    [self.contentView addSubview:lb];
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    self.backgroundColor = isSelect  ? [UIColor whiteColor] : [[UIColor grayColor]colorWithAlphaComponent:0.5];
}
@end
