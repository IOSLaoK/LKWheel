#import "ViewController.h"
#import "LKWheelController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)jump:(id)sender {
    [self.navigationController pushViewController:[LKWheelController new] animated:YES];
}

@end
