//
//  ViewController.m
//  fpdsajfpsa
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
    
    
    NSMutableString *emptyResult = [[NSMutableString alloc]init];
    NSString *originalWord = @"Terry Bu";
    
    for (int i = originalWord.length-1; i >= 0 ; i--) {
        [emptyResult appendString:[originalWord substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSLog(@"%@", emptyResult);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
