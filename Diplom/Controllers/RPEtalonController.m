//
//  RPEtalonController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 15/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPEtalonController.h"
#import "RPDiagnosticState.h"
#import "UIColorAdditions.h"

@implementation RPEtalonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSInteger numberOfValues = [self.values count];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 540, 60)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = [NSString stringWithFormat:@"Введите для каждого состояния эталонный вектор из %d показателей", numberOfValues];
    title.numberOfLines = 0;
    
    [rootController.view addSubview:title];
    
    rootController.title = @"Эталоны";
    
    for (NSInteger index = 0; index < self.states.count; index++) {
        RPDiagnosticState *currentState = self.states[index];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 120 + 50 * index, 130, 30)];
        lblTitle.text = currentState.name;
        
        [rootController.view addSubview:lblTitle];
        
        UITextField *txtVector = [[UITextField alloc] initWithFrame:CGRectMake(lblTitle.frame.origin.x + lblTitle.frame.size.width + 5, lblTitle.frame.origin.y, 350, 30)];
        txtVector.borderStyle = UITextBorderStyleBezel;
        
        if (currentState.etalon != nil) {
            txtVector.text = [currentState.etalon componentsJoinedByString:@", "];
        }
        
        RAC(lblTitle, textColor) = [[txtVector rac_textSignal] map:^id(NSString *text) {
            NSArray *values = [text componentsSeparatedByString:@","];
            if (values.count == numberOfValues) {
                for (NSString *singleValue in values) {
                    if (![self isNumeric:singleValue]) return [UIColor redColor];
                }
                
                currentState.etalon = values;
                return [UIColor colorWithRGB:0x006400];
            } else {
                return [UIColor redColor];
            }
        }];
    
        [rootController.view addSubview:txtVector];
    }
}

- (BOOL) isNumeric:(NSString*) checkText{
    return [[NSScanner scannerWithString:[checkText stringByReplacingOccurrencesOfString:@" " withString:@""]] scanFloat:NULL];
}

@end
