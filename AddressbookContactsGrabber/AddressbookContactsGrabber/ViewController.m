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
    [self checkForAuthorizationAB];

    [self addNewPersonInAddressBook: @"NoP" lastName:@"honeNumber" phoneNumber:nil];
    
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
    UIAlertView *contactAddedAlert = [[UIAlertView alloc]initWithTitle:@"Contact Added" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [contactAddedAlert show];
    
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    for (id record in allContacts){
        ABRecordRef thisContact = (__bridge ABRecordRef)record;
        NSLog(@"%@", ABRecordCopyCompositeName(thisContact));
    }
}

- (void) checkForAuthorizationAB {
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //1
        UIAlertView *cantAlert = [[UIAlertView alloc] initWithTitle: @"Cannot use AB" message: @"You must give the app permission to use contacts first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [cantAlert show];
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
        
    } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        //3
        NSLog(@"Not determined");
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            if (!granted){
                //4
                UIAlertView *cantAlert = [[UIAlertView alloc] initWithTitle: @"Cannot use AB" message: @"You must give the app permission to use contacts first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                [cantAlert show];
                return;
            }
            //5
            NSLog(@"Authorized");
        });
    }

}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
