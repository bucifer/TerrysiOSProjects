//
//  myCustomCardButton.m
//  StanfordCardFlipProject
//
//  Created by Aditya Narayan on 10/17/14.
//  Copyright (c) 2014 TerrysCompany. All rights reserved.
//

#import "myCustomCardButton.h"

@implementation myCustomCardButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    if((self=[super init])){
        self.cardIsShowingBack = FALSE;
    }
    return self;
}

@end
