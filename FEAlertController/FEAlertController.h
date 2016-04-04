//
//  FEAlertController.h
//  FEAlertControllerDemo
//
//  Created by feeling on 16/2/23.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEAlertContentView.h"

@class FEAlertController;

typedef void(^FEAlertControllerCallback)(FEAlertController *alertController, NSInteger buttonIndex);

@interface FEAlertController : UIViewController

@property (nonatomic, strong) FEAlertContentView *contentView;

@property (nonatomic, copy) id alertTitle;  // NSString or NSAttributedString
@property (nonatomic, strong) UIImage *alertImage;
@property (nonatomic, strong) NSArray *alertAnimationImages; // for animation
@property (nonatomic, copy) id alertDescription;  // NSString or NSAttributedString
@property (nonatomic, strong) NSArray *alertButtons;
@property (nonatomic, assign) NSInteger highlightButtonIndex;

/**
 *  If YES, then popup will get dismissed when background is touched. default = NO.
 */
@property (assign, nonatomic) BOOL shouldDismissOnBackgroundTouch;

/**
 *  method for initialization
 *
 *  @param title       At the top of the central
 *  @param image       a photo
 *  @param description some text
 *  @param buttons     The operation button list
 *  @param callback    callback when tap operation button
 *
 *  @return a alert ready to present
 */
+(instancetype)alertWithTitle:(id)title
                        image:(UIImage *)image
                  description:(id)description
                      buttons:(NSArray *)buttons
         highlightButtonIndex:(NSInteger)highlightButtonIndex
                     callback:(FEAlertControllerCallback)callback;

/**
 *  initialize method, the alert will show on a new window
 *
 *  @param title       At the top of the central
 *  @param image       a photo
 *  @param description some text
 *  @param buttons     The operation button list
 *  @param callback    callback when tap operation button
 *
 *  @return a alert ready to present
 */
+ (instancetype)showWithTitle:(id)title
                        image:(UIImage *)image
                  description:(id)description
                      buttons:(NSArray *)buttons
         highlightButtonIndex:(NSInteger)highlightButtonIndex
                     callback:(FEAlertControllerCallback)callback;

-(void)showInViewController:(UIViewController *)viewController;

-(void)dismiss;

@end
