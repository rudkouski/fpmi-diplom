//
//  RPCorporativeStandartsController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 07/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPCorporativeStandartsController.h"

@implementation RPCorporativeStandartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Построение БД корпоративных стандартов";
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
    
    [self.txtUserManual setFont:[UIFont fontWithName:@"SegoeUI" size:self.txtUserManual.font.pointSize]];
    
    self.btnSaveToDB.titleLabel.font = [UIFont fontWithName:@"SegoeUI" size:self.btnSaveToDB.font.pointSize];
    self.btnSaveToDB.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addGradientForButton:self.btnSaveToDB];
}


@end
