//
//  MasterViewController.h
//  dummy
//
//  Created by Aditya Narayan on 9/22/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankInfo.h"

@interface MasterViewController : UITableViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSArray *BankInfos;


@end
