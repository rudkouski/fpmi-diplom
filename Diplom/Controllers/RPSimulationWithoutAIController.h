//
//  RPSimulationWithoutAIController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"

@interface RPSimulationWithoutAIController : RPBaseController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lblTitles;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *vwHolders;

@property (weak, nonatomic) IBOutlet UITextField *txtNumberOfIterations;
@property (weak, nonatomic) IBOutlet UITextField *txtTimeInterval;
@property (weak, nonatomic) IBOutlet UITextField *txtMethod;

@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UITableView *tblSimulation;
@property (weak, nonatomic) IBOutlet UITableView *tblStatistics;

@property (weak, nonatomic) IBOutlet UIProgressView *vwProgress;

@end
