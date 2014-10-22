//
//  main.m
//  PracticePassByReference
//
//  Created by Aditya Narayan on 10/10/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dummyCalculator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        dummyCalculator *dummy = [[dummyCalculator alloc]init];
        
        NSInteger *myInteger = 5;
        NSString *myString = @"not changed hi";
        NSInteger anotherInteger = 10;
        
        [dummy incrementTwo:myInteger];
        [dummy changeThisString:myString];
        [dummy incrementInteger:anotherInteger];
        
        //all these functions don't change the values of the variables passed as parameters, although I specifically told them to in the function
        //that means objective-c is PASS BY VALUE or PASS BY COPY
        
        //In the primitive case, it's easy to understand because you are never touching the actual value. You are making the copy as soon as it's passed. Any changes, you are making only to the copy
        
        //In the pointer case, you are creating a copy of the pointer. You are still not changing the original object.
        
        //the reason that NSJSONSerialization uses &error with the *error pointer is now clear
        //you cannot change *error if you just pass the pointer, becasue same thing will happen as above. Your function will create a copy of the pointer, fill it with an error object, but when the function ends, the local scope is lost/the local *error pointer is lost. the *error you pass to the function is not the same as the one you declared before the function.
        
        
        NSLog(@"%d", myInteger);
        NSLog(@"%@", myString);
        NSLog(@"%ld", (long)anotherInteger);

        
    }
    return 0;
}
