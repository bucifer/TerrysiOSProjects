//
//  main.m
//  practice
//
//  Created by Aditya Narayan on 9/10/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSMutableArray *terrysArray = [NSMutableArray array];
        
        [terrysArray addObject: @"hello"];
        [terrysArray addObject: @"yomega"];
        [terrysArray removeObjectAtIndex:1];
        
        NSLog(terrysArray.description);
        
    }
    return 0;
}

