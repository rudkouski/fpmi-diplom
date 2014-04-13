//
//  RPProjectModelController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 16/02/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"

@interface RPProjectModelController : RPBaseController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lblTitles;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *vwHolders;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lblInputTitles;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnButtons;

@property (weak, nonatomic) IBOutlet UITextField *txtDateStart;
@property (weak, nonatomic) IBOutlet UITextField *txtDateEnd;

@property (weak, nonatomic) IBOutlet UITextField *txtNumberOfDiagnosticObjects;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateDiagnosticObjects;

- (void) setDiagnosticValues:(NSMutableArray*)values;

@end
