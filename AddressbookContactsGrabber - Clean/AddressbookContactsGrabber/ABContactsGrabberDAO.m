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
                                                                            selector:@selector(grabContactsWithAPhoneNumber)
                                                                              object:nil];
    [queue addOperation:operation];
}

- (void) grabContactsWithAPhoneNumber {
    
    NSMutableArray *resultsArray = [[NSMutableArray alloc]init];
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    for (id record in allContacts){
        ABRecordRef thisContact = (__bridge ABRecordRef)record;
        ABMultiValueRef mvr = ABRecordCopyValue(thisContact, kABPersonPhoneProperty);
        NSString *personFullName = (__bridge NSString *) ABRecordCopyCompositeName(thisContact);

        //check for phone number existence - if the record does have a phone number, push to our array
        if (ABMultiValueGetCount(mvr) != 0) {
            [resultsArray addObject:[self createContactObjectBasedOnAddressBookRecord:thisContact]];
        }
        else {
            NSLog(@"found a contact without any phone number at %@", personFullName);
        }
    }
    
    self.filteredContactsArrayWhoHavePhoneNumbers = resultsArray;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    self.lastContactsSyncTime = [dateFormatter stringFromDate:[NSDate date]];
    
    
    [self.delegate DAOdidFinishFilteringContactsForPhoneNumbers];
}


- (Contact *) createContactObjectBasedOnAddressBookRecord: (ABRecordRef) myABRecordRef {
    Contact *myContactObject = [[Contact alloc]init];
    myContactObject.firstName = (__bridge NSString *)(ABRecordCopyValue(myABRecordRef, kABPersonFirstNameProperty));
    myContactObject.lastName = (__bridge NSString *)(ABRecordCopyValue(myABRecordRef, kABPersonLastNameProperty));
    ABMultiValueRef mvr = ABRecordCopyValue(myABRecordRef, kABPersonPhoneProperty);
    myContactObject.mobileNumber =  (__bridge NSString *)(ABMultiValueCopyValueAtIndex(mvr, 0));
    
    return myContactObject;
}



#pragma mark Checking for new contacts on post-initial run








#pragma mark Adding to Addressbook - Just for testing
- (void) checkForAuthorizationAndAdd: (NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *) phoneNumber {
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //1
        NSLog(@"you must allow app permissions");
        [self.delegate authorizationProblemHappened];
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
        [self addNewPersonInAddressBook: firstName lastName:lastName phoneNumber:phoneNumber];
        
    } else { //case of ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        //3
        NSLog(@"Not determined");
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            if (!granted){
                //4
                NSLog(@"you must allow app permissions");
                [self.delegate authorizationProblemHappened];
                return;
            }
            //5
            NSLog(@"Authorized");
            [self addNewPersonInAddressBook: firstName lastName:lastName phoneNumber:phoneNumber];
        });
    }
}

- (void) addNewPersonInAddressBook: (NSString *)firstName lastName:(NSString *)lastName phoneNumber:(NSString *) phoneNumber{
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
    NSString* guyFirstName = firstName;
    NSString* guyLastName = lastName;
    NSString* guyPhoneNumber = phoneNumber;
    ABRecordRef guy = ABPersonCreate();
    ABRecordSetValue(guy, kABPersonFirstNameProperty, (__bridge CFStringRef)guyFirstName, nil);
    ABRecordSetValue(guy, kABPersonLastNameProperty, (__bridge CFStringRef)guyLastName, nil);
    ABMutableMultiValueRef phoneNumbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phoneNumbers, (__bridge CFStringRef)guyPhoneNumber, kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(guy, kABPersonPhoneProperty, phoneNumbers, nil);
    
    ABAddressBookAddRecord(addressBookRef, guy, nil);
    ABAddressBookSave(addressBookRef, nil);
    [self.delegate DAOdidFinishAddingContact];
    
    
    //Just to log out results
//    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
//    for (id record in allContacts){
//        ABRecordRef thisContact = (__bridge ABRecordRef)record;
//        NSLog(@"%@", ABRecordCopyCompositeName(thisContact));
//    }
    
}




@end
