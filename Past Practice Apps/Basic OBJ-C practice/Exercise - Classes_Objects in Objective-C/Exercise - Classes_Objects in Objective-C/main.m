//
//  main.m
//  Exercise - Classes_Objects in Objective-C
//
//  Created by Aditya Narayan on 9/5/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Car.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Person *person1 = [[Person alloc] init];
        person1.firstName = @"Jim";
        person1.lastName = @"Smith";
        person1.city = @"New York";
        
        Person *person2 = [[Person alloc] init];
        person2.firstName = @"Mason";
        person2.lastName = @"King";
        person2.city = @"LA";
        
        NSLog(@"%@", person1.city);
        NSLog(@"%@", person2.city);
        
        Car *car1 = [[Car alloc] init];
        car1.company = @"Tesla";
        car1.model = @"Model S";
        car1.year = @2013;
        
        Car *car2 = [[Car alloc] init];
        car2.company = @"Nissan";
        car2.model = @"Leaf";
        car2.year = @2012;
        
        car1.currentOwner = person1;
        car2.currentOwner = person2;
        
        //print company, model, year, owner names for both cars
        NSLog(@"company: %@, model: %@, year :%@, ownername: %@ %@", car1.company, car1.model, car1.year, car1.currentOwner.firstName, car1.currentOwner.lastName);
        NSLog(@"company: %@, model: %@, year :%@, ownername: %@ %@", car2.company, car2.model, car2.year, car2.currentOwner.firstName, car2.currentOwner.lastName);
        
        //A new guy comes and owns the Nissan
        Person *person3 = [[Person alloc] init];
        person3.firstName = @"John";
        person3.lastName = @"H";
        car2.currentOwner = person3;
        
        //A new guy comes and owns the Tesla
        Person *person4 = [[Person alloc]init];
        person4.firstName = @"James";
        person4.lastName = @"M";
        car1.currentOwner = person4;
        
        //print company, model, year, owner names for both cars
        NSLog(@"company: %@, model: %@, year :%@, ownername: %@ %@", car1.company, car1.model, car1.year, car1.currentOwner.firstName, car1.currentOwner.lastName);
        NSLog(@"company: %@, model: %@, year :%@, ownername: %@ %@", car2.company, car2.model, car2.year, car2.currentOwner.firstName, car2.currentOwner.lastName);
    }
    return 0;
}

