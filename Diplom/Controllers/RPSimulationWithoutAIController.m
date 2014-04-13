//
//  RPSimulationWithoutAIController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPSimulationWithoutAIController.h"
#import "RPMethodPickerController.h"

@implementation RPSimulationWithoutAIController {
    UIPopoverController *methodPicker;
    RPMethodPickerController *methodsController;
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
    
    self.navigationController.navigationBar.backItem.title = @"";
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

@end
