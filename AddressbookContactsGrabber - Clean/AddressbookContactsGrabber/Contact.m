//
//  Contact.m
//  AddressbookContactsGrabber
//
//  Created by Aditya Narayan on 10/23/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "Contact.h"

@implementation Contact







- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.mobileNumber forKey:@"mobileNumber"];
    [encoder encodeBool:self.inviteAlreadySentFlag forKey:@"inviteSentFlag"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [[Contact alloc] init];
    if (self != nil)
    {
        self.firstName = [coder decodeObjectForKey:@"firstName"];
        self.lastName = [coder decodeObjectForKey:@"lastName"];
        self.mobileNumber = [coder decodeObjectForKey:@"mobileNumber"];
        self.inviteAlreadySentFlag = [coder decodeObjectForKey:@"inviteSentFlag"];
    }
    return self;
}

@end
