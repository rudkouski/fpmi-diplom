//
//  RPCorporativeStandartsController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 07/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"

@interface RPCorporativeStandartsController : RPBaseController

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lblTitles;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *vwHolders;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *lblInputTitles;

@property (weak, nonatomic) IBOutlet UITextView *txtUserManual;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveToDB;

@property (weak, nonatomic) IBOutlet UITextField *lblNumberOfObjects;
@property (weak, nonatomic) IBOutlet UITextField *lblNumberOfStates;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateObjects;
@property (weak, nonatomic) IBOutlet UIButton *btnShowMGO;

- (void) setStates:(NSMutableArray*)values;
- (void) setObjects:(NSMutableArray*)values;

@end
