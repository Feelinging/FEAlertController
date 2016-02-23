//
//  FEAlertController.m
//  FEAlertControllerDemo
//
//  Created by feeling on 16/2/23.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import "FEAlertController.h"
#import "FEAlertContentView.h"

@interface FEAlertController ()<UIGestureRecognizerDelegate,FEAlertContentViewDelegate>

@property (nonatomic, strong) FEAlertContentView *contentView;
@property (nonatomic, copy) FEAlertControllerCallback callback;

@end

@implementation FEAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add content view
    [self.view addSubview:self.contentView];
    
    // Tap background view
    UITapGestureRecognizer *tapBackgroundViewGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapBackgroundViewGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapBackgroundViewGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

-(FEAlertContentView *)contentView{
    if (!_contentView) {
        _contentView = [FEAlertContentView instanceWithXIB];
        _contentView.delegate = self;
        _contentView.titleLabel.text = self.alertTitle;
        _contentView.imageView.image = self.alertImage;
        _contentView.descriptionLabel.text = self.alertDescription;
    }
    return _contentView;
}

#pragma mark -

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self.view) {
        return YES;
    }
    return NO;
}

#pragma mark Show & Dsimiss

+(instancetype)alertWithTitle:(NSString *)title image:(UIImage *)image description:(NSString *)description buttons:(NSArray *)buttons callback:(FEAlertControllerCallback)callback{
    FEAlertController *alertController = [[FEAlertController alloc] init];
    alertController.alertTitle = title;
    alertController.alertImage = image;
    alertController.alertDescription = description;
    alertController.alertButtons = buttons;
    alertController.callback = callback;
    return alertController;
}

-(void)showInViewController:(UIViewController *)viewController{
    // present style
    if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_8_0) {
        // iOS8+
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }else{
        viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    }

    //
    [self prepareDisplay];
    
    [viewController presentViewController:self animated:YES completion:nil];
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)prepareDisplay{
    if ([self.alertTitle length] == 0) {
        [self.contentView.titleLabel removeFromSuperview];
    }
    
    if (!self.alertImage) {
        [self.contentView.imageView removeFromSuperview];
    }
    
    if ([self.alertDescription length] == 0) {
        [self.contentView.descriptionLabel removeFromSuperview];
    }
}

#pragma mark FEAlertContentViewDelegate

-(void)alertControllerButtonAction:(UIButton *)button{
    if (self.callback) {
        self.callback(self,button);
    }
}

@end
