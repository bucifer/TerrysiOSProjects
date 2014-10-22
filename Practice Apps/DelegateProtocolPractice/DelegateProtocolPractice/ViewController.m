//
//  ViewController.m
//  DelegateProtocolPractice
//
//  Created by Aditya Narayan on 10/17/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"goThere"]) {
        MySecondViewController *msvc = [segue destinationViewController];
        msvc.delegate = self;
    }
    
}


- (void) mySecondViewControllerDidClickOnButton {
    
    [self customMethodOnlyForThisClass];
}

- (void) customMethodOnlyForThisClass {
    
    NSLog(@"Mad custom logic called from first viewcontroller!!");
    
}

@end
