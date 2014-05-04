//
//  RPSimulationResultCell.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 15/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPSimulationResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblIndex;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblStateName;
@property (weak, nonatomic) IBOutlet UILabel *lblManageName;
@property (weak, nonatomic) IBOutlet UILabel *lblVector;
@property (weak, nonatomic) IBOutlet UIView *vwColor;

@end
