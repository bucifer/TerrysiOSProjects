//
//  main.m
//  identityEqualityPractice
//
//  Created by Aditya Narayan on 12/3/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        NSString *a = @"hi";
        NSString *b = a;
        
        if (a == b) {
            NSLog(@"a and b are equal in IDENTITY = identical pointers");
        }
        
        
        NSString *c = @"hello";
        NSString *d = @"hello";
        
        if ([c isEqual:d]) {
            NSLog(@"equal");
        }
        else {
            NSLog(@"not equal");
        }
        
    }
    return 0;
}
