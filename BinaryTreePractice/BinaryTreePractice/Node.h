//
//  Node.h
//  BinaryTreePractice
//
//  Created by Aditya Narayan on 10/22/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (strong, nonatomic) Node *leftChild;
@property (strong, nonatomic) Node *rightChild;
@property (strong, nonatomic) Node *parent;
@property (strong, nonatomic) NSString *name;





-(id)initWithNameAndParent: (NSString *)nodeName parentNode: (Node *)parentNode;





@end
