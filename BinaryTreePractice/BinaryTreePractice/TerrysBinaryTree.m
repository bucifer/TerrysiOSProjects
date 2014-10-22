//
//  TerrysBinaryTree.m
//  BinaryTreePractice
//
//  Created by Aditya Narayan on 10/22/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "TerrysBinaryTree.h"


@implementation TerrysBinaryTree





- (Node *) findClosestCommonAncestor: (Node *) nodeP secondNode: (Node *)nodeQ {
    
    //handle exceptions first
    if (nodeP == nil || nodeQ == nil)
        return nil;
    else if (nodeP == nodeQ)
        return nodeP;
    
    //handle regular case
    NSMutableArray *nodeParentsArray = [[NSMutableArray alloc]init];
    while (nodeP.parent != nil) {
        [nodeParentsArray addObject:nodeP.parent];
        nodeP = nodeP.parent;
    }
    
    while (nodeQ.parent != nil) {
        for (Node* node in nodeParentsArray) {
            if (node == nodeQ.parent) {
                return node;
            }
        }
        nodeQ = nodeQ.parent;
    }
    
    return self.root;
    
}


@end
