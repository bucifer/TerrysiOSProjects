//
//  ViewController.h
//  DelegateProtocolPractice
//
//  Created by Aditya Narayan on 10/17/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySecondViewController.h"



@interface ViewController : UIViewController <MySecondViewControllerDelegate>



- (void) customMethodOnlyForThisClass; 

@end

