//
//  RPEditDiagnosticValueController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"
#import "RPDiagnosticObject.h"

@interface RPEditDiagnosticValueController : RPBaseController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtValueName;

@property (weak, nonatomic) IBOutlet UITextField *txtStateName;
@property (weak, nonatomic) IBOutlet UITextField *txtManagement;
@property (weak, nonatomic) IBOutlet UIButton *btnAddNewState;
@property (weak, nonatomic) IBOutlet UIButton *btnEditState;
@property (weak, nonatomic) IBOutlet UIButton *btnRemoveState;

@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) RPDiagnosticObject *diagnosticValue;
@property (weak, nonatomic) IBOutlet UITableView *tblStates;

@end
