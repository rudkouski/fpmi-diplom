//
//  RPSimulationWithoutAIService.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPSimulationWithoutAIService.h"
#import "RPDiagnosticObject.h"
#import "RPDiagnosticState.h"
#import "RPSimulationResult.h"

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

    NSDate *date = [NSDate date];
    
    for (NSInteger index = 0; index < numberOfIterations; index++) {
        NSMutableArray *singleResult = [NSMutableArray new];
        
        for (RPDiagnosticObject *object in diagnosticValues) {
            double val = ((double)arc4random() / ARC4RANDOM_MAX);
            [singleResult addObject:@(val)];
        }
        
        RPSimulationResult *simulationResult = [RPSimulationResult new];
        simulationResult.resultVector = singleResult;
        simulationResult.state = [self findStateWithEvklid:singleResult];
        simulationResult.date = [date dateByAddingTimeInterval:time*index];
        
        [result addObject:simulationResult];
    }
    
    return result;
}

+ (RPDiagnosticState*)findStateWithEvklid:(NSMutableArray*)input {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *dataRepresentingSavedArray = [defaults objectForKey:@"diagnosticStates"];
    NSMutableArray *diagnosticStates;
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            diagnosticStates = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        }
    } else return nil;
    
    RPDiagnosticState *result;
    CGFloat min = CGFLOAT_MAX;
    
    for (RPDiagnosticState *singleState in diagnosticStates) {
        if (input.count == singleState.etalon.count) {
            
            CGFloat diff = 0.0;
            
            for (NSInteger index = 0; index < singleState.etalon.count; index++) {
                NSString *tmp = singleState.etalon[index];
                diff += fabs(tmp.floatValue - ((NSNumber*)input[index]).floatValue);
            }
            
            if (diff < min) {
                min = diff;
                result = singleState;
            }
        }
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
