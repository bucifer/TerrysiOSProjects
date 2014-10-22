//
//  MySecondViewController.h
//  DelegateProtocolPractice
//
//  Created by Aditya Narayan on 10/17/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MySecondViewControllerDelegate;

@interface MySecondViewController : UIViewController

@property (nonatomic, weak) id <MySecondViewControllerDelegate> delegate;


- (IBAction)myButtonAction:(id)sender;




@end


@protocol MySecondViewControllerDelegate

- (void) mySecondViewControllerDidClickOnButton;


@end
