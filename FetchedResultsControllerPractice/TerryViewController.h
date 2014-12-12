//
//  TerryViewController.h
//  FetchedResultsControllerPractice
//
//  Created by Aditya Narayan on 12/11/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TerryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)editButton:(id)sender;

@end
