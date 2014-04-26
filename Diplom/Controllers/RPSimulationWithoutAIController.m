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
#import "RPDiagnosticState.h"
#import "RPSimulationResult.h"
#import "RPSimulationResultCell.h"

@implementation RPSimulationWithoutAIController {
    UIPopoverController *methodPicker;
    RPMethodPickerController *methodsController;
    
    NSMutableArray *displayingResult;
    NSArray *simulationResult;
    NSArray *states;
    NSMutableDictionary *stateCounts;
    
    NSInteger currentIndex;
    NSTimer *currentTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    stateCounts = [NSMutableDictionary new];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *dataRepresentingSavedArray = [defaults objectForKey:@"diagnosticStates"];
    NSMutableArray *diagnosticStates;
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            diagnosticStates = [[NSMutableArray alloc] initWithArray:oldSavedArray];
            states = diagnosticStates;
        }
    }
    
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
        [self.txtNumberOfIterations resignFirstResponder];
    }] subscribeNext:^(id x) {
        if ([self.txtMethod.text isEqualToString:@"Евклида"]) {
            simulationResult = [RPSimulationWithoutAIService simulationWithNumberOfIterations:self.txtNumberOfIterations.text.integerValue
                                                                                         time:self.txtTimeInterval.text.floatValue
                                                                                  usingMethod:(SimulationMethodEvklid)];
        } else if ([self.txtMethod.text isEqualToString:@"Махалалобиса"]){
            simulationResult = [RPSimulationWithoutAIService simulationWithNumberOfIterations:self.txtNumberOfIterations.text.integerValue
                                                                                         time:self.txtTimeInterval.text.floatValue
                                                                                  usingMethod:(SimulationMethodMahalanobis)];
        } else {
            simulationResult = [RPSimulationWithoutAIService simulationWithNumberOfIterations:self.txtNumberOfIterations.text.integerValue
                                                                                         time:self.txtTimeInterval.text.floatValue
                                                                                  usingMethod:(SimulationMethodCombined)];
        }
        [self startSimulating];
    }];
}

- (void) startSimulating {
    currentIndex = 0;
    displayingResult = [NSMutableArray new];
    
    currentTimer = [NSTimer scheduledTimerWithTimeInterval:self.txtTimeInterval.text.floatValue
                                                    target:self
                                                  selector:@selector(addResult)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void) addResult {
    if (currentIndex < simulationResult.count) {
        [displayingResult addObject:simulationResult[currentIndex]];
        
        [self getStatesCount];
        
        [self.tblStatistics reloadData];
        [self.tblSimulation reloadData];
        
        [self.tblSimulation scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
        
        currentIndex++;
        
        [self.vwProgress setProgress:(currentIndex/(float)simulationResult.count)];
    } else {
        [currentTimer invalidate];
    }
}

- (void) getStatesCount {
    stateCounts = [NSMutableDictionary new];
    
    for (RPSimulationResult *singleResult in displayingResult) {
        if (stateCounts[singleResult.state.name] == nil) {
            [stateCounts setObject:@(1) forKey:singleResult.state.name];
        } else {
            NSNumber *count = stateCounts[singleResult.state.name];
            [stateCounts setObject:@(count.integerValue + 1) forKey:singleResult.state.name];
        }
    }
    
    [self.tblStatistics reloadData];
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
    if (tableView == self.tblStatistics) {
        return states.count;
    }
    return displayingResult.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tblStatistics) {
        return 30;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tblStatistics) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stat_cell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"Stat_cell"];
        }
        RPDiagnosticState *tmp = states[indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = tmp.name;
        cell.detailTextLabel.text = ((NSNumber*)stateCounts[tmp.name]).stringValue;
        
        return cell;
    } else {
        RPSimulationResultCell *cell = [self.tblSimulation dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"RPSimulationResultCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        }
        
        RPSimulationResult *result = displayingResult[indexPath.row];
        
        cell.lblStateName.text = result.state.name;
        cell.lblManageName.text = result.state.managementName;
        cell.lblIndex.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
        cell.lblDate.text = [NSDateFormatter localizedStringFromDate:result.date
                                                           dateStyle:NSDateFormatterShortStyle
                                                           timeStyle:NSDateFormatterShortStyle];
        NSMutableArray *array = [NSMutableArray new];
        
        for (NSNumber *value in result.resultVector) {
            NSLog(@"%.2F", [value floatValue]);
            
            [array addObject:[NSString stringWithFormat:@"%.2F", value.floatValue]];
        }
        
        cell.lblVector.text = [NSString stringWithFormat:@"(%@)", [array componentsJoinedByString:@", "]];
        
        return cell;
    }
}


@end
