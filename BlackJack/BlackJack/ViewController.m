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
    
    [self.dealerCardOne setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    self.dealerScoreLabel.hidden = YES;
}

- (void) startTheGame {
    if (self.playerScore == 21) {
        NSLog(@"BLACKJACK! YOU WIN!!");
        [self postPlayerWinScene];
        self.resultsAnnounceLabel.text = @"BLACKJACK!";
    }
    else if (self.playerScore < 21) {
        NSLog(@"you can hit if you want to");
    }
    
}



- (IBAction)hitButtonPressedAction:(id)sender {
    
    if (self.optionalPlayerCardThree.cardValue == 0) {
        [self setImageAndCardValue:self.optionalPlayerCardThree];
        self.playerScore += self.optionalPlayerCardThree.cardValue;
        self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.playerScore];
        [self runPostHitButtonPlayerCalculations];
    }
    
    else {
        [self setImageAndCardValue:self.optionalPlayerCardFour];
        self.playerScore += self.optionalPlayerCardFour.cardValue;
        self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.playerScore];
        [self runPostHitButtonPlayerCalculations];

    }
    
}

- (void) runPostHitButtonPlayerCalculations {
    if (self.playerScore == 21) {
        NSLog(@"BLACKJACK!");
        [self postPlayerWinScene];
        self.resultsAnnounceLabel.text = @"BLACKJACK!";
    }
    else if (self.playerScore > 21) {
        NSLog(@"BUST YOU LOSE");
        self.playerScoreLabel.text = @"BUST";
        self.playerScoreLabel.textColor = [UIColor orangeColor];
        [self postPlayerLoseScene];
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

    self.dealerScoreLabel.hidden = NO;
    [self.dealerCardOne setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld", self.dealerCardOne.rawCardName]] forState:UIControlStateNormal];
    
    //dealer doesn't get to hit
    if (self.dealerScore >= 17) {
        //we run results logic
        [self runGameResultsCalculation];
    }
    else {
        NSLog(@"Dealer has to hit");
        double delayInSeconds = 0.75;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // code to be executed on the main queue after delay
            [self setImageAndCardValue:self.optionalDealerCardThree];
            self.dealerScore = self.dealerCardOne.cardValue + self.dealerCardTwo.cardValue + self.optionalDealerCardThree.cardValue;

            if (self.dealerScore > 21) {
                self.dealerScoreLabel.text = @"BUST";
                self.dealerScoreLabel.textColor = [UIColor orangeColor];
                [self runGameResultsCalculation];
            }
            else {
                self.dealerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.dealerScore];
                //if dealer score is less than 17, we need fourth card logic
                if (self.dealerScore < 17) {
                    //we ask for 4th card
                    [self setImageAndCardValue:self.optionalDealerCardFour];
                    self.dealerScore = self.dealerCardOne.cardValue + self.dealerCardTwo.cardValue + self.optionalDealerCardThree.cardValue + self.optionalDealerCardFour.cardValue;
                    if (self.dealerScore <= 21) {
                        self.dealerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.dealerScore];
                    }
                    else {
                        self.dealerScoreLabel.text = @"BUST";
                        self.dealerScoreLabel.textColor = [UIColor orangeColor];
                    }
                }
                [self runGameResultsCalculation];
            }
        });
    }
}
                       
                       
- (void) runGameResultsCalculation {
    
    if (self.dealerScore == self.playerScore) {
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

- (void) postTieResultScene {
    [self hidePlayerActionButtons];
    self.playAgainButton.hidden = NO;
    self.resultsAnnounceLabel.text = @"PUSH";
    self.resultsAnnounceLabel.textColor = [UIColor whiteColor];
}

- (void) postPlayerWinScene {
    [self hidePlayerActionButtons];
    self.playAgainButton.hidden = NO;
    self.resultsAnnounceLabel.text = @"YOU WIN!";
    self.resultsAnnounceLabel.textColor = [UIColor greenColor];
}

- (void) postPlayerLoseScene {
    [self hidePlayerActionButtons];
    self.playAgainButton.hidden = NO;
    self.resultsAnnounceLabel.text = @"YOU LOSE";
    self.resultsAnnounceLabel.textColor = [UIColor redColor];
}


- (IBAction)playAgainButton:(id)sender {
    
    self.playButton.hidden = NO;
    
    self.playerScoreLabel.text = nil;
    self.dealerScoreLabel.text = nil;
    
    [self.playerCardOne setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    self.playerCardOne.cardValue = 0;
    
    [self.playerCardTwo setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    self.playerCardTwo.cardValue = 0;

    [self.optionalPlayerCardThree setBackgroundImage:nil forState:UIControlStateNormal];
    self.optionalPlayerCardThree.cardValue = nil;
    [self.optionalPlayerCardFour setBackgroundImage:nil forState:UIControlStateNormal];
    self.optionalPlayerCardFour.cardValue = nil;

    
    [self.dealerCardOne setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    self.dealerCardOne.cardValue = 0;

    [self.dealerCardTwo setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    self.dealerCardTwo.cardValue = 0;

    [self.optionalDealerCardThree setBackgroundImage:nil forState:UIControlStateNormal];
    [self.optionalDealerCardFour setBackgroundImage:nil forState:UIControlStateNormal];

    
    
    self.playAgainButton.hidden = YES;
    self.resultsAnnounceLabel.text = nil;
    
    //colors reset
    self.playerScoreLabel.textColor = [UIColor whiteColor];
    self.dealerScoreLabel.textColor = [UIColor whiteColor];

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
