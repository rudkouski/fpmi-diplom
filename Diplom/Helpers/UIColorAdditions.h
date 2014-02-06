//
//  UIColorAdditions.h
//  APMobile
//
//  Created by Ivan Suhinin on 8/17/11.
//  Copyright 2011 Volcano-Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (APMobileAdditions)

+ (UIColor*) colorWithRGB:(NSInteger)rgb;

+ (UIColor*) colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha;

@end