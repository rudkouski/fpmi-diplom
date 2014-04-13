//
//  RPDatePickerModalController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 12/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPDatePickerModalController.h"

@implementation RPDatePickerModalController {
    UIDatePicker *datePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    datePicker = [UIDatePicker new];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    [self setCustomView:datePicker];
}

- (void) onDone {
    if ([self.customDelegate isKindOfClass:[UITextField class]]) {
        UITextField *tmp = self.customDelegate;
        
        NSDateFormatter *newFormatter = [NSDateFormatter new];
        [newFormatter setDateStyle:NSDateFormatterShortStyle];
        [newFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        [tmp setText:[newFormatter stringFromDate:datePicker.date]];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end