//
//  ABContactsGrabberDAO.h
//  AddressbookContactsGrabber
//
//  Created by Aditya Narayan on 10/23/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@protocol ABContactsGrabberDAODelegate;

@interface ABContactsGrabberDAO : NSObject


@property (nonatomic, weak) id <ABContactsGrabberDAODelegate> delegate;
@property (nonatomic, strong) NSMutableArray *filteredContactsArrayWhoHavePhoneNumbers;

- (void) checkForAuthorizationAndAdd;
- (void) addNewPersonInAddressBook: (NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *) phoneNumber;

- (void) grabContactsOnBackgroundQueue;
- (void) grabOnlyContactsWithPhoneNumber;

    
    
    
@end




@protocol ABContactsGrabberDAODelegate

- (void) DAOdidFinishAddingContact;
- (void) authorizationProblemHappened;

@end