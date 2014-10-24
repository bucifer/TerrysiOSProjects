//
//  ABContactsGrabberDAO.m
//  AddressbookContactsGrabber
//
//  Created by TB on 10/23/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "ABContactsGrabberDAO.h"

@implementation ABContactsGrabberDAO


#pragma mark Grabbing from Addressbook
- (void) runGrabContactsOnBackgroundQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(checkForABAuthorizationAndStartRun)
                                                                              object:nil];
    [queue addOperation:operation];
}



- (void) checkForABAuthorizationAndStartRun {
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //1
        NSLog(@"you must allow app permissions to access your contacts from this app");
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
        [self grabContactsWithAPhoneNumber];
    } else { //case of ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        //3
        NSLog(@"Not determined");
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            if (!granted){
                //4
                NSLog(@"you must allow app permissions to access your contacts from this app");
                return;
            }
            //5
            NSLog(@"Authorized");
            [self grabContactsWithAPhoneNumber];
        });
    }
}

- (void) grabContactsWithAPhoneNumber {
    NSMutableArray *resultsArray = [[NSMutableArray alloc]init];
    
    CFErrorRef error = nil;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, &error); // indirection
    if (!addressBookRef) // test the result, not the error
    {
        NSLog(@"error: %@", error);
        return; // bail
    }
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    for (id record in allContacts){
        ABRecordRef thisContact = (__bridge ABRecordRef)record;
        ABMultiValueRef mvr = ABRecordCopyValue(thisContact, kABPersonPhoneProperty);
        //check for phone number existence - if the record does have a phone number, push to our array
        if (ABMultiValueGetCount(mvr) != 0) {
            Contact *myNewContactObject = [self createContactObjectBasedOnAddressBookRecord:thisContact];
            [resultsArray addObject:myNewContactObject];
        }
        else {
//            NSLog(@"found a contact without any phone number at %@", personFullName);
        }
    }
    
    self.savedArrayOfContactsWithPhoneNumbers = resultsArray;

}




- (Contact *) createContactObjectBasedOnAddressBookRecord: (ABRecordRef) myABRecordRef {
    Contact *myContactObject = [[Contact alloc]init];
    myContactObject.firstName = (__bridge NSString *)(ABRecordCopyValue(myABRecordRef, kABPersonFirstNameProperty));
    myContactObject.lastName = (__bridge NSString *)(ABRecordCopyValue(myABRecordRef, kABPersonLastNameProperty));
    ABMultiValueRef mvr = ABRecordCopyValue(myABRecordRef, kABPersonPhoneProperty);
    myContactObject.mobileNumber =  (__bridge NSString *)(ABMultiValueCopyValueAtIndex(mvr, 0));
    
    return myContactObject;
}




- (void) startListeningForABChanges {
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil); // indirection
    ABAddressBookRegisterExternalChangeCallback(addressBookRef, addressBookChanged, (__bridge void *)(self));
}



void ABAddressBookRegisterExternalChangeCallback (
                                                  ABAddressBookRef addressBook,
                                                  ABExternalChangeCallback callback,
                                                  void *context
);


void addressBookChanged(ABAddressBookRef abRef, CFDictionaryRef dicRef, void *context) {
    
    NSLog(@"Some Address Book Change Detected");
    
    //C function would not let me use [self] so had to do a funky
    ABContactsGrabberDAO *myDAO = (__bridge ABContactsGrabberDAO *)(context);
    [myDAO addNewContactsIntoCustomArray];
}




- (void) addNewContactsIntoCustomArray {
    CFErrorRef error = nil;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, &error); // indirection
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    //iterate through the addressbook
    
    
    //iterate through your existing array and create a new array with just the phone number from each contact
    NSMutableArray *allPhoneNumbersFromExistingArray = [[NSMutableArray alloc]init];
    for (int i=0; i < self.savedArrayOfContactsWithPhoneNumbers.count; i++) {
        Contact *selectedContact = self.savedArrayOfContactsWithPhoneNumbers[i];
        [allPhoneNumbersFromExistingArray addObject:selectedContact.mobileNumber];
    }
    
    //looping through every record in the AB, find its phone number, match it against the above phone number array
    //if the above array does not have that phone number, we add the entire contact to saved array
    //if the phone number is missing or invalid, we don't do anything
    for (id record in allContacts){
        ABRecordRef thisContact = (__bridge ABRecordRef)record;
        ABMultiValueRef mvr = ABRecordCopyValue(thisContact, kABPersonPhoneProperty);
        NSString *mobileNumber =  (__bridge NSString *)(ABMultiValueCopyValueAtIndex(mvr, 0));

        if (![allPhoneNumbersFromExistingArray containsObject:mobileNumber]) {
            if ([self thisPhoneNumberIsValid:mobileNumber]) {
                Contact *contact = [self createContactObjectBasedOnAddressBookRecord:thisContact];
                [self.savedArrayOfContactsWithPhoneNumbers addObject:contact];
                NSLog(@"Added a new contact %@ %@ to our saved array", contact.firstName, contact.lastName);
            }
            else {
//                NSLog(@"Invalid phone number found. Not adding to saved array");
            }
        }

    }
}


- (void) printOutAllInFetchedArray {
    for (int i=0; i < self.savedArrayOfContactsWithPhoneNumbers.count; i++) {
        Contact *contact = self.savedArrayOfContactsWithPhoneNumbers[i];
        NSLog(@"%@ %@", contact.firstName, contact.lastName);
    }
}

- (BOOL) thisPhoneNumberIsValid: (NSString *) somePhoneNumber {
    
    if (somePhoneNumber == nil)
        return NO;
    
    return YES;
    
}

@end
