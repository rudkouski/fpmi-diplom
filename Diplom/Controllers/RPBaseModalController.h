//
//  RPBaseModalController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 12/04/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPBaseModalController : UINavigationController {
    UIViewController *rootController;
}

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) id customDelegate;

- (void) setCustomView:(UIView*)view;
- (void) onDone;

@end
