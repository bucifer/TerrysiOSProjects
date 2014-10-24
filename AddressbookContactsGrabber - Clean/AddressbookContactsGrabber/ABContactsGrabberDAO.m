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
        [self.delegate authorizationProblemHappened];
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
        NSString *personFullName = (__bridge NSString *) ABRecordCopyCompositeName(thisContact);
        
        //check for phone number existence - if the record does have a phone number, push to our array and send invite
        if (ABMultiValueGetCount(mvr) != 0) {
            Contact *myNewContactObject = [self createContactObjectBasedOnAddressBookRecord:thisContact];
            [resultsArray addObject:myNewContactObject];
            [self sendSplitInviteToContactObject: myNewContactObject];
        }
        else {
            NSLog(@"found a contact without any phone number at %@", personFullName);
        }
    }
    
    self.filteredContactsArrayWhoHavePhoneNumbers = resultsArray;
    [self printOutAllInFetchedArray];
}


- (Contact *) createContactObjectBasedOnAddressBookRecord: (ABRecordRef) myABRecordRef {
    Contact *myContactObject = [[Contact alloc]init];
    myContactObject.firstName = (__bridge NSString *)(ABRecordCopyValue(myABRecordRef, kABPersonFirstNameProperty));
    myContactObject.lastName = (__bridge NSString *)(ABRecordCopyValue(myABRecordRef, kABPersonLastNameProperty));
    ABMultiValueRef mvr = ABRecordCopyValue(myABRecordRef, kABPersonPhoneProperty);
    myContactObject.mobileNumber =  (__bridge NSString *)(ABMultiValueCopyValueAtIndex(mvr, 0));
    
    return myContactObject;
}






- (void) sendSplitInviteToContactObject: (Contact *)someContact {
//    NSLog(@"dummy method");
    someContact.inviteAlreadySentFlag = YES;
}




- (void) printOutAllInFetchedArray {
    for (int i=0; i < self.filteredContactsArrayWhoHavePhoneNumbers.count; i++) {
        Contact *contact = self.filteredContactsArrayWhoHavePhoneNumbers[i];
        NSLog(@"%@ %@", contact.firstName, contact.lastName);
    }
}



@end
