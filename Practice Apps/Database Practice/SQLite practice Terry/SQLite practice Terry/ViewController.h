//
//  ViewController.h
//  SQLite practice Terry
//
//  Created by Aditya Narayan on 9/17/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Person.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *nameTextfield;

@property (strong, nonatomic) IBOutlet UITextField *ageTextfield;

@property (strong, nonatomic) IBOutlet UITableView *myTableview;

- (IBAction)addPersonButton:(id)sender;

- (IBAction)deletePersonbutton:(id)sender;


@end
