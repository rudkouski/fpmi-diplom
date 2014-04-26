//
//  RPModelPreviewController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 26/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPModelPreviewController.h"
#import "RPModelPreviewModalController.h"

@implementation RPModelPreviewController {
    RPModelPreviewModalController *previewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    previewController = [RPModelPreviewModalController new];
    rootController.title = @"Модель";
    rootController.view.backgroundColor = previewController.view.backgroundColor;
    
    previewController.view.frame = CGRectMake(0, 45, 500, 500);
    
    [rootController.view addSubview:previewController.view];
}

@end
