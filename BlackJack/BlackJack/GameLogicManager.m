//
//  GameLogicManager.m
//  BlackJack
//
//  Created by Aditya Narayan on 10/20/14.
//  Copyright (c) 2014 TerrysCompany. All rights reserved.
//

#import "GameLogicManager.h"

@implementation GameLogicManager




- (id) init {
    if ( self = [super init] ) {
        //For one-deck-play-no-duplicates checking
        NSMutableArray *myIntegers = [[NSMutableArray array]init];
        for (NSInteger i = 1; i <= 52; i++) {
            [myIntegers addObject:[NSNumber numberWithInteger:i]];
        }
        self.availableCardsInDeck= myIntegers;
    }
    return self;
}

- (void) checkForPlayerBlackJackElsePlay {
    if (self.playerScore == 21) {
        NSLog(@"BLACKJACK! YOU WIN!!");
        [self.myViewController postPlayerWinScene];
        self.myViewController.resultsAnnounceLabel.text = @"BLACKJACK!";
    }
    else if (self.playerScore < 21) {
        NSLog(@"you can hit if you want to");
    }
}



- (void) runGameResultsCalculation {
    
    if (self.dealerScore == self.playerScore) {
        NSLog(@"PUSH");
        [self.myViewController postTieResultScene];
    }
    else if (self.dealerScore > 21) {
        NSLog(@"DEALER BUST - Player WINS!");
        [self.myViewController postPlayerWinScene];
    }
    else if (self.dealerScore > self.playerScore) {
        NSLog(@"Player loses!");
        [self.myViewController postPlayerLoseScene];
    }
    else {
        NSLog(@"Player Wins!");
        [self.myViewController postPlayerWinScene];
    }
}

- (NSString *) randomCardNumberStringGeneratorUnique {
    NSLog(@"Available cards count: %lu",    (unsigned long)self.availableCardsInDeck.count);
    int r = arc4random_uniform(self.availableCardsInDeck.count-1) + 1;
    NSLog(@"%d", r);
    
    if ([self.availableCardsInDeck containsObject:@(r)]) {
        NSLog(@"Deck still contains number %d", r);
        int temp = r;
        
        //we remove it from our deck first
        [self.availableCardsInDeck removeObject:@(r)];
        
        //we return the temp, since r is not in the deck anymore
        return [NSString stringWithFormat:@"%d", temp];
    }
    else {
        NSLog(@"Deck can't find number %d because it was used already!!", r);
        NSLog(@"Looking for new Number ...");
        return [self randomCardNumberStringGeneratorUnique];
    }
    
    return nil;
}


- (void) setImageAndCardValue: (CustomCardButton *) yourCardButton{
    
    NSString *myCardNumberString = [self randomCardNumberStringGeneratorUnique];
    NSInteger rawCardNameValue = [myCardNumberString integerValue];
    NSInteger myCardValue;
    
    if (rawCardNameValue <= 20 && rawCardNameValue >= 5) {
        myCardValue = 10;
    }
    else if (rawCardNameValue >= 1 && rawCardNameValue <= 4)
        myCardValue = 11;
    else {
        //1 - 4 are all Aces (1 or 11)
        //5 to 20 are K, Q, J and Ts.
        //21,22,23,24 are all 9s
        //25,26,27,28 are all 8s
        //29 - 32 are all 7s
        //33 - 36 are all 6s
        //37 - 40 are all 5s
        //41 - 44 are all 4s
        //45 - 48 are all 3s
        //49 - 52 are all 2s
        
        
        int n = 9;
        NSInteger j = 21;
        while (n > 0) {
            for (NSInteger i = j; i <= j+3; i++) {
                if (rawCardNameValue == i) {
                    myCardValue = n;
                    break;
                }
            }
            j = j + 4;
            n = n - 1;
        }
    }
    [yourCardButton setBackgroundImage:[UIImage imageNamed:myCardNumberString] forState:UIControlStateNormal  ];
    yourCardButton.cardValue = myCardValue;
    yourCardButton.rawCardName = rawCardNameValue;
}


- (void) recalculatePlayerScore {
    if (self.myViewController.optionalPlayerCardThree != 0 && self.myViewController.optionalPlayerCardFour == 0) {
        self.playerScore = self.myViewController.playerCardOne.cardValue + self.myViewController.playerCardTwo.cardValue + self.myViewController.optionalPlayerCardThree.cardValue;
    }
    else {
        self.playerScore = self.myViewController.playerCardOne.cardValue + self.myViewController.playerCardTwo.cardValue + self.myViewController.optionalPlayerCardThree.cardValue + self.myViewController.optionalPlayerCardFour.cardValue;
    }
}

- (void) aceCheckerFirstCardtoThirdCard {
    if (self.playerScore > 21) {
        //if the playerscore is a bust, BUT there is an Ace in one of these 3 cards, it counts as a 1 instead of 11
        //and the playerscore gets calculated to reflect that
        
        //loop through all the cards and check which one is an ace, and turn its cardvalue to 1
        if (self.myViewController.playerCardOne.cardValue == 11 || self.myViewController.playerCardTwo.cardValue == 11 || self.myViewController.optionalPlayerCardThree.cardValue == 11) {
            NSArray *myCardsArray = @[self.myViewController.playerCardOne, self.myViewController.playerCardTwo, self.myViewController.optionalPlayerCardThree];
            for (int i = 0; i < myCardsArray.count; i++) {
                CustomCardButton *mySelectedCard = myCardsArray[i];
                if (mySelectedCard.cardValue == 11) {
                    mySelectedCard.cardValue = 1;
                    NSLog(@"Found an ace at a > 21 situation so lowered it down to 1 instead of 11!");
                }
            }
            [self recalculatePlayerScore];
        }
    }
}

- (void) aceCheckerFourthCard {
    if (self.playerScore > 21) {
        //if the playerscore is a bust, BUT there is an Ace in one of these 3 cards, it counts as a 1 instead of 11
        //and the playerscore gets calculated to reflect that
        
        //loop through all the cards and check which one is an ace, and turn its cardvalue to 1
        if (self.myViewController.optionalPlayerCardFour.cardValue == 11) {
            self.myViewController.optionalPlayerCardFour.cardValue = 1;
            [self recalculatePlayerScore];
        }
    }
}


@end
