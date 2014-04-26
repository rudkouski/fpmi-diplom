//
//  RPModelPreviewModalController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 26/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPModelPreviewModalController.h"
#import "RPModelPreviewCell.h"
#import "RPDiagnosticState.h"
#import "RPDiagnosticObject.h"

@implementation RPModelPreviewModalController {
    NSMutableArray *diagnosticStates;
    NSMutableArray *diagnosticValues;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *dataRepresentingSavedArray = [defaults objectForKey:@"diagnosticStates"];
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            diagnosticStates = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        }
    }
    
    dataRepresentingSavedArray = [defaults objectForKey:@"diagnosticValues"];
    
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil) {
            diagnosticValues = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        }
    }
    
    if (diagnosticValues.count > 0) {
        // Create the attributes
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil];
        NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
        
//        self.lblObjects.text = ((RPDiagnosticObject*)[diagnosticValues objectAtIndex:0]).name;
        
        NSMutableAttributedString *fullString = [NSMutableAttributedString new];
        
        for (RPDiagnosticObject *object in diagnosticValues) {
            if (object.isBiffValue) {
                NSString *str = fullString.length == 0 ? @"" : @", ";
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[str stringByAppendingString:object.name]
                                                                                                   attributes:subAttrs];
                [attributedText setAttributes:attrs range:NSMakeRange(1, attributedText.length-1)];
                [fullString appendAttributedString:attributedText];
            } else {
                NSString *str = fullString.length == 0 ? @"" : @", ";
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[str stringByAppendingString:object.name]
                                                                                                   attributes:subAttrs];
                [attributedText setAttributes:subAttrs range:NSMakeRange(1, attributedText.length-1)];
                [fullString appendAttributedString:attributedText];
            }
        }
        
        self.lblObjects.attributedText = fullString;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RPModelPreviewCell *cell = [self.tblModel dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"RPModelPreviewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    
    RPDiagnosticState *state = diagnosticStates[indexPath.row];
    
    cell.lblState.text = state.name;
    cell.lblManage.text = state.managementName;
    cell.lblEtalon.text = [state.etalon componentsJoinedByString:@", "];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return diagnosticStates.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

@end