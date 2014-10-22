//
//  Car.h
//  Exercise - Classes_Objects in Objective-C
//
//  Created by Aditya Narayan on 9/5/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Car : NSObject
@property NSString *company;
@property NSString *model;
@property NSNumber *year;
@property Person *currentOwner;

@end
