//
//  ShoutingPerson.h
//  practice_exercise_apple_doc_page40
//
//  Created by Aditya Narayan on 9/10/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "crazy.h"

@interface ShoutingPerson : Person <crazy>

- (void) saySomething: (NSString*) whatToSay;

@end
