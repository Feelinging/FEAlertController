//
//  FEAlertControllerAnimatedTransitioning.m
//  FEAlertControllerDemo
//
//  Created by feeling on 16/5/23.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import "FEAlertControllerAnimatedTransitioning.h"

@implementation FEAlertControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.25;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
}

@end
