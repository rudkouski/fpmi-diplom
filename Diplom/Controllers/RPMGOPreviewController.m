//
//  RPMGOPreviewController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 08/05/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPMGOPreviewController.h"
#import "RPMGOImageController.h"

@implementation RPMGOPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Модель МГО";
    self.view.frame = CGRectMake(0, 45, 500, 500);
    
    self.modalController = [RPMGOImageController new];
    self.modalController.view.frame = CGRectMake(0, 45, 500, 500);
    
    rootController.title = @"Модель МГО";
    [rootController.view addSubview:self.modalController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
