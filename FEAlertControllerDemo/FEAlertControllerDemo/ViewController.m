//
//  ViewController.m
//  FEAlertControllerDemo
//
//  Created by feeling on 16/2/23.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import "ViewController.h"
#import "FEAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hey:(UIButton *)sender {
    FEAlertController *alertController = [FEAlertController alertWithTitle:@"hey" image:nil description:@"aa" buttons:@[@"啊啊啊"] callback:^(FEAlertController *alertController, NSInteger buttonIndex) {
        [alertController dismiss];
    }];
    [alertController showInViewController:self];
}

@end
