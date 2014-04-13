//
//  RPSimulationWithoutAIController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPSimulationWithoutAIController.h"
#import "RPMethodPickerController.h"
#import "RPSimulationWithoutAIService.h"

@implementation RPSimulationWithoutAIController {
    UIPopoverController *methodPicker;
    RPMethodPickerController *methodsController;
    
    NSArray *simulationResult;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = [@"Моделирование без AI-модуля" uppercaseString];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    for (UILabel *lblTitle in self.lblTitles) {
        [lblTitle setFont:[UIFont fontWithName:@"SegoeUI" size:lblTitle.font.pointSize]];
        
        [self addGradient:lblTitle];
    }
    
    [self addGradientForButton:self.btnStart];
    
    self.navigationController.navigationBar.backItem.title = @"";
    
    self.tblSimulation.delegate = self;
    self.tblSimulation.dataSource = self;
    
    RACSignal *numberSignal = [[self.txtNumberOfIterations rac_textSignal] map:^id(NSString *text) {
        return @(text.length);
    }];
    
    RACSignal *timeSignal = [[self.txtTimeInterval rac_textSignal] map:^id(NSString *text) {
        return @(text.length);
    }];

    [[RACSignal combineLatest:@[numberSignal, timeSignal]
                       reduce:^id(NSNumber *numberValid, NSNumber *timeValid){
                           return @([numberValid boolValue] && [timeValid boolValue]);
                       }] subscribeNext:^(NSNumber *isFilled) {
                           self.btnStart.alpha = isFilled.boolValue ? 1 : 0.5;
                           self.btnStart.enabled = isFilled.boolValue ? YES : NO;
                       }];
    
    [[[self.btnStart rac_signalForControlEvents:(UIControlEventTouchUpInside)] doNext:^(id x) {
        self.btnStart.alpha = 0.5;
        self.btnStart.enabled = NO;
    }] subscribeNext:^(id x) {
        simulationResult = [RPSimulationWithoutAIService simulationWithNumberOfIterations:self.txtNumberOfIterations.text.integerValue
                                                                  time:self.txtTimeInterval.text.floatValue
                                                           usingMethod:(SimulationMethodEvklid)];
        
        [self.tblSimulation reloadData];
    }];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.txtMethod) {
        if (methodsController == nil) {
            methodsController = [RPMethodPickerController new];
            methodsController.customDelegate = self.txtMethod;
            
            methodPicker = [[UIPopoverController alloc] initWithContentViewController:methodsController];
            
            methodsController.parentController = methodPicker;
        }
        
        [methodPicker presentPopoverFromRect:CGRectMake(self.txtMethod.frame.origin.x, self.txtMethod.frame.origin.y + 70, self.txtMethod.frame.size.width, self.txtMethod.frame.size.height)
                                      inView:self.view
                    permittedArrowDirections:(UIPopoverArrowDirectionAny)
                                    animated:YES];
         
        return NO;
    }
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return simulationResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tblSimulation dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Cell"];
    }
    
    NSArray *tmp = simulationResult[indexPath.row];
    
    cell.textLabel.text = [tmp componentsJoinedByString:@", "];
    
    return cell;
}


@end
