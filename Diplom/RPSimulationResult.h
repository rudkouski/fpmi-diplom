//
//  RPSimulationResult.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 15/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RPDiagnosticState;

@interface RPSimulationResult : NSObject

@property (strong, nonatomic) RPDiagnosticState *state;
@property (strong, nonatomic) NSArray *resultVector;
@property (strong, nonatomic) NSDate *date;

@end
