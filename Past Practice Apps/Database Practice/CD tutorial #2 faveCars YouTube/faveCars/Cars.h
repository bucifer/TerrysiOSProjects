//
//  Cars.h
//  faveCars
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Drivers.h"

@interface Cars : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSSet *drivers;
@end

@interface Cars (CoreDataGeneratedAccessors)

- (void)addDriversObject:(Drivers *)value;
- (void)removeDriversObject:(Drivers *)value;
- (void)addDrivers:(NSSet *)values;
- (void)removeDrivers:(NSSet *)values;

@end
