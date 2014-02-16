//
//  RPProjectModelController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 16/02/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPProjectModelController.h"

@interface RPProjectModelController ()

@end

@implementation RPProjectModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Создание модели проекта";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    for (UIView *vwHolder in self.vwHolders) {
        vwHolder.backgroundColor = [UIColor clearColor];
        vwHolder.clipsToBounds = NO;
        vwHolder.layer.borderWidth = 3.0f;
        vwHolder.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:0.8f].CGColor;
    }
    
    for (UILabel *lblTitle in self.lblTitles) {
        [lblTitle setFont:[UIFont fontWithName:@"SegoeUI" size:lblTitle.font.pointSize]];

        [self addGradient:lblTitle];
    }
    
    for (UILabel *lblTitle in self.lblInputTitles) {
        [lblTitle setFont:[UIFont fontWithName:@"SegoeUI" size:lblTitle.font.pointSize]];
    }
    
    for (UIButton *btn in self.btnButtons) {
        btn.titleLabel.font = [UIFont fontWithName:@"SegoeUI" size:btn.font.pointSize];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;

        //        btn.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        [self addGradientForButton:btn];
    }
}

- (void) addGradient:(UIView *) _button {
    // Add Border
    CALayer *layer = _button.layer;
//    layer.cornerRadius = 8.0f;
    CALayer *superlayer = layer.superlayer;
    [layer removeFromSuperlayer];
    [superlayer insertSublayer:layer atIndex:[superlayer.sublayers count]];
    
    layer.shadowOffset = CGSizeMake(-5, 5);
    layer.shadowRadius = 5;
    layer.shadowOpacity = 0.5;
    layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    
    layer.masksToBounds = NO;
    layer.borderWidth = 1.0f;
    layer.borderColor = [UIColor colorWithWhite:0.8f alpha:0.2f].CGColor;
    
    // Add Shine
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = layer.bounds;
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:.0f].CGColor,
                         nil];
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    [layer addSublayer:shineLayer];
}

- (void) addGradientForButton:(UIButton *) _button {
    // Add Border
    CALayer *layer = _button.layer;
    //    layer.cornerRadius = 8.0f
    layer.masksToBounds = NO;
    layer.borderWidth = 1.0f;
    layer.borderColor = [UIColor colorWithWhite:0.8f alpha:0.2f].CGColor;
    
    // Add Shine
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = layer.bounds;
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:.0f].CGColor,
                         nil];
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    [layer addSublayer:shineLayer];
}


@end
