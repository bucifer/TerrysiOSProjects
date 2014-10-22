//
//  ShoutingPerson.m
//  practice_exercise_apple_doc_page40
//
//  Created by Aditya Narayan on 9/10/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ShoutingPerson.h"

@implementation ShoutingPerson

- (void) saySomething:(NSString *)whatToSay {
    NSString *uppercasewhatToSay  = [whatToSay uppercaseString];
    [super saySomething:uppercasewhatToSay];
}

- (void) yell {
    [super saySomething: @"AHHHHHH"];
}

- (void) punchPeople {
    NSLog(@"PUNCH PUNCH");
}

- (void) goNaked {
    NSLog(@"I'm Naked");
}

@end
