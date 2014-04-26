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
#import <opencv2/opencv.hpp>

using namespace cv;

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
            
//            CGFloat mahal = [self mahalanobisDistanceWithFisrt:input.copy andSecond:singleState.etalon];
            
//            NSLog(@"ev = %f",diff);
//            NSLog(@"mah = %f",mahal);
            
            if (diff < min) {
                min = diff;
                result = singleState;
            }
        }
    }
    
    return result;
}

+ (RPDiagnosticState*)findStateWithMahalanobis:(NSMutableArray*)input {
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
            
            diff = [RPSimulationWithoutAIService mahalanobisDistanceWithFisrt:input.copy andSecond:singleState.etalon];
            
            if (diff < min) {
                min = diff;
                result = singleState;
            }
        }
    }
    
    return result;
}

+ (CGFloat) mahalanobisDistanceWithFisrt:(NSArray*)array1 andSecond:(NSArray*)array2 {
    double a[array1.count];
    
    int i = 0;
    for (id item in array1) {
        NSNumber *tmp = item;
        a[i++] = tmp.floatValue;
    }
    
    double b[array2.count];
    
    i = 0;
    for (id item in array2) {
        NSString *tmp = item;
        a[i++] = tmp.floatValue;
    }
    
    Mat Ma = Mat(1, array1.count, CV_64FC1, a);
    Mat Mb = Mat(1, array2.count, CV_64FC1, b);
    
//    std::cout << "Ma = " << std::endl << " " << Ma << std::endl << std::endl;
//    std::cout << "Mb = " << std::endl << " " << Mb << std::endl << std::endl;
    
    double ab[array2.count + array1.count];
    
    i = 0;
    for (id item in array1) {
        NSNumber *tmp = item;
        ab[i++] = tmp.floatValue;
    }
    for (id item in array2) {
        NSString *tmp = item;
        ab[i++] = tmp.floatValue;
    }
    
    Mat Mab = Mat(2, array1.count, CV_64FC1, ab);
    
//    std::cout << "Mab = " << std::endl << " " << Mab << std::endl << std::endl;
    
    Mat cov,mu, icov;
    
    //    cv::calcCovarMatrix(&samples, 2, cov, mu, CV_COVAR_NORMAL | CV_COVAR_ROWS);
    cv::calcCovarMatrix(Mab, cov, mu, CV_COVAR_NORMAL | CV_COVAR_ROWS);
    cv::invert(cov, icov);
    
    Mat inverted(cov.dims, cov.dims, CV_32FC1);
    invert(cov, inverted, cv::DECOMP_SVD);
    
//    std::cout << "cov = " << std::endl << " " << cov << std::endl << std::endl;
//    std::cout << "icov = " << std::endl << " " << inverted << std::endl << std::endl;
    
    double d = cv::Mahalanobis(Ma, Mb, inverted);
    
    return d;
}

+ (NSArray*) mahalanobisSimulationWithNumberOfIterations:(NSInteger)numberOfIterations time:(CGFloat)time {
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
        simulationResult.state = [self findStateWithMahalanobis:singleResult];
        simulationResult.date = [date dateByAddingTimeInterval:time*index];
        
        [result addObject:simulationResult];
    }
    
    return result;
}

+ (NSArray*) combinedSimulationWithNumberOfIterations:(NSInteger)numberOfIterations time:(CGFloat)time {
    return nil;
}

@end
