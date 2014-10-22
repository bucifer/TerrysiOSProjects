//
//  TerrysBinaryTree.h
//  BinaryTreePractice
//
//  Created by Aditya Narayan on 10/22/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface TerrysBinaryTree : NSObject

@property (strong, nonatomic) Node *root;
@property int numberOfNodes;





- (Node *) findClosestCommonAncestor: (Node *) nodeP secondNode: (Node *)nodeQ;



@end
