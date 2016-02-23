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

//
//-(CGSize)intrinsicContentSize{
//    return CGSizeMake(500, 500);
//}

@end
