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



- (void) runGrabContactsOnBackgroundQueue;
- (void) grabContactsWithAPhoneNumber;
- (Contact *) createContactObjectBasedOnAddressBookRecord: (ABRecordRef) myABRecordRef;



//test methods just to add records to addressbook
- (void) checkForAuthorizationAndAdd: (NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *) phoneNumber;
- (void) addNewPersonInAddressBook: (NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *) phoneNumber;

    
@end



//in case we want to use delegates
@protocol ABContactsGrabberDAODelegate

- (void) DAOdidFinishFilteringContactsForPhoneNumbers;
- (void) DAOdidFinishAddingContact;

- (void) authorizationProblemHappened;

@end