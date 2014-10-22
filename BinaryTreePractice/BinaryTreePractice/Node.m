//
//  Node.m
//  BinaryTreePractice
//
//  Created by Aditya Narayan on 10/22/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "Node.h"

@implementation Node


-(id)initWithNameAndParent: (NSString *)nodeName parentNode: (Node *)parentNode {
    self = [super init];
    
    if (self) {
        self.name = nodeName;
        self.parent = parentNode;
    }
    return self;
}



@end
