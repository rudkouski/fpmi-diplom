//
//  RPSimulationWithoutAIService.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SimulationMethodEvklid,
    SimulationMethodMahalanobis,
    SimulationMethodCombined,
} SimulationMethod;

@interface RPSimulationWithoutAIService : NSObject

+ (NSArray*) simulationWithNumberOfIterations:(NSInteger)numberOfIterations time:(CGFloat)time usingMethod:(SimulationMethod)method;

@end
