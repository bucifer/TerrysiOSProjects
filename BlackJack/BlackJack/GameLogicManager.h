//
//  GameLogicManager.h
//  BlackJack
//
//  Created by Aditya Narayan on 10/20/14.
//  Copyright (c) 2014 TerrysCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@class ViewController;
@interface GameLogicManager : NSObject

@property (strong, nonatomic) ViewController* myViewController;
@property (strong, nonatomic) NSMutableArray* availableCardsInDeck;

@property (nonatomic) NSInteger playerScore;
@property (nonatomic) NSInteger dealerScore;



- (void) checkForPlayerBlackJackElsePlay;
- (void) runGameResultsCalculation;
- (void) recalculatePlayerScore;
- (void) runThisIfPlayerHappensToHaveAnAce;


- (NSString *) randomCardNumberStringGeneratorUnique;
- (void) setImageAndCardValue: (CustomCardButton *) yourCardButton;



@end
