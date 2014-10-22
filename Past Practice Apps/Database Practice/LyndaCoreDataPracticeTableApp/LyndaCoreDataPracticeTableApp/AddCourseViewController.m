//
//  AddCourseViewController.m
//  LyndaCoreDataPracticeTableApp
//
//  Created by Aditya Narayan on 10/16/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "AddCourseViewController.h"

@interface AddCourseViewController ()

@end

@implementation AddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleField.text = self.currentCourse.title;
    self.authorField.text = self.currentCourse.author;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"yyyy-MM-dd"];
    self.dateField.text = [dateFormat stringFromDate:self.currentCourse.releaseDate];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    
    [self.delegate addCourseViewControllerDidCancel:[self currentCourse]];
    
    
}

- (IBAction)save:(id)sender {
    
    self.currentCourse.title = self.titleField.text;
    self.currentCourse.author = self.authorField.text;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"yyyy-MM-dd"];
    self.currentCourse.releaseDate = [dateFormat dateFromString:self.dateField.text];
    
    [self.delegate addCourseViewControllerDidSave];
}



@end
