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

@property (nonatomic, copy) FEAlertControllerCallback callback;

@end

@implementation FEAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add content view
    [self.view addSubview:self.contentView];
    
    // Tap background view
    UITapGestureRecognizer *tapBackgroundViewGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundAction)];
    tapBackgroundViewGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapBackgroundViewGestureRecognizer];
    
    // Background shadow
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    // contentView layout
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

    // CenterY
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    // CenterX
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setter & Getter

-(FEAlertContentView *)contentView{
    if (!_contentView) {
        _contentView = [FEAlertContentView instanceWithXIB];
        _contentView.delegate = self;
        _contentView.titleLabel.text = self.alertTitle;
        _contentView.descriptionLabel.text = self.alertDescription;
        _contentView.clipsToBounds = YES;
        
        // image or images
        if (self.alertImage) {
            _contentView.imageView.image = self.alertImage;
        }else if ([self.alertAnimationImages count] > 0){
            _contentView.imageView.animationImages = self.alertAnimationImages;
        }
    }
    return _contentView;
}

#pragma mark UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self.view) {
        return YES;
    }
    return NO;
}

#pragma mark Show & Dsimiss

+(instancetype)alertWithTitle:(NSString *)title image:(UIImage *)image description:(NSString *)description buttons:(NSArray *)buttons highlightButtonIndex:(NSInteger)highlightButtonIndex callback:(FEAlertControllerCallback)callback{
    FEAlertController *alertController = [[FEAlertController alloc] init];
    alertController.alertTitle = title;
    alertController.alertImage = image;
    alertController.alertDescription = description;
    alertController.alertButtons = buttons;
    
    // highlightButtonIndex
    if (highlightButtonIndex > [buttons count] - 1) {
        alertController.highlightButtonIndex = [buttons count] - 1;
    }else if (highlightButtonIndex < 0) {
        alertController.highlightButtonIndex = 0;
    }else{
        alertController.highlightButtonIndex = highlightButtonIndex;
    }
    
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

-(void)tapBackgroundAction{
    if (self.shouldDismissOnBackgroundTouch) {
        [self dismiss];
    }
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

-(void)prepareDisplay{
    if ([self.alertTitle length] == 0) {
        [self.contentView.titleLabel removeFromSuperview];
    }
    
    if (!self.alertImage && [self.alertAnimationImages count] < 1) {
        [self.contentView.imageView removeFromSuperview];
    }
    
    if ([self.alertDescription length] == 0) {
        [self.contentView.descriptionLabel removeFromSuperview];
    }
    
    // most 2 button
    NSMutableArray *alertButtons = [self.alertButtons mutableCopy];
    if ([self.alertButtons count] > 2) {
        [alertButtons removeObjectsInRange:NSMakeRange(1, [alertButtons count]-2)];
    }else if ([alertButtons count] == 1) {
        [self.contentView.buttonRight removeFromSuperview];
        self.contentView.buttonLeftLeadingConstraint.active = NO;
    }else if (self.alertButtons == 0){
        [self.contentView.buttonLeft removeFromSuperview];
        [self.contentView.buttonRight removeFromSuperview];
    }
    
    [self.contentView fillButtons:alertButtons];
    [self.contentView highlightButtonByIndex:self.highlightButtonIndex];
    
    // begin animation
    if ([self.alertAnimationImages count] > 1) {
        self.contentView.imageView.animationDuration = 2.0;
        [self.contentView.imageView startAnimating];
    }
}


#pragma mark FEAlertContentViewDelegate

-(void)alertControllerButtonAction:(UIButton *)button{
    NSInteger clickButtonIndex = (button == self.contentView.buttonLeft ? 0 : 1);
    if (self.callback) {
        self.callback(self,clickButtonIndex);
    }
}

@end
