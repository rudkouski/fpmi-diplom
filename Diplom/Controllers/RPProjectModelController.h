//
//  RPProjectModelController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 16/02/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"

@interface RPProjectModelController : RPBaseController

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lblTitles;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *vwHolders;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lblInputTitles;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnButtons;

@end