//
//  GameLogicManager.h
//  BlackJack
//
//  Created by Aditya Narayan on 10/20/14.
//  Copyright (c) 2014 TerrysCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface GameLogicManager : NSObject

@property (strong, nonatomic) ViewController* myViewController;


- (void) runGameResultsCalculation;


@end
