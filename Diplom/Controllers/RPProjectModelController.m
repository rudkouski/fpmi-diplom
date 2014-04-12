//
//  RPProjectModelController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 16/02/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPProjectModelController.h"
#import "RPDatePickerModalController.h"
#import "RPCreateDiagnosticValuesController.h"

@implementation RPProjectModelController {
    NSMutableArray *diagnosticValues;
}

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

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.txtDateStart) {
        RPDatePickerModalController *modalController = [RPDatePickerModalController new];
    
        modalController.delegate = self.txtDateStart;
        [modalController setTitle:@"Дата и время начала"];

        [self presentViewController:modalController animated:YES completion:^{
            
        }];
        
        return NO;
    } else if (textField == self.txtDateEnd) {
        RPDatePickerModalController *modalController = [RPDatePickerModalController new];
        
        modalController.delegate = self.txtDateEnd;
        [modalController setTitle:@"Дата и время завершения"];
        
        [self presentViewController:modalController animated:YES completion:^{
            
        }];
        
        return NO;
    }
    
    return YES;
}

- (IBAction)onCreateValues:(id)sender {
    RPCreateDiagnosticValuesController *modalController = [RPCreateDiagnosticValuesController new];
    modalController.numberOfValues = @(4);
    diagnosticValues = [NSMutableArray new];
    modalController.diagnosticValues = diagnosticValues;
    
    [self presentViewController:modalController animated:YES completion:nil];
}

@end
