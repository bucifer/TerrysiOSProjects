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




@end
