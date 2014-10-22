//
//  main.m
//  RecursionPracticeTerry
//
//  Created by Aditya Narayan on 10/7/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        NSLog(@"%d",factorial(5));
        NSLog(@"%d",sumofN(10));
    }
    return 0;
}


int factorial(int n) {
    //f(5) = 5 * 4 * 3 * 2 * 1
    //f(n) = n * n-1 * n-2 * n-3 ... until you hit n = 1
    //end condition is n = 1
    if (n == 1) return 1;
    return factorial(n-1) * n;
}


int sumofN(int n) {
    //sum(10) = 10 + 9 + 8 + 7 + 6 + 5 + 4 + 3 + 2 + 1
    //sum(n) = n + n-1 + n-2 + n-3 .... until n reaches 1
    if (n==1) return 1;
    return sumofN(n-1) + n;
}