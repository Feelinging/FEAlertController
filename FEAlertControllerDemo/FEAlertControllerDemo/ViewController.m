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
    FEAlertController *alertController = [FEAlertController alertWithTitle:@"What are you doing?"
                                                                     image:[UIImage imageNamed:@"ahopps"]
                                                               description:@"Can you guess what I\'m going to do?"
                                                                   buttons:@[@"Read book",@"Coding"]
                                                      highlightButtonIndex:1
                                                                  callback:^(FEAlertController *alertController, NSInteger buttonIndex) {
                                                                      NSLog(@"click button index : %@", @(buttonIndex));
                                                                      [alertController dismiss];
    }];

    // Customize
//    alertController.contentView.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
//    alertController.contentView.descriptionLabel.textColor = [UIColor redColor];
    
    [alertController showInViewController:self];
}

@end
