//
//  main.m
//  Exercise II Arrays_Dictionaries Objective C
//
//  Created by Aditya Narayan on 9/5/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        //array practice
        //don't forget the 골뱅이 for infront of [] --> @[]
        //NSArray method: count --> to find its count
        
        //NSArrays are immutable, you can't add stuff to it
        
        //Below is how you initiate a NSMutable Array where you can change its size afterwards
        //Note the nil at the end of this array ... C does this too.
        //All arrays actually have invisible nil at the end, but for NSMutable array you have to declare it like this
        //If you ever get sentinel errors, it's talking about that nil at the end
        
        NSMutableArray *companies = [[NSMutableArray alloc] initWithObjects:@"Apple", @"Google", @"Microsoft", nil];
        for (int i = 0; i < [companies count]; i++) {
            NSLog(@"%@", companies[i]);
        }
        
        //Now this is how you add something to the NSMutable array, it gets added to the last index
        [companies addObject:@"Facebook"];
        NSLog(@"%@", companies[3]);
        NSLog(@"%lu", [companies count]);
        
        //create a NSDictionary object with the following key-value pairs
        NSDictionary *company_dict = @{@"AAPL": @"Apple", @"GOOG": @"Google", @"MSFT": @"Microsoft"};
        
        
        NSLog(@"%@", company_dict[@"AAPL"]);//this is how you access the value by calling the Key of the Dictionary
        for (id key in company_dict) {
            NSLog(@"key is %@ and value is %@", key, [company_dict objectForKey:key]);
        } //this is how you loop through a NSDictionary and print out the contents key-value
        
        NSLog(@"%@", company_dict[@"MSFT"]);//this is how you access the value by calling the Key of the Dictionary
        
        
        //Adding another key-value pair to NSDictionary requires that you change it to NSMutableDictionary
        //Mutablecopy makes a copy of our NSDictionary and makes a mutablecopy of it
        NSMutableDictionary *mutableCompanyDict = company_dict.mutableCopy;
        
        [mutableCompanyDict setValue:@"Facebook" forKey:@"FB"];
        //Now you add another key-value pair like above;
        
        //check to see facebook key-value was added
        NSLog(@"%@", mutableCompanyDict[@"FB"]);
        
        //Now Remove the element with key=AAPL from the dictionary
        [mutableCompanyDict removeObjectForKey:@"AAPL"];
        
        //check to see it was indeed deleted #10
        NSLog(@"%@", [mutableCompanyDict description]);
        //description is a nifty objective-c method that applies to a lot of data types that will give you useful output
        
        //#11 print # of elements in the dictionary now
        NSLog(@"%lu", [mutableCompanyDict count]);
        //returns 3, correct
        
        //#13-15
        Company *company1 = [[Company alloc] init];
        company1.stockPrice = @1000;
        company1.companyName = @"Google";
        company1.companyLogoName = @"google.png";
        NSLog(@"%@, %@, %@ -done", company1.stockPrice, company1.companyName, company1.companyLogoName);
        
        //#17 add following products to the company array - AdWords, AdSense, GoogleDocs
        company1.products = [[NSMutableArray alloc] initWithObjects:@"AdWords", @"AdSense", @"GoogleDocs", nil];
        //#18 print out the products
        NSLog(@"%@", company1.products.description);
        
        //#19 remove GoogleDocs from the array above;
        [company1.products removeObjectAtIndex:2];
        //#20 print out rest of the products
        for (int i =0; i < company1.products.count; i++) {
            NSLog(@"%@", company1.products[i]);
        }
        
        //#22 create two instances of the Product class
        Product *product1 = [[Product alloc]init];
        Product *product2 = [[Product alloc]init];
        product1.productName = @"GoogleGlass";
        product1.productLogo = @"glass.png";
        product1.productURL = @"http://googleglass.com";
        product2.productName = @"Android";
        product2.productLogo = @"android.png";
        product2.productURL = @"http://android.com";
        //#24 add these two Product objects to the Company1's products array
        [company1.products addObject:product1];
        [company1.products addObject:product2];
        //#just to check, print out the products
        NSLog(@"%@", [company1.products description]);
        
        //#25 last question - print out all product details of those recently added Product objects
        NSString *pname1 = [company1.products[2] productName];
        NSString *plogo1 = [company1.products[2] productLogo];
        NSString *purl1 = [company1.products[2] productURL];

        //Accessing that property is tricky. You can't do company1.products[2].productName because it's not the right syntax and Objective-C will throw errors. Instead, you do it like above, setting it inside a method like this
        
        NSString *pname2 = [company1.products[3] productName];
        NSString *plogo2 = [company1.products[3] productLogo];
        NSString *purl2 = [company1.products[3] productURL];
        
        NSLog(@"%@ %@ %@", pname1, plogo1, purl1);
        NSLog(@"%@ %@ %@", pname2, plogo2, purl2);

    }
    return 0;
}

