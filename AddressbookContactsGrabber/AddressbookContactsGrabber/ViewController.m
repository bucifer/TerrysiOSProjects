//
//  ViewController.m
//  AddressbookContactsGrabber
//
//  Created by Aditya Narayan on 10/23/14.
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
    
    [self.DAO addNewPersonInAddressBook:@"Jeremy" lastName:@"Lin" phoneNumber:@"2019535443"];
    [self.DAO addNewPersonInAddressBook:@"Amare" lastName:@"DontHavePhoneNumber" phoneNumber:nil];
    [self.DAO addNewPersonInAddressBook:@"I" lastName:@"HavePhoneNumber" phoneNumber:@"1111111111"];

    [self.DAO grabContactsOnBackgroundQueue];

}

- (void) DAOdidFinishFilteringContactsForPhoneNumbers {
    NSLog(@"%@", self.DAO.filteredContactsArrayWhoHavePhoneNumbers.description);

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
