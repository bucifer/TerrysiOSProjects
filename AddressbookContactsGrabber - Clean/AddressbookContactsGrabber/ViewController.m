//
//  ViewController.m
//  AddressbookContactsGrabber
//
//  Created by TB on 10/23/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ABContactsGrabberDAO *myDAO = [[ABContactsGrabberDAO alloc]init];
    self.DAO = myDAO;
    myDAO.delegate = self;

    
    [self.DAO loadOrGrabOnFirstRunLogic];
    
    
}



- (void) DAOdidFinishFilteringContactsForPhoneNumbers {
    self.syncTimeLabel.text = self.DAO.lastContactsSyncTime;
}

- (void) DAOdidFinishSyncAttempt {
    self.syncTimeLabel.text = self.DAO.lastContactsSyncTime;
}



- (IBAction)syncActionButton:(id)sender {
    
    [self.DAO findContactsThatNeverGotInvited];
    
}


- (void) DAOdidFinishAddingContact {
    UIAlertView *contactAddedAlert = [[UIAlertView alloc]initWithTitle:@"Contact Added" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [contactAddedAlert show];
}

- (void) authorizationProblemHappened {
    UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact" message: @"You must give the app permission to add the contact first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [cantAddContactAlert show];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
