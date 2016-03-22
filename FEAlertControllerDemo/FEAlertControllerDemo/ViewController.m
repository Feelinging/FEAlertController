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
    
    // Appearance Content View Corner Radius
    [[FEAlertContentView appearance] setCornerRadius:10.0];
    
    // Appearance Content View description text color
    [[FEAlertContentView appearance] setDescriptionTextColor:[UIColor colorWithRed:1.000 green:0.796 blue:0.310 alpha:1.000]];
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
    
    // Animation Image
//    NSMutableArray *animationImages = [NSMutableArray array];
//    for (int i = 1; i<= 35; i++) {
//        UIImage *animImage = [UIImage imageNamed:[NSString stringWithFormat:@"match%d",i]];
//        [animationImages addObject:animImage];
//    }
//    alertController.alertAnimationImages = [animationImages copy];
    
    // Customize
//    alertController.contentView.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
//    alertController.contentView.descriptionLabel.textColor = [UIColor redColor];
    
    [alertController showInViewController:self];
}

@end
