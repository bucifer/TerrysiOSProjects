//
//  Drivers.h
//  faveCars
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cars;

@interface Drivers : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Cars *cars;

@end
