//
//  ViewController.m
//  UsingPList
//
//  Created by Aditya Narayan on 11/10/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"CompaniesList" withExtension:@"plist"];
    NSDictionary *myDictionary = [[NSDictionary alloc]initWithContentsOfURL:url];
    for(id key in myDictionary)
        NSLog(@"key=%@ value=%@", key, [myDictionary objectForKey:key]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
