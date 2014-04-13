//
//  RPDiagnosticObject.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 12/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPDiagnosticObject.h"

@implementation RPDiagnosticObject

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeBool:self.isBiffValue forKey:@"isBiffValue"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        self.name = [coder decodeObjectForKey:@"name"];
        self.isBiffValue = [coder decodeBoolForKey:@"isBiffValue"];
    }
    return self;
}

@end
