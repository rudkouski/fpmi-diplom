//
//  RPStatesModalController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseModalController.h"

@interface RPStatesModalController : RPBaseModalController

@property (strong, nonatomic) NSMutableArray *states;
@property (strong, nonatomic) NSNumber *numberOfValues;
@property (assign, nonatomic) BOOL isObjectsEditing;

@end
