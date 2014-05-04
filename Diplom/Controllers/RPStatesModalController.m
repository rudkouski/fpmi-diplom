//
//  RPStatesModalController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPStatesModalController.h"
#import "RPEditDiagnosticValueController.h"
#import "RPDiagnosticState.h"

@implementation RPStatesModalController {
    RPEditDiagnosticValueController *editController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.numberOfValues > 0 && self.states.count != self.numberOfValues.integerValue) {
        self.states = [NSMutableArray new];
        
        for (NSInteger index = 1; index <= self.numberOfValues.integerValue; index++) {
            RPDiagnosticState *tmp = [RPDiagnosticState new];
            tmp.name = [NSString stringWithFormat:self.isObjectsEditing ? @"Объект №%d" : @"Состояние №%d", index];
            
            [self.states addObject:tmp];
        }
    }
    
    editController = [RPEditDiagnosticValueController new];
    editController.states = self.states;
    editController.isObjectEditing = self.isObjectsEditing;
    
    if (self.isObjectsEditing) {
        rootController.title = @"Объекты";
    } else {
        rootController.title = @"Состояния";
    }
    
    editController.view.frame = CGRectMake(0, 45, 500, 500);
    
    [rootController.view addSubview:editController.view];
}

- (void)onDone {
    [super onDone];
    
    if (self.isObjectsEditing) {
        if ([self.customDelegate respondsToSelector:@selector(setObjects:)]) {
            [self.customDelegate performSelector:@selector(setObjects:) withObject:editController.states];
        }
    } else {
        if ([self.customDelegate respondsToSelector:@selector(setStates:)]) {
            [self.customDelegate performSelector:@selector(setStates:) withObject:editController.states];
        }
    }
}

@end
