//
//  RPDiagnosticState.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPDiagnosticState.h"

@implementation RPDiagnosticState

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.managementName forKey:@"managementName"];
    [coder encodeObject:self.etalon forKey:@"etalon"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        self.name = [coder decodeObjectForKey:@"name"];
        self.managementName = [coder decodeObjectForKey:@"managementName"];
        self.etalon = [coder decodeObjectForKey:@"etalon"];
    }
    
    return self;
}

@end
