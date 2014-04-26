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
#import "RPStatesModalController.h"
#import "RPEtalonController.h"
#import "RPModelPreviewController.h"

@implementation RPProjectModelController {
    NSMutableArray *diagnosticValues;
    NSMutableArray *states;
    
    RPModel *currentModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [@"Создание модели проекта" uppercaseString];
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
    
    dataRepresentingSavedArray = [defaults objectForKey:@"diagnosticStates"];
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            states = [[NSMutableArray alloc] initWithArray:oldSavedArray];
            self.txtNumberOfStates.text = @(states.count).stringValue;
        } else {
            states = [[NSMutableArray alloc] init];
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
    
    RACSignal *objectsSignal = [[self.txtNumberOfDiagnosticObjects rac_textSignal] map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    
    RACSignal *statesSignal = [[self.txtNumberOfStates rac_textSignal] map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    
    
    [[RACSignal combineLatest:@[objectsSignal, statesSignal] reduce:^id(NSNumber *objects, NSNumber *statesBool){
        return @(objects.boolValue && statesBool.boolValue);
    }] subscribeNext:^(NSNumber *x) {
        if (x.boolValue) {
            self.btnCreateEtalons.alpha = 1;
            self.btnCreateEtalons.enabled = YES;
        } else {
            self.btnCreateEtalons.alpha = 0.5;
            self.btnCreateEtalons.enabled = NO;
        }
    }];
    
    [[self.txtNumberOfDiagnosticObjects rac_textSignal] subscribeNext:^(NSString *text) {
        self.btnCreateDiagnosticObjects.enabled = text.length > 0;
        self.btnCreateDiagnosticObjects.alpha = text.length > 0 ? 1 : 0.5;
    }];
    
    [[self.txtNumberOfStates rac_textSignal] subscribeNext:^(NSString *text) {
        self.btnCreateStates.enabled = text.length > 0;
        self.btnCreateStates.alpha = text.length > 0 ? 1 : 0.5;
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

- (IBAction)onCreateEtalons:(id)sender {
    RPEtalonController *etalonController = [RPEtalonController new];
    etalonController.customDelegate = self;
    etalonController.states = states;
    etalonController.values = diagnosticValues;
    
    [self presentViewController:etalonController animated:YES completion:nil];
}

- (IBAction)onCreateStates:(id)sender {
    RPStatesModalController *statesController = [RPStatesModalController new];
    statesController.numberOfValues = @(self.txtNumberOfStates.text.intValue);
    statesController.states = states;
    statesController.customDelegate = self;
    
    [self presentViewController:statesController animated:YES completion:nil];
}

- (void) setDiagnosticValues:(NSMutableArray*)values {
    diagnosticValues = values;
}

- (void) setStates:(NSMutableArray*)values {
    states = values;
    self.txtNumberOfStates.text = @(states.count).stringValue;
}

- (IBAction)onSaveModel:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:diagnosticValues] forKey:@"diagnosticValues"];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:states] forKey:@"diagnosticStates"];
    
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

- (IBAction)onShowModel:(id)sender {
    RPModelPreviewController *previewController = [RPModelPreviewController new];
    previewController.customDelegate = self;
    
//    RPCreateDiagnosticValuesController *modalController = [RPCreateDiagnosticValuesController new];
//    modalController.numberOfValues = @(self.txtNumberOfDiagnosticObjects.text.intValue);
//    modalController.customDelegate = self;
//    //    diagnosticValues = [NSMutableArray new];
//    modalController.diagnosticValues = diagnosticValues;
    
    [self presentViewController:previewController animated:YES completion:nil];
}

@end
