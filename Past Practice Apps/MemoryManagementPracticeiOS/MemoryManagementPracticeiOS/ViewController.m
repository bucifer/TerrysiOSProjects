//
//  ViewController.m
//  MemoryManagementPracticeiOS
//
//  Created by Aditya Narayan on 10/14/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ViewController.h"
#import "JuiceHolder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *myArray = [[NSMutableArray alloc]init];
    [myArray addObject:@"Apple Juice"];
    
    JuiceHolder *juiceHolder = [[JuiceHolder alloc]init];
    [juiceHolder setInventory:myArray];
    
    [myArray release];

    NSLog(@"%@", [juiceHolder inventory]);

    [juiceHolder release];
    
    
    [JuiceHolder juiceStoreFactoryMethod];
    
    NSLog(@"%@", [juiceHolder inventory]);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
