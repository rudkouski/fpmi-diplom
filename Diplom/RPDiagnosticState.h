//
//  RPDiagnosticState.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPDiagnosticState : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *managementName;
@property (strong, nonatomic) NSArray *etalon;

@end
