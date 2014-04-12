//
//  RPCreateDiagnosticValuesController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 12/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseModalController.h"

@interface RPCreateDiagnosticValuesController : RPBaseModalController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSNumber *numberOfValues;
@property (strong, nonatomic) NSMutableArray *diagnosticValues;

@end
