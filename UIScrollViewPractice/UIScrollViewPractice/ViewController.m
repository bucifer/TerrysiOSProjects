//
//  ViewController.m
//  UIScrollViewPractice
//
//  Created by Aditya Narayan on 11/5/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.contentSize = CGSizeMake(600, 2000);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
