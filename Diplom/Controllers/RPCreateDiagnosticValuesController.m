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
    UITextField *txtTitle;
    
    RPDiagnosticObject *objectToEdit;
    UISwitch *biffSwitch;
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
    
    tblValues = [[UITableView alloc] initWithFrame:CGRectMake(20, 130, 500, 470)];
    tblValues.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tblValues.delegate = self;
    tblValues.dataSource = self;
    
    rootController.title = @"Диагностические показатели";
    
    [rootController.view addSubview:tblValues];
    
    UILabel *lblTextTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 60, 500, 30)];
    lblTextTitle.text = @"Название показателя:";
    [lblTextTitle sizeToFit];
    
    [rootController.view addSubview:lblTextTitle];
    
    txtTitle = [[UITextField alloc] initWithFrame:CGRectMake(lblTextTitle.frame.origin.x + lblTextTitle.frame.size.width + 10,
                                                                          60,
                                                                          500 - (lblTextTitle.frame.origin.x + lblTextTitle.frame.size.width + 10),
                                                                          30)];
    txtTitle.center = CGPointMake(txtTitle.center.x, lblTextTitle.center.y);
    txtTitle.borderStyle = UITextBorderStyleBezel;
    
    [rootController.view addSubview:txtTitle];
    
    [[txtTitle rac_textSignal] subscribeNext:^(NSString *text) {
        if (objectToEdit != nil) {
            objectToEdit.name = text;
            
            [tblValues reloadData];
        }
    }];
    
    UILabel *lblSwitchTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 100, 500, 30)];
    lblSwitchTitle.text = @"Бифуркационный показатель:";
    [lblSwitchTitle sizeToFit];
    
    [rootController.view addSubview:lblSwitchTitle];
    
    biffSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(lblSwitchTitle.frame.origin.x + lblSwitchTitle.frame.size.width + 10, 90, 500, 30)];
    biffSwitch.center = CGPointMake(biffSwitch.center.x, lblSwitchTitle.center.y);

    [rootController.view addSubview:biffSwitch];

    [[biffSwitch rac_signalForControlEvents:(UIControlEventValueChanged)] subscribeNext:^(UISwitch *swich) {
        if (objectToEdit != nil) {
            objectToEdit.isBiffValue = swich.isOn;
            [tblValues reloadData];
        }
    }];
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
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    RPDiagnosticObject *tmp = self.diagnosticValues[indexPath.row];
    cell.textLabel.text = tmp.name;
    cell.accessoryType = tmp.isBiffValue ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    // Add elements to the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    RPEditDiagnosticValueController *editController = [RPEditDiagnosticValueController new];
//    
//    editController.delegate = self;
//    editController.diagnosticValue = self.diagnosticValues[indexPath.row];
//    
//    [self pushViewController:editController animated:YES];
    objectToEdit = self.diagnosticValues[indexPath.row];
    txtTitle.text = objectToEdit.name;
    [biffSwitch setOn:objectToEdit.isBiffValue];
}

@end
