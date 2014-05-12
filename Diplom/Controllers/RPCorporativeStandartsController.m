//
//  RPCorporativeStandartsController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 07/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPCorporativeStandartsController.h"
#import "RPStatesModalController.h"
#import "RPMGOPreviewController.h"

@implementation RPCorporativeStandartsController {
    NSMutableArray *objects;
    NSMutableArray *states;
}

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
    
    self.btnCreateObjects.titleLabel.font = [UIFont fontWithName:@"SegoeUI" size:self.btnCreateObjects.font.pointSize];
    self.btnCreateObjects.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addGradientForButton:self.btnCreateObjects];
    
    self.btnShowMGO.titleLabel.font = [UIFont fontWithName:@"SegoeUI" size:self.btnShowMGO.font.pointSize];
    [self addGradientForButton:self.btnShowMGO];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [defaults objectForKey:@"standartObjects"];
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            objects = [[NSMutableArray alloc] initWithArray:oldSavedArray];
            self.lblNumberOfObjects.text = @(objects.count).stringValue;
        } else {
            objects = [[NSMutableArray alloc] init];
        }
    }

    dataRepresentingSavedArray = [defaults objectForKey:@"diagnosticStates"];
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            states = [[NSMutableArray alloc] initWithArray:oldSavedArray];
//            self.txtNumberOfStates.text = @(states.count).stringValue;
        } else {
            states = [[NSMutableArray alloc] init];
        }
    }
    
    self.navigationController.navigationBar.backItem.title = @"";
}

- (void) setObjects:(NSMutableArray*)values {
    objects = values;
    self.lblNumberOfObjects.text = @(objects.count).stringValue;
}

- (void) setStates:(NSMutableArray*)values {
    states = values;
    self.lblNumberOfStates.text = @(states.count).stringValue;
}

- (IBAction)onCreateObjects:(id)sender {
    RPStatesModalController *statesController = [RPStatesModalController new];
    statesController.numberOfValues = @(self.lblNumberOfObjects.text.intValue);
    statesController.states = objects;
    statesController.isObjectsEditing = YES;
    statesController.customDelegate = self;
    
    [self presentViewController:statesController animated:YES completion:nil];
}

- (IBAction)onCreateStates:(id)sender {
    RPStatesModalController *statesController = [RPStatesModalController new];
    statesController.numberOfValues = @(self.lblNumberOfStates.text.intValue);
    statesController.states = states;
    statesController.isObjectsEditing = NO;
    statesController.customDelegate = self;
    
    [self presentViewController:statesController animated:YES completion:nil];
}

- (IBAction)onSave:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:objects] forKey:@"standartObjects"];
    
    [defaults synchronize];
    
    [SVProgressHUD showSuccessWithStatus:@"Стандарты успешно сохранены!"];
}

- (IBAction)onShowMGO:(id)sender {
    RPMGOPreviewController *mgoController = [RPMGOPreviewController new];
    
    [self presentViewController:mgoController animated:YES completion:nil];
}

@end
