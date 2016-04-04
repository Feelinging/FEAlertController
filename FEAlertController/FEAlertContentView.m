//
//  FEAlertContentView.m
//  FEAlertControllerDemo
//
//  Created by feeling on 16/2/23.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import "FEAlertContentView.h"

@interface FEAlertContentView()

@end

@implementation FEAlertContentView

+(instancetype)instanceWithXIB{
    return [[[NSBundle mainBundle] loadNibNamed:@"FEAlertContentView" owner:nil options:nil] firstObject];
}

#pragma mark Action

- (IBAction)buttonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(alertControllerButtonAction:)]) {
        [self.delegate alertControllerButtonAction:sender];
    }
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    
    // apply style
    self.layer.cornerRadius = cornerRadius;
}

#pragma mark -

-(void)highlightButtonByIndex:(NSInteger)buttonIndex{
    UIButton *highlightButton;
    UIButton *otherButton;
    
    if (buttonIndex == 0) {
        highlightButton = self.buttonLeft;
        otherButton = self.buttonRight;
    }
    
    if (buttonIndex == 1) {
        highlightButton = self.buttonRight;
        otherButton = self.buttonLeft;
    }
    
    [highlightButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.796 blue:0.310 alpha:1.000]];
    [highlightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [otherButton setBackgroundColor:[UIColor clearColor]];
    [otherButton setTitleColor:[UIColor colorWithWhite:0.600 alpha:1.000] forState:UIControlStateNormal];
}

-(void)fillButtons:(NSArray *)buttons{
    if ([buttons count] < 1) {
        return;
    }
    
    NSString *firstButtonTitle = [buttons firstObject];
    [self.buttonLeft setTitle:firstButtonTitle forState:UIControlStateNormal];
    
    if ([buttons count] >= 2) {
        NSString *secendButtonTitle = buttons[1];
        if (secendButtonTitle) {
            [self.buttonRight setTitle:secendButtonTitle forState:UIControlStateNormal];
        }
    }

}

@end