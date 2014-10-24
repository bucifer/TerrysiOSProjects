//
//  ViewController.h
//  AddressbookContactsGrabber
//
//  Created by TB on 10/23/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "ABContactsGrabberDAO.h"

@interface ViewController : UIViewController <ABContactsGrabberDAODelegate>



@property ABContactsGrabberDAO *DAO;


@property (strong, nonatomic) IBOutlet UILabel *syncTimeLabel;


void ABAddressBookRegisterExternalChangeCallback (
                                                  ABAddressBookRef addressBook,
                                                  ABExternalChangeCallback callback,
                                                  void *context
                                                  );

    
    
@end

