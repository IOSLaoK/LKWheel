//
//  SubController4.m
//  LKWheelController
//
//  Created by GF on 17/2/24.
//  Copyright © 2017年 LK. All rights reserved.
//

#import "SubController4.h"

@interface SubController4 ()

@end

@implementation SubController4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    lb.text = NSStringFromClass(self.class);
    lb.textColor = [UIColor blackColor];
    [self.view addSubview:lb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
