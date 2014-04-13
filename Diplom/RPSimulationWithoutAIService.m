//
//  RPSimulationWithoutAIService.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPSimulationWithoutAIService.h"
#import "RPDiagnosticObject.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation RPSimulationWithoutAIService

+ (NSArray*) simulationWithNumberOfIterations:(NSInteger)numberOfIterations time:(CGFloat)time usingMethod:(SimulationMethod)method {
    switch (method) {
        case SimulationMethodEvklid:
            return [self evklidSimulationWithNumberOfIterations:numberOfIterations time:time];
        case SimulationMethodMahalanobis:
            return [self mahalanobisSimulationWithNumberOfIterations:numberOfIterations time:time];
        case SimulationMethodCombined:
            return [self combinedSimulationWithNumberOfIterations:numberOfIterations time:time];
        default:
            return nil;
    }
}

+ (NSArray*) evklidSimulationWithNumberOfIterations:(NSInteger)numberOfIterations time:(CGFloat)time {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *dataRepresentingSavedArray = [defaults objectForKey:@"diagnosticValues"];
    NSMutableArray *diagnosticValues;
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            diagnosticValues = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        }
    } else return nil;
    
    NSMutableArray *result = [NSMutableArray new];

    for (NSInteger index = 0; index < numberOfIterations; index++) {
        NSMutableArray *singleResult = [NSMutableArray new];
        
        for (RPDiagnosticObject *object in diagnosticValues) {
            double val = ((double)arc4random() / ARC4RANDOM_MAX);
            [singleResult addObject:@(val)];
        }
        
        [result addObject:singleResult];
    }
    
    return result;
}

+ (NSArray*) mahalanobisSimulationWithNumberOfIterations:(NSInteger)numberOfIterations time:(CGFloat)time {
    return nil;
}

+ (NSArray*) combinedSimulationWithNumberOfIterations:(NSInteger)numberOfIterations time:(CGFloat)time {
    return nil;
}

@end
