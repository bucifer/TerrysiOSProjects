//
//  LeftTableViewController.h
//  Raywenderlich-Splitview
//
//  Created by Aditya Narayan on 9/30/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonsterSelectionDelegate.h"

@interface LeftTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *monsters;
@property (nonatomic, assign) id <MonsterSelectionDelegate> delegate;

@end
