//
//  ViewController.m
//  BinaryTreePractice
//
//  Created by Aditya Narayan on 10/22/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    TerrysBinaryTree *myCustomBinaryTree = [[TerrysBinaryTree alloc]init];
    NSLog(@"%@", myCustomBinaryTree.root);
    
    Node *NodeA = [[Node alloc]init];
    NodeA.name = @"A";
    myCustomBinaryTree.root = NodeA;
    
    NSLog(@"%@", myCustomBinaryTree.root.name);

    Node *NodeB = [[Node alloc]initWithNameAndParent:@"B" parentNode:NodeA];
    Node *NodeC = [[Node alloc]initWithNameAndParent:@"C" parentNode:NodeA];

//    NSLog(@"%d", myCustomBinaryTree.numberOfNodes);
    
    myCustomBinaryTree.root.leftChild = NodeB;
    myCustomBinaryTree.root.rightChild = NodeC;
    
    NSLog(@"%@", [myCustomBinaryTree findClosestCommonAncestor:NodeB secondNode:NodeC].name);
    NSLog(@"%@", [myCustomBinaryTree findClosestCommonAncestor:nil secondNode:NodeC]);
    
    
    Node *NodeD = [[Node alloc]initWithNameAndParent:@"D" parentNode:NodeC];
    Node *NodeE = [[Node alloc]initWithNameAndParent:@"E" parentNode:NodeC];
    Node *NodeF = [[Node alloc]initWithNameAndParent:@"F" parentNode:NodeE];
    Node *NodeG = [[Node alloc]initWithNameAndParent:@"G" parentNode:NodeE];
    
    NodeC.leftChild = NodeD;
    NodeC.rightChild = NodeE;
    NodeE.leftChild = NodeF;
    NodeE.rightChild = NodeG;
    
    NSLog(@"%@", [myCustomBinaryTree findClosestCommonAncestor:NodeD secondNode:NodeF].name);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
