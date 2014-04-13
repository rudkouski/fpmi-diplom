//
//  RPCreateDiagnosticValuesController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 12/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPCreateDiagnosticValuesController.h"
#import "RPDiagnosticObject.h"
#import "RPEditDiagnosticValueController.h"

@implementation RPCreateDiagnosticValuesController {
    UITableView *tblValues;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.numberOfValues > 0 && self.diagnosticValues.count == 0) {
        self.diagnosticValues = [NSMutableArray new];
        
        for (NSInteger index = 1; index <= self.numberOfValues.integerValue; index++) {
            RPDiagnosticObject *tmp = [RPDiagnosticObject new];
            tmp.name = [NSString stringWithFormat:@"Показатель №%d", index];
            
            [self.diagnosticValues addObject:tmp];
        }
    }
    
    tblValues = [[UITableView alloc] initWithFrame:CGRectMake(20, 20, 500, 500)];
    tblValues.delegate = self;
    tblValues.dataSource = self;
    
    rootController.title = @"Диагностические показатели";
    
    [rootController.view addSubview:tblValues];
}

- (void)setCustomView:(UIView *)view {
    view.frame = CGRectMake(20, 60, 500, 500);
    
    [self.view addSubview:view];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.diagnosticValues.count;
}

- (void)onDone {
    [super onDone];
    
    if ([self.customDelegate respondsToSelector:@selector(setDiagnosticValues:)]) {
        [self.customDelegate performSelector:@selector(setDiagnosticValues:) withObject:self.diagnosticValues];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = ((RPDiagnosticObject*)self.diagnosticValues[indexPath.row]).name;
    // Add elements to the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RPEditDiagnosticValueController *editController = [RPEditDiagnosticValueController new];
    
    editController.delegate = self;
    editController.diagnosticValue = self.diagnosticValues[indexPath.row];
    
    [self pushViewController:editController animated:YES];
}

@end
