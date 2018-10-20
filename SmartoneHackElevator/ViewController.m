//
//  ViewController.m
//  SmartoneHackElevator
//
//  Created by Brian Chung on 20/10/2018.
//  Copyright © 2018 Brian Chung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *dummyImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateImage:(NSString *)imageName {
    _dummyImageView.image = [UIImage imageNamed:imageName];
}


@end
