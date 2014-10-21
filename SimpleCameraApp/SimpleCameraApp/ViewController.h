//
//  ViewController.h
//  SimpleCameraApp
//
//  Created by Aditya Narayan on 10/21/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

- (IBAction)cameraToolbarButtonPressedAction:(id)sender;

@end

