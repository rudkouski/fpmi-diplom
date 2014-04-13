//
//  RPEditDiagnosticValueController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPEditDiagnosticValueController.h"
#import "RPDiagnosticState.h"

@implementation RPEditDiagnosticValueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addGradientForButton:self.btnAddNewState];
    [self addGradientForButton:self.btnEditState];
    [self addGradientForButton:self.btnRemoveState];
    
    RACSignal *stateNameSignal = [[self.txtStateName rac_textSignal] map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    
    RACSignal *managementNameSignal = [[self.txtManagement rac_textSignal] map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[stateNameSignal, managementNameSignal]
                      reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid) {
                          return @([usernameValid boolValue] && [passwordValid boolValue]);
                      }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        self.btnAddNewState.alpha = [signupActive boolValue] ? 1 : 0.5;
        self.btnAddNewState.enabled = [signupActive boolValue];
    }];
    
    self.tblStates.delegate = self;
    self.tblStates.dataSource = self;
    
    self.navigationController.navigationBar.topItem.title = @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.states.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"Cell"];
    }
    
    RPDiagnosticState *state = self.states[indexPath.row];
    
    cell.textLabel.text = state.name;
    cell.detailTextLabel.text = state.managementName;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.btnEditState.alpha = 1;
    self.btnEditState.enabled = YES;
    
    RPDiagnosticState *state = [self.states objectAtIndex:indexPath.row];
    
    self.txtStateName.text = state.name;
    self.txtManagement.text = state.managementName;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.btnEditState.alpha = 0.5;
    self.btnEditState.enabled = NO;
}

- (IBAction)onAddNewState:(id)sender {
    RPDiagnosticState *newState = [RPDiagnosticState new];
    newState.name = self.txtStateName.text;
    newState.managementName = self.txtManagement.text;
    
    self.states = [[[NSMutableArray arrayWithArray:self.states] arrayByAddingObject:newState] copy];
    
    [self.tblStates reloadData];
}

- (IBAction)onEditState:(id)sender {
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.states];
    RPDiagnosticState *newState = [tmp objectAtIndex:self.tblStates.indexPathForSelectedRow.row];
    
    newState.name = self.txtStateName.text;
    newState.managementName = self.txtManagement.text;
    
    self.states = [tmp copy];
    [self.tblStates reloadData];
}

- (IBAction)onRemoveSelectedState:(id)sender {
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.states];
    [tmp removeObjectAtIndex:self.tblStates.indexPathForSelectedRow.row];
    
    self.states = [tmp copy];
    [self.tblStates reloadData];
}

@end
