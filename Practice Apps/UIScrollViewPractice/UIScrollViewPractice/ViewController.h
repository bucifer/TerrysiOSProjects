//
//  ViewController.h
//  UIScrollViewPractice
//
//  Created by Aditya Narayan on 10/8/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) IBOutlet UITextField *myTextFieldGetsCoveredByKeyboard;

@property (strong, nonatomic) IBOutlet UITextField *secondTextField;

@property (strong, nonatomic) IBOutlet UITextField *thirdTextField;

@end

