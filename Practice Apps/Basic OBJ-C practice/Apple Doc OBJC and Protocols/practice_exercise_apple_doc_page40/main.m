//
//  main.m
//  practice_exercise_apple_doc_page40
//
//  Created by Aditya Narayan on 9/10/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "ShoutingPerson.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Person *person = [[Person alloc]init];
        [person sayHello];
        [person sayGoodbye];
        [person sayKorean];
        
        ShoutingPerson *shoutingPerson = [ShoutingPerson new];
        [shoutingPerson saySomething: @"i like da cheese"];
        
        id shouting_pointer;
        if (shouting_pointer == nil) {
            NSLog(@"shouting pointer is nil");
        }
        
        [shoutingPerson yell];
        [shoutingPerson goNaked];
        [shoutingPerson punchPeople];
        
    }
    return 0;
}

