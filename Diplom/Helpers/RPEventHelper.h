//
//  RPEventHelper.h
//  Transpot
//
//  Created by Pavel Rudkovsky on 24/01/2014.
//
//

#import <Foundation/Foundation.h>

@interface RPEventHelper : NSObject

+ (void) propagateEvent:(NSString*)eventName;
+ (void) propagateEvent:(NSString*)eventName withObject:(id)userValue;

+ (NSObject*) valueFromEvent:(NSNotification*)event;

@end
