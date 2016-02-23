//
//  FEAlertContentView.m
//  FEAlertControllerDemo
//
//  Created by feeling on 16/2/23.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import "FEAlertContentView.h"

@implementation FEAlertContentView

+(instancetype)instanceWithXIB{
    return [[[NSBundle mainBundle] loadNibNamed:@"FEAlertContentView" owner:nil options:nil] firstObject];
}

- (IBAction)buttonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(alertControllerButtonAction:)]) {
        [self.delegate alertControllerButtonAction:sender];
    }
}

@end
