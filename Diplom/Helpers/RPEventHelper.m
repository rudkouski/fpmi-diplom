//
//  RPEventHelper.m
//  Transpot
//
//  Created by Pavel Rudkovsky on 24/01/2014.
//
//

#import "RPEventHelper.h"

@implementation RPEventHelper

+ (void) propagateEvent:(NSString*)eventName {
    [[NSNotificationCenter defaultCenter] postNotificationName:eventName object:self userInfo:[NSDictionary dictionary]];
}

+ (void) propagateEvent:(NSString*)eventName withObject:(id)userValue {
    NSDictionary *userInfoDictionary = [NSDictionary dictionaryWithObjectsAndKeys:userValue, eventName, nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:eventName object:self userInfo:userInfoDictionary];
}

+ (NSObject*) valueFromEvent:(NSNotification*)event {
    return [event.userInfo objectForKey:event.name];
}

@end
