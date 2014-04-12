//
//  RPStartController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 02/02/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPStartController.h"
#import "RPProjectModelController.h"
#import "RPCorporativeStandartsController.h"

@implementation RPStartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = self.lblTitle.text;
    self.lblTitle.font = [UIFont fontWithName:@"SegoeUI" size:30];
    
    for (UIButton *btn in self.btnMainMenu) {
        btn.titleLabel.numberOfLines = 8;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        btn.backgroundColor = [UIColor colorWithRGB:0x00a4a5];
//        if ([btn.titleLabel.text isEqualToString:@"Построение МГО"]) {
//            btn.titleLabel.text = [NSString stringWithFormat:@"Построение\nМГО"];

        
        btn.titleLabel.font = [UIFont fontWithName:@"SegoeUI" size:24];
//        btn.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        [self addGradient:btn];
    }
    
    [self addGradient:self.lblTitle];
    [self.view setBackgroundColor:[UIColor colorWithRGB:0x686868]];

    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void) addGradient:(UIButton *) _button {
    
    // Add Border
    CALayer *layer = _button.layer;
//    layer.cornerRadius = 8.0f;
    layer.masksToBounds = YES;
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

- (IBAction)onProjectModel:(id)sender {
    RPProjectModelController *modelController = [RPProjectModelController new];
    [self.navigationController pushViewController:modelController animated:YES];
}

- (IBAction)onCorporativeDB:(id)sender {
    RPCorporativeStandartsController *corporativeController = [RPCorporativeStandartsController new];
    [self.navigationController pushViewController:corporativeController animated:YES];
}

@end
