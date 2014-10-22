//
//  JuiceHolder.m
//  MemoryManagementPracticeiOS
//
//  Created by Aditya Narayan on 10/14/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "JuiceHolder.h"

@implementation JuiceHolder {
    NSMutableArray *_inventory;
}

- (NSMutableArray *) inventory {
    return _inventory;
}

- (void)setInventory:(NSMutableArray *)newInventory {
    
    NSMutableArray *oldArray = _inventory;
    _inventory = [newInventory retain];
    [oldArray release];
}

+ (JuiceHolder *) juiceStoreFactoryMethod {
    JuiceHolder* juiceHolder = [[JuiceHolder alloc]init];
    return [juiceHolder autorelease];
}

@end
