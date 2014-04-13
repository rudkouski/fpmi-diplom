//
//  RPModel.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPModel.h"

@implementation RPModel

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self.centerIdentificator forKey:@"centerIdentificator"];
    [coder encodeObject:self.centerAddress forKey:@"centerAddress"];
    [coder encodeObject:self.centerCommunications forKey:@"centerCommunications"];
    
    [coder encodeObject:self.projectIdentificator forKey:@"projectIdentificator"];
    [coder encodeObject:self.projectStartDate forKey:@"projectStartDate"];
    [coder encodeObject:self.projectEndDate forKey:@"projectEndDate"];
    [coder encodeObject:self.projectCost forKey:@"projectCost"];
    [coder encodeObject:self.projectMap forKey:@"projectMap"];
    
    [coder encodeObject:self.mgoIdentificator forKey:@"mgoIdentificator"];
    [coder encodeObject:self.mgoAddress forKey:@"mgoAddress"];
    [coder encodeObject:self.mgoCommunications forKey:@"mgoCommunications"];
    [coder encodeObject:self.mgoFormula forKey:@"mgoFormula"];
    
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil) {
        self.centerIdentificator = [coder decodeObjectForKey:@"centerIdentificator"];
        self.centerAddress = [coder decodeObjectForKey:@"centerAddress"];
        self.centerCommunications = [coder decodeObjectForKey:@"centerCommunications"];
        
        self.projectIdentificator = [coder decodeObjectForKey:@"projectIdentificator"];
        self.projectStartDate = [coder decodeObjectForKey:@"projectStartDate"];
        self.projectEndDate = [coder decodeObjectForKey:@"projectEndDate"];
        self.projectCost = [coder decodeObjectForKey:@"projectCost"];
        self.projectMap = [coder decodeObjectForKey:@"projectMap"];
        
        self.mgoIdentificator = [coder decodeObjectForKey:@"mgoIdentificator"];
        self.mgoAddress = [coder decodeObjectForKey:@"mgoAddress"];
        self.mgoCommunications = [coder decodeObjectForKey:@"mgoCommunications"];
        self.mgoFormula = [coder decodeObjectForKey:@"mgoFormula"];
    }
    
    return self;
}



@end
