//
//  dummyCalculator.m
//  PracticePassByReference
//
//  Created by Aditya Narayan on 10/10/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "dummyCalculator.h"

@implementation dummyCalculator


- (void) incrementTwo:(NSInteger *)myNumber {
    myNumber = myNumber + 2;
}


- (void) changeThisString:(NSString *)myString {
    myString = @"hi changed";
}


- (void) incrementInteger:(NSInteger)myInteger {
    myInteger = myInteger + 15;
}



@end
