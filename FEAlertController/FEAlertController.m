//
//  FEAlertController.m
//  FEAlertControllerDemo
//
//  Created by feeling on 16/2/23.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import "FEAlertController.h"
#import "FEAlertContentView.h"

#define FEAlertiOS8Later (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_8_0)

@interface FEAlertController ()<UIGestureRecognizerDelegate,FEAlertContentViewDelegate>

@property (nonatomic, copy) FEAlertControllerCallback callback;
@property (nonatomic, strong) NSLayoutConstraint *conentViewHeightConstraint;



@property (nonatomic, weak) UIWindow *fromWindow;
@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation FEAlertController

#pragma mark initialize
+ (instancetype)showWithTitle:(NSString *)title image:(UIImage *)image description:(NSString *)description buttons:(NSArray *)buttons highlightButtonIndex:(NSInteger)highlightButtonIndex callback:(FEAlertControllerCallback)callback {
    FEAlertController *alert = [self alertWithTitle:title image:image description:description buttons:buttons highlightButtonIndex:highlightButtonIndex callback:callback];
    
    [alert showInNewWindow];
    
    return alert;
}


#pragma mark lifeCycle
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

    
    // Width
    CGFloat contentViewWidth = 258.0;
    if (!self.contentView.buttonLeft.superview) {
        contentViewWidth = 220.0;
    }
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:contentViewWidth]];
    
    // Height
    NSLayoutConstraint *conentViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:CGRectGetHeight(self.contentView.frame)];
    [self.view addConstraint:conentViewHeightConstraint];
    self.conentViewHeightConstraint = conentViewHeightConstraint;
    
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

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    // update content view height by bottom margin view
    CGFloat currentContentViewHeight;
    UIView *bottomMarginView = bottomMarginView = self.contentView.buttonLeft;
    if (!self.contentView.buttonLeft.superview) {
        bottomMarginView = self.contentView.imageView;
    }
    currentContentViewHeight = CGRectGetMaxY(bottomMarginView.frame) + 10;
    
    if (self.conentViewHeightConstraint.constant != currentContentViewHeight) {
        
        // for iOS7, go to main dispatch queue
        dispatch_async(dispatch_get_main_queue(), ^{
            self.conentViewHeightConstraint.constant = currentContentViewHeight;
            [self.view setNeedsLayout];
        });
    }
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


- (void)showInNewWindow {
    // 记录
    self.fromWindow = [UIApplication sharedApplication].keyWindow;
    
    UIWindow *newWindow = [[UIWindow alloc] init];
    newWindow.bounds = [UIScreen mainScreen].bounds;
    newWindow.backgroundColor = [UIColor clearColor];
    newWindow.windowLevel = self.fromWindow.windowLevel + 1;
    self.alertWindow = newWindow;
    
    UIViewController *wrapper = [[UIViewController alloc] init];
    wrapper.view.backgroundColor = [UIColor clearColor];
    newWindow.rootViewController= wrapper;
    
    [self.alertWindow makeKeyAndVisible];
    
    [self showInViewController:wrapper];
}

-(void)showInViewController:(UIViewController *)viewController{
    // present style
    if (FEAlertiOS8Later) {
        // iOS8+
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }else{
        viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    }

    // layout
    [self prepareDisplay];
    
    // prepare for amiation
    self.contentView.alpha = 0.0;
    self.view.alpha = 0.0;
    
    // present
    [viewController presentViewController:self animated:NO completion:^{
        // animation background
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.view.alpha = 1.0;
        } completion:nil];
        
        // animation content view
        self.contentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.contentView.alpha = 1.0;
                             self.contentView.transform = CGAffineTransformIdentity;
                         }
                         completion:nil];
        
    }];
}

-(void)tapBackgroundAction{
    if (self.shouldDismissOnBackgroundTouch) {
        [self dismiss];
    }
}

-(void)dismiss{
    
    
    if (FEAlertiOS8Later) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        // iOS7
        // animation background
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:^{
                // if has alertWindow
                if (self.alertWindow) {
                    [self.alertWindow resignKeyWindow];
                    self.alertWindow = nil;
                    
                    [self.fromWindow makeKeyAndVisible];
                }
            }];
        }];
    }
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
        [self.contentView removeConstraint:self.contentView.buttonLeftLeadingConstraint];
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
