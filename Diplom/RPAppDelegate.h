//
//  RPAppDelegate.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 02/02/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPStartController;

@interface RPAppDelegate : UIResponder <UIApplicationDelegate> {
    RPStartController *rootController;
}

@property (strong, nonatomic) UIWindow *window;

@end
