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

@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, strong) UIImage *alertImage;
@property (nonatomic, copy) NSString *alertDescription;
@property (nonatomic, strong) NSArray *alertButtons;
@property (nonatomic, assign) NSInteger highlightButtonIndex;

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
+(instancetype)alertWithTitle:(NSString *)title
                        image:(UIImage *)image
                  description:(NSString *)description
                      buttons:(NSArray *)buttons
         highlightButtonIndex:(NSInteger)highlightButtonIndex
                     callback:(FEAlertControllerCallback)callback;

-(void)showInViewController:(UIViewController *)viewController;
-(void)dismiss;

@end
