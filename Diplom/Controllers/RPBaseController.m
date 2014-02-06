//
//  RPBaseController.m
//  Diplom
//
//  Created by Pavel Rudkovsky on 02/02/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import "RPBaseController.h"
#import <objc/runtime.h>
#import "RPEventHelper.h"

#define CONTROLLER_SUFFIX @"Controller"

#define MIXPANEL_SCREEN_VIEW @"ScreenView"

@implementation RPBaseController

- (id) init {
    self = [super initWithNibName:nil bundle:nil];
    
    return self;
}

- (NSString *) nibName {
    NSString *className = [NSString stringWithCString:class_getName([self class]) encoding:NSUTF8StringEncoding];
    
    NSString *baseName;
    if ([className hasSuffix:CONTROLLER_SUFFIX]) {
        baseName = [className substringToIndex:(className.length - [CONTROLLER_SUFFIX length])];
    } else {
        baseName = className;
    }
    
    return [NSString stringWithFormat:@"%@View", baseName];
}


- (void) subscribeTo:(NSString*)notificationName withAction:(SEL)action {
    if (subscribedEvents == nil) {
        subscribedEvents = [NSMutableArray array];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:action
                                                 name:notificationName
                                               object:nil];
    
    [subscribedEvents addObject:notificationName];
}

- (void) unsubscribeFrom:(NSString*)notificationName {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
}

- (void) propagateEvent:(NSString*)eventName {
    [RPEventHelper propagateEvent:eventName];
}

- (void) propagateEvent:(NSString*)eventName withObject:(id)userValue {
    [RPEventHelper propagateEvent:eventName withObject:userValue];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRGB:0x10a8ab]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
