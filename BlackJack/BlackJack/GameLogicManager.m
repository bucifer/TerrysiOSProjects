//
//  GameLogicManager.m
//  BlackJack
//
//  Created by Aditya Narayan on 10/20/14.
//  Copyright (c) 2014 TerrysCompany. All rights reserved.
//

#import "GameLogicManager.h"

@implementation GameLogicManager


- (void) runGameResultsCalculation {
    
    if (self.myViewController.dealerScore == self.myViewController.playerScore) {
        NSLog(@"PUSH");
        [self postTieResultScene];
    }
    else if (self.dealerScore > 21) {
        NSLog(@"DEALER BUST - Player WINS!");
        [self postPlayerWinScene];
    }
    else if (self.dealerScore > self.playerScore) {
        NSLog(@"Player loses!");
        [self postPlayerLoseScene];
    }
    else {
        NSLog(@"Player Wins!");
        [self postPlayerWinScene];
    }
    
    
}


@end
