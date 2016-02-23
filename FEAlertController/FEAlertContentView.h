//
//  FEAlertContentView.h
//  FEAlertControllerDemo
//
//  Created by feeling on 16/2/23.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FEAlertContentViewDelegate <NSObject>

- (void)alertControllerButtonAction:(UIButton *)button;

@end

@interface FEAlertContentView : UIView

+(instancetype)instanceWithXIB;

@property (assign, nonatomic) id<FEAlertContentViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;
@property (weak, nonatomic) IBOutlet UIButton *buttonRight;

- (IBAction)buttonAction:(UIButton *)sender;

@end
