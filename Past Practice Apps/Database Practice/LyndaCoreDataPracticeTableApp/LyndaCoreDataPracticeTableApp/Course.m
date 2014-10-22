//
//  Course.m
//  LyndaCoreDataPracticeTableApp
//
//  Created by Aditya Narayan on 10/16/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "Course.h"


@implementation Course

@dynamic author;
@dynamic releaseDate;
@dynamic title;


//this allows you to set the default value for something in the model as soon as it gets initiated
//instead of using the Defautl Value option in the model file, you cn do this in code, to allow for "dynamic" values
- (void) awakeFromInsert {
    [super awakeFromInsert];
    self.releaseDate = [NSDate date];
    
}

@end
