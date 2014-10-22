//
//  main.m
//  Elementary Objective C
//
//  Created by Aditya Narayan on 9/5/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>

int add_three(int a, int b, int c);
float divide_two(float a, float b);
void print_big(int x);
void print_one_to_thousand();
void print_3to99();
long sum_1to1000();

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // write a program that prints your name
        
        NSString *name = @"Terry Bu";
        NSLog(@"Hello, %@!", name);
        
        // write a program that prints the sum of three numbers, declare them as ints
        int a = 1;
        int b = 2;
        int c = 3;
        NSLog(@"sum of a b c is : %d", add_three(a, b, c));
        
        // write a program that divides two numbers, declare them as floats
        float d = 200.50;
        float e = 4.0;
        NSLog(@"sum of division is: %f", divide_two(d, e));
        
        print_big(10001); //NSLogs "BIG" to the console
        
        print_one_to_thousand();
        print_3to99();
        NSLog(@"result of sum of 1 to 1000 is %ld", sum_1to1000());
        
        //create an array of NSString and print each element
        NSArray *food = @[@"sushi", @"sashimi", @"nikujaga"];
        NSLog(@"%@", [food componentsJoinedByString:@", "]);
        
    }
    return 0;
}


int add_three(int a, int b, int c) {
    int sum = a + b + c;
    return sum;
}

float divide_two(float a, float b) {
    float sum = a/b;
    return sum;
}

void print_big(int x) {
    BOOL bigger = NO;
    bigger = x > 10000;
    if (bigger) NSLog(@"BIG");
    else NSLog(@"SMALL");
}

void print_one_to_thousand() {
    for (int i = 1; i <= 1000; i++) {
        NSLog(@"%d", i);
    }
}

void print_3to99() {
    for (int i = 3; i <= 99; i++) {
        NSLog(@"%d", i);
    }
}

long sum_1to1000() {
    long sum = 0;
    for (int i=1; i <= 1000; i++) {
        sum += i;
    }
    return sum;
}
