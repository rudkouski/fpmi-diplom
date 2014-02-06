//
//  UIColorAdditions.m
//  APMobile
//
//  Created by Ivan Suhinin on 8/17/11.
//  Copyright 2011 Volcano-Soft. All rights reserved.
//

#import "UIColorAdditions.h"

@implementation UIColor (APMobileAdditions)

+ (UIColor*) colorWithRGB:(NSInteger)rgb {
	return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0f];
}

+ (UIColor*) colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:alpha];
}

@end
