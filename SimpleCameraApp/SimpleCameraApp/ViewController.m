//
//  ViewController.m
//  SimpleCameraApp
//
//  Created by Aditya Narayan on 10/21/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
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

- (IBAction)cameraToolbarButtonPressedAction:(id)sender {

    UIImagePickerController *myImagePickerController = [[UIImagePickerController alloc]init];
    
    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ){
        
        [myImagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else {
        NSLog(@"camera not available");
    }
    myImagePickerController.delegate = self;

    [self presentViewController:myImagePickerController animated:YES completion:NULL];

}



@end
