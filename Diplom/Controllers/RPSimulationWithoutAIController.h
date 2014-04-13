//
//  RPSimulationWithoutAIController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"

@interface RPSimulationWithoutAIController : RPBaseController

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lblTitles;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *vwHolders;

@property (weak, nonatomic) IBOutlet UITextField *txtMethod;

@end
