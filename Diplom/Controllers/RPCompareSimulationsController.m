//
//  RPCompareSimulationsController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 04/05/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPCompareSimulationsController.h"
#import "RPDiagnosticState.h"

@implementation RPCompareSimulationsController {
    NSMutableArray *states;
    NSDictionary *stateCounts;
    NSDictionary *stateCounts_AI;
    
    NSUserDefaults *defaults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Сравнение результатов моделирования I-II";
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    for (UILabel *lblTitle in self.lblTitles) {
        [lblTitle setFont:[UIFont fontWithName:@"SegoeUI" size:lblTitle.font.pointSize]];
        
        [self addGradient:lblTitle];
    }
    
    self.navigationController.navigationBar.backItem.title = @"";
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *dataRepresentingSavedArray = [defaults objectForKey:@"diagnosticStates"];
    NSMutableArray *diagnosticStates;
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            diagnosticStates = [[NSMutableArray alloc] initWithArray:oldSavedArray];
            states = diagnosticStates;
        }
    }
    
    stateCounts = [defaults objectForKey:@"RESULT"];
    stateCounts_AI = [defaults objectForKey:@"RESULT_AI"];
    
    self.lblDialogCenter.text = [defaults objectForKey:@"RESULT_DIALOG_CENTER"];
    self.lblDialogCenterAI.text = [defaults objectForKey:@"RESULT_AI_DIALOG_CENTER"];
    
    self.lblDialogMGO.text = [defaults objectForKey:@"RESULT_DIALOG_MGO"];
    self.lblDialogMGOAI.text = [defaults objectForKey:@"RESULT_AI_DIALOG_MGO"];
    
    CGFloat result = self.lblDialogCenter.text.floatValue / self.lblDialogCenterAI.text.floatValue;
    
    self.lblResult.text = [NSString stringWithFormat:@"￼Эффективность AI = %@ / %@ = %.2F %%", self.lblDialogCenter.text, self.lblDialogCenterAI.text, result*100];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return states.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tblWithoutAI) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stat_cell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"Stat_cell"];
        }
        
        RPDiagnosticState *tmp = states[indexPath.row];
        
        //    [defaults setObject:stateCounts forKey:@"RESULT"];
        //    [defaults setObject:self.lblDialogPercentCenter.text forKey:@"RESULT_DIALOG_CENTER"];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = tmp.name;
        cell.detailTextLabel.text = ((NSNumber*)stateCounts[tmp.name]).stringValue;
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stat_cell_AI"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"Stat_cell_AI"];
        }
        
        RPDiagnosticState *tmp = states[indexPath.row];
        
        //    [defaults setObject:stateCounts forKey:@"RESULT"];
        //    [defaults setObject:self.lblDialogPercentCenter.text forKey:@"RESULT_DIALOG_CENTER"];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = tmp.name;
        cell.detailTextLabel.text = ((NSNumber*)stateCounts_AI[tmp.name]).stringValue;
        
        return cell;
    }
}

@end
