//
//  ViewController.m
//  UIScrollViewPractice
//
//  Created by Aditya Narayan on 10/8/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CGSize keyboardSize;
    int width;
    int height;
    UITextField *activeField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.myScrollView setScrollEnabled:YES];
    [self.myScrollView setContentSize:(CGSizeMake(320, 800))];
    
    self.myTextFieldGetsCoveredByKeyboard.delegate = self;
    self.secondTextField.delegate = self;
    self.thirdTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.myTextFieldGetsCoveredByKeyboard resignFirstResponder];
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    activeField = nil;
}



-(void)dismissKeyboard {
    [self.myTextFieldGetsCoveredByKeyboard resignFirstResponder];
    [self.secondTextField resignFirstResponder];
    [self.thirdTextField resignFirstResponder];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    // Get the size of the keyboard.
    keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    width = keyboardSize.width;
    height = keyboardSize.height;
    NSLog(@"keyboardstats --> width: %d height: %d", width, height);
    
    // Step 2: Adjust the bottom contentinset (padding) of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.myScrollView.contentInset = contentInsets;
    self.myScrollView.scrollIndicatorInsets = contentInsets;
    
    // Step 3: Draw a virtual rectangle, and set its height to the entire view height minus the keyboard height
    // Now, that rectangle symbolizes what the user sees with the keyboard showing
    // We find the active text field's Y coordinate
    // We check if the rectangle contains the Y coordinate - which means thay keyboard is NOT HIDING the textfield - so we do nothing
    // But if the rectangle does NOT contain the Y coordinate - then we move our scrollView
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y - (keyboardSize.height));
        [self.myScrollView setContentOffset:scrollPoint animated:YES];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.myScrollView.contentInset = contentInsets;
    self.myScrollView.scrollIndicatorInsets = contentInsets;
}

@end
