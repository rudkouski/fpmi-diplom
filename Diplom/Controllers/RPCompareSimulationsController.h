//
//  RPCompareSimulationsController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 04/05/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"

@interface RPCompareSimulationsController : RPBaseController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lblTitles;

@property (weak, nonatomic) IBOutlet UITableView *tblWithoutAI;
@property (weak, nonatomic) IBOutlet UITableView *tblWithAI;

@property (weak, nonatomic) IBOutlet UILabel *lblDialogCenter;
@property (weak, nonatomic) IBOutlet UILabel *lblDialogCenterAI;
@property (weak, nonatomic) IBOutlet UILabel *lblDialogMGO;
@property (weak, nonatomic) IBOutlet UILabel *lblDialogMGOAI;

@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@end
