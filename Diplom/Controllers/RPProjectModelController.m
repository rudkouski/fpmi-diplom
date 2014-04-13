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
#import "RPModel.h"

@implementation RPProjectModelController {
    NSMutableArray *diagnosticValues;
    RPModel *currentModel;
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [defaults objectForKey:@"diagnosticValues"];
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            diagnosticValues = [[NSMutableArray alloc] initWithArray:oldSavedArray];
            self.txtNumberOfDiagnosticObjects.text = @(diagnosticValues.count).stringValue;
        } else {
            diagnosticValues = [[NSMutableArray alloc] init];
        }
    }
    
    dataRepresentingSavedArray = [defaults objectForKey:@"model"];
    
    if (dataRepresentingSavedArray != nil) {
        RPModel *oldModel = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldModel != nil) {
            currentModel = oldModel;
            [self displayModel:currentModel];
        } else {
            currentModel = [RPModel new];
        }
    }
    
    [[self.txtNumberOfDiagnosticObjects rac_textSignal] subscribeNext:^(NSString *text) {
        self.btnCreateDiagnosticObjects.enabled = text.length > 0;
        self.btnCreateDiagnosticObjects.alpha = text.length > 0 ? 1 : 0.5;
    }];
    
    self.navigationController.navigationBar.backItem.title = @"";
}

- (void) displayModel:(RPModel*)model {
    self.txtCenterId.text = model.centerIdentificator;
    self.txtCenterAddress.text = model.centerAddress;
    self.txtCenterCommunications.text = model.centerCommunications;
    
    self.txtProjectId.text = model.projectIdentificator;
    self.txtDateStart.text = model.projectStartDate;
    self.txtDateEnd.text = model.projectEndDate;
    self.txtProjectCost.text = model.projectCost;
    
    self.txtMgoId.text = model.mgoIdentificator;
    self.txtMgoAddress.text = model.mgoAddress;
    self.txtMgoCommunications.text = model.mgoCommunications;
    self.txtMgoFormula.text = model.mgoFormula;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.txtDateStart) {
        RPDatePickerModalController *modalController = [RPDatePickerModalController new];
    
        modalController.customDelegate = self.txtDateStart;
        [modalController setTitle:@"Дата и время начала"];

        [self presentViewController:modalController animated:YES completion:^{
            
        }];
        
        return NO;
    } else if (textField == self.txtDateEnd) {
        RPDatePickerModalController *modalController = [RPDatePickerModalController new];
        
        modalController.customDelegate = self.txtDateEnd;
        [modalController setTitle:@"Дата и время завершения"];
        
        [self presentViewController:modalController animated:YES completion:^{
            
        }];
        
        return NO;
    }
    
    return YES;
}

- (IBAction)onCreateValues:(id)sender {
    RPCreateDiagnosticValuesController *modalController = [RPCreateDiagnosticValuesController new];
    modalController.numberOfValues = @(self.txtNumberOfDiagnosticObjects.text.intValue);
    modalController.customDelegate = self;
//    diagnosticValues = [NSMutableArray new];
    modalController.diagnosticValues = diagnosticValues;
    
    [self presentViewController:modalController animated:YES completion:nil];
}

- (void) setDiagnosticValues:(NSMutableArray*)values {
    diagnosticValues = values;
}

- (IBAction)onSaveModel:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:diagnosticValues] forKey:@"diagnosticValues"];
    
    currentModel.centerIdentificator = self.txtCenterId.text;
    currentModel.centerAddress = self.txtCenterAddress.text;
    currentModel.centerCommunications = self.txtCenterCommunications.text;
    
    currentModel.projectIdentificator = self.txtProjectId.text;
    currentModel.projectStartDate = self.txtDateStart.text;
    currentModel.projectEndDate = self.txtDateEnd.text;
    currentModel.projectCost = self.txtProjectCost.text;

    currentModel.mgoIdentificator = self.txtMgoId.text;
    currentModel.mgoAddress = self.txtMgoAddress.text;
    currentModel.mgoCommunications = self.txtMgoCommunications.text;
    currentModel.mgoFormula = self.txtMgoFormula.text;
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:currentModel] forKey:@"model"];
    
    [defaults synchronize];
    
    [SVProgressHUD showSuccessWithStatus:@"Модель успешно сохранена!"];
}

@end
