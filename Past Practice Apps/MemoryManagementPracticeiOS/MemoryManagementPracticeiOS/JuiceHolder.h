//
//  JuiceHolder.h
//  MemoryManagementPracticeiOS
//
//  Created by Aditya Narayan on 10/14/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JuiceHolder : NSObject

- (NSMutableArray *)inventory;
- (void)setInventory:(NSMutableArray *)newInventory;
+ (JuiceHolder *) juiceStoreFactoryMethod;

@end
