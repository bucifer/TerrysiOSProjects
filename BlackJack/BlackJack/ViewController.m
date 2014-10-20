//
//  ViewController.m
//  BlackJack
//
//  Created by Aditya Narayan on 10/17/14.
//  Copyright (c) 2014 TerrysCompany. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playButton.layer.cornerRadius = 10;
    self.hitButton.layer.cornerRadius = 10;

    self.hitButton.hidden = YES;
    self.stayButton.hidden = YES;
    self.playAgainButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)playGameButtonPressAction:(id)sender {
    
    self.playButton.hidden = YES;
    self.hitButton.hidden = NO;
    self.stayButton.hidden = NO;
    
    //For one-deck-play-no-duplicates checking
    NSMutableArray *myIntegers = [[NSMutableArray array]init];
    for (NSInteger i = 1; i <= 52; i++) {
        [myIntegers addObject:[NSNumber numberWithInteger:i]];
    }
    self.availableCardsInDeck= myIntegers;
    
    //Dealer Calculations
    [self setImageAndCardValue:self.dealerCardOne];
    [self setImageAndCardValue:self.dealerCardTwo];
    self.dealerScore = self.dealerCardOne.cardValue + self.dealerCardTwo.cardValue;
    self.dealerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.dealerScore];
    
    //Player Calculations
    [self setImageAndCardValue:self.playerCardOne];
    [self setImageAndCardValue:self.playerCardTwo];
    self.playerScore = self.playerCardOne.cardValue + self.playerCardTwo.cardValue;
    self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.playerScore];
    
    [self startTheGame];
    

}

- (void) startTheGame {
    
    if (self.playerScore == 21) {
        NSLog(@"BLACKJACK!");
    }
    else if (self.playerScore < 21) {
        NSLog(@"you can hit if you want to");
    }
    
    if (self.dealerScore < 17) {
        NSLog(@"Dealer has to hit because his score < 17");
    }
    
}



- (IBAction)hitButtonPressedAction:(id)sender {
    [self setImageAndCardValue:self.optionalPlayerCardThree];
    self.playerScore += self.optionalPlayerCardThree.cardValue;
    self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.dealerScore];
    
    if (self.playerScore == 21) {
        NSLog(@"BLACKJACK!");
    }
    else if (self.playerScore > 21) {
        NSLog(@"BUST YOU LOSE");
        self.playerScoreLabel.text = @"BUST";
        self.playAgainButton.hidden = NO;
        [self hidePlayerActionButtons];
    }
    else {
        self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.playerScore];
    }
}

- (void) hidePlayerActionButtons {
    self.hitButton.hidden = YES;
    self.stayButton.hidden = YES;
    
}


- (IBAction)stayButtonPressedAction:(id)sender {

    //dealer doesn't get to hit
    if (self.dealerScore >= 17) {
        
        //we run results logic
        [self runGameResultsCalculation];
        
    }
    else {
        NSLog(@"Dealer has to hit");
        [self setImageAndCardValue:self.optionalDealercardThree];
        self.dealerScore = self.dealerCardOne.cardValue + self.dealerCardTwo.cardValue + self.optionalDealercardThree.cardValue;
        self.dealerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.dealerScore];
        [self runGameResultsCalculation];
    }
    
}

- (void) runGameResultsCalculation {
    
    if (self.dealerScore > 21)
        NSLog(@"DEALER BUST - Player WINS!");
    else if (self.dealerScore <= 21 && self.dealerScore == self.playerScore)
        NSLog(@"PUSH");
    else if (self.dealerScore > self.playerScore)
        NSLog(@"Player loses!");
    else {
        NSLog(@"Player Wins!");
    }
    
}


- (IBAction)playAgainButton:(id)sender {
    
    self.playButton.hidden = NO;
    
    self.playerScoreLabel.text = nil;
    self.dealerScoreLabel.text = nil;
    
    [self.playerCardOne setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    [self.playerCardTwo setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    [self.optionalPlayerCardThree setBackgroundImage:nil forState:UIControlStateNormal];

    [self.dealerCardOne setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    [self.dealerCardTwo setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    
    self.playAgainButton.hidden = YES;
}




- (IBAction)dealerCardOnePressed:(id)sender {
    CustomCardButton *myCard = (CustomCardButton *) sender;
    NSLog(@"card points value: %ld", (long) myCard.cardValue);
    NSLog(@"card raw name value: %ld", (long) myCard.rawCardName);
}

- (IBAction)dealerCardTwoPressed:(id)sender {
    CustomCardButton *myCard = (CustomCardButton *) sender;
    NSLog(@"card points value: %ld", (long) myCard.cardValue);
    NSLog(@"card raw name value: %ld", (long) myCard.rawCardName);
}

- (IBAction)dealerCardThreePressed:(id)sender {
    CustomCardButton *myCard = (CustomCardButton *) sender;
    NSLog(@"card points value: %ld", (long) myCard.cardValue);
    NSLog(@"card raw name value: %ld", (long) myCard.rawCardName);
}

- (IBAction)dealerCardFourPressed:(id)sender {
    CustomCardButton *myCard = (CustomCardButton *) sender;
    NSLog(@"card points value: %ld", (long) myCard.cardValue);
    NSLog(@"card raw name value: %ld", (long) myCard.rawCardName);
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





@end
