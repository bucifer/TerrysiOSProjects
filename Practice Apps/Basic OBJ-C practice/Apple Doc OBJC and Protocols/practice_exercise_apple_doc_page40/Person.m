//
//  Person.m
//  practice_exercise_apple_doc_page40
//
//  Created by Aditya Narayan on 9/10/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "Person.h"

@implementation Person


- (void) saySomething: (NSString *) greeting {
    NSLog(@"%@", greeting);
}

- (void) sayHello {
    [self saySomething:@"Hello, world!"];
}

- (void) sayGoodbye {
    [self saySomething:@"Bye, world!"];
}

- (void) sayKorean {
    [self saySomething:@"안녕하세요!"];
}


@end
