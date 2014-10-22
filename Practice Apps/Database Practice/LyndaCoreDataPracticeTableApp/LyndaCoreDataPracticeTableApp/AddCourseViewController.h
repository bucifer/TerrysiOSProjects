//
//  AddCourseViewController.h
//  LyndaCoreDataPracticeTableApp
//
//  Created by Aditya Narayan on 10/16/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@protocol AddCourseViewControllerDelegate;



@interface AddCourseViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextField *authorField;
@property (strong, nonatomic) IBOutlet UITextField *dateField;

@property (strong, nonatomic) Course *currentCourse;
@property (nonatomic, weak) id <AddCourseViewControllerDelegate> delegate;


- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end



//this is to pass around behavior between CoursesTVC and this viewcontroller
@protocol AddCourseViewControllerDelegate

- (void) addCourseViewControllerDidSave;
- (void) addCourseViewControllerDidCancel: (Course *) courseToDelete;


@end