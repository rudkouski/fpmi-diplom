//
//  RPBaseController.h
//  Diplom
//
//  Created by Pavel Rudkovsky on 02/02/2014.
//  Copyright (c) 2014 BSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColorAdditions.h"

@interface RPBaseController : UIViewController {
    NSMutableArray *subscribedEvents;
}

- (void) subscribeTo:(NSString*)notificationName withAction:(SEL)action;
- (void) unsubscribeFrom:(NSString*)notificationName;

- (void) propagateEvent:(NSString*)eventName;
- (void) propagateEvent:(NSString*)eventName withObject:(id)userValue;

- (void) addGradient:(UIView *) _button;
- (void) addGradientForButton:(UIButton *) _button;

@end
