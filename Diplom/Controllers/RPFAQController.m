//
//  RPFAQController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 11/05/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPFAQController.h"

@interface RPFAQController ()

@end

@implementation RPFAQController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [@"Руководство пользователя" uppercaseString];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
