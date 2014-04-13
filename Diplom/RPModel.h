//
//  RPModel.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPModel : NSObject

@property (strong, nonatomic) NSString *centerIdentificator;
@property (strong, nonatomic) NSString *centerAddress;
@property (strong, nonatomic) NSString *centerCommunications;

@property (strong, nonatomic) NSString *projectIdentificator;
@property (strong, nonatomic) NSString *projectStartDate;
@property (strong, nonatomic) NSString *projectEndDate;
@property (strong, nonatomic) NSString *projectCost;
@property (strong, nonatomic) NSString *projectMap;

@property (strong, nonatomic) NSString *mgoIdentificator;
@property (strong, nonatomic) NSString *mgoAddress;
@property (strong, nonatomic) NSString *mgoCommunications;
@property (strong, nonatomic) NSString *mgoFormula;

@end
