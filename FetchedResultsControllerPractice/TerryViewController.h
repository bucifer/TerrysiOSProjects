//
//  TerryViewController.h
//  FetchedResultsControllerPractice
//
//  Created by Aditya Narayan on 12/11/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TerryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end
