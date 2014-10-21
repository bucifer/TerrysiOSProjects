//
//  CustomViewController.h
//  xibPractice2
//
//  Created by Aditya Narayan on 10/21/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewController : UIViewController


@property (strong, nonatomic) UINavigationController *navController;

- (IBAction)goToSecondVC:(id)sender;

@end
