//
//  ABContactsGrabberDAO.h
//  AddressbookContactsGrabber
//
//  Created by TB on 10/23/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "Contact.h"

@protocol ABContactsGrabberDAODelegate;

@interface ABContactsGrabberDAO : NSObject

@property (nonatomic, weak) id <ABContactsGrabberDAODelegate> delegate;


@property (nonatomic, strong) NSMutableArray *filteredContactsArrayWhoHavePhoneNumbers;
@property (nonatomic, strong) NSMutableArray *arrayOfNewContactsNeverInvitedLastSync;


- (void) runGrabContactsOnBackgroundQueue;
- (void) checkForABAuthorizationAndStartRun;
- (void) grabContactsWithAPhoneNumber;
- (Contact *) createContactObjectBasedOnAddressBookRecord: (ABRecordRef) myABRecordRef;

- (void) startListeningForABChanges;

- (void) printOutAllInFetchedArray;
    
@end



//in case we want to use delegates
@protocol ABContactsGrabberDAODelegate

- (void) DAOdidFinishFilteringContactsForPhoneNumbers;
- (void) authorizationProblemHappened;

@end