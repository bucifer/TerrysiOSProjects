//
//  DisplayEditViewController.m
//  LyndaCoreDataPracticeTableApp
//
//  Created by Aditya Narayan on 10/16/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "DisplayEditViewController.h"
#import "AppDelegate.h"

@interface DisplayEditViewController ()

@end

@implementation DisplayEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleField.text = self.currentCourse.title;
    self.authorField.text = self.currentCourse.author;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    self.dateField.text = [df stringFromDate:self.currentCourse.releaseDate];
    
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

- (IBAction)startEditing:(id)sender {
    self.titleField.enabled = YES;
    self.authorField.enabled = YES;
    self.dateField.enabled = YES;
    
    self.titleField.borderStyle = UITextBorderStyleRoundedRect;
    self.authorField.borderStyle = UITextBorderStyleRoundedRect;
    self.dateField.borderStyle = UITextBorderStyleRoundedRect;


    self.editButton.hidden = YES;
    self.doneButton.hidden = NO;
}

- (IBAction)doneEditing:(id)sender {
    self.titleField.enabled = NO;
    self.authorField.enabled = NO;
    self.dateField.enabled = NO;
    
    self.titleField.borderStyle = UITextBorderStyleNone;
    self.authorField.borderStyle = UITextBorderStyleNone;
    self.dateField.borderStyle = UITextBorderStyleNone;
    
    
    self.editButton.hidden = NO;
    self.doneButton.hidden = YES;
    
    
    self.currentCourse.title = self.titleField.text;
    self.currentCourse.author = self.authorField.text;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM--dd"];
    self.currentCourse.releaseDate = [df dateFromString:self.dateField.text];
    
    AppDelegate *myApp = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [myApp saveContext];
    
}
@end
