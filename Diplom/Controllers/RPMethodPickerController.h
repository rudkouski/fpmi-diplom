//
//  RPMethodPickerController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 13/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPMethodPickerController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id customDelegate;
@property (strong, nonatomic) UIPopoverController *parentController;

@end
