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
    
    self.gameLogicManager = [[GameLogicManager alloc]init];
    self.gameLogicManager.myViewController = self;
    
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
    

    
    //Dealer Calculations
    [self.gameLogicManager setImageAndCardValue:self.dealerCardOne];
    [self.gameLogicManager setImageAndCardValue:self.dealerCardTwo];
    self.gameLogicManager.dealerScore = self.dealerCardOne.cardValue + self.dealerCardTwo.cardValue;
    self.dealerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.gameLogicManager.dealerScore];
    
    //Player Calculations
    [self.gameLogicManager setImageAndCardValue:self.playerCardOne];
    [self.gameLogicManager setImageAndCardValue:self.playerCardTwo];
    self.gameLogicManager.playerScore = self.playerCardOne.cardValue + self.playerCardTwo.cardValue;
    self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.gameLogicManager.playerScore];
    
    [self startTheGame];
    
    [self.dealerCardOne setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    self.dealerScoreLabel.hidden = YES;
}

- (void) startTheGame {
    if (self.gameLogicManager.playerScore == 21) {
        NSLog(@"BLACKJACK! YOU WIN!!");
        [self postPlayerWinScene];
        self.resultsAnnounceLabel.text = @"BLACKJACK!";
    }
    else if (self.gameLogicManager.playerScore < 21) {
        NSLog(@"you can hit if you want to");
    }
    
}



- (IBAction)hitButtonPressedAction:(id)sender {
    
    if (self.optionalPlayerCardThree.cardValue == 0) {
        [self.gameLogicManager setImageAndCardValue:self.optionalPlayerCardThree];
        self.gameLogicManager.playerScore += self.optionalPlayerCardThree.cardValue;
        self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.gameLogicManager.playerScore];
        [self runPostHitButtonPlayerCalculations];
    }
    
    else {
        [self.gameLogicManager setImageAndCardValue:self.optionalPlayerCardFour];
        self.gameLogicManager.playerScore += self.optionalPlayerCardFour.cardValue;
        self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.gameLogicManager.playerScore];
        [self runPostHitButtonPlayerCalculations];

    }
    
}

- (void) runPostHitButtonPlayerCalculations {
    if (self.gameLogicManager.playerScore == 21) {
        NSLog(@"BLACKJACK!");
        [self postPlayerWinScene];
        self.resultsAnnounceLabel.text = @"BLACKJACK!";
    }
    else if (self.gameLogicManager.playerScore > 21) {
        NSLog(@"BUST YOU LOSE");
        self.playerScoreLabel.text = @"BUST";
        self.playerScoreLabel.textColor = [UIColor orangeColor];
        [self postPlayerLoseScene];
    }
    else {
        self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.gameLogicManager.playerScore];
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
    if (self.gameLogicManager.dealerScore >= 17) {
        //we run results logic
        [self.gameLogicManager runGameResultsCalculation];
    }
    else {
        NSLog(@"Dealer has to hit");
        double delayInSeconds = 0.75;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // code to be executed on the main queue after delay
            [self.gameLogicManager setImageAndCardValue:self.optionalDealerCardThree];
            self.gameLogicManager.dealerScore = self.dealerCardOne.cardValue + self.dealerCardTwo.cardValue + self.optionalDealerCardThree.cardValue;

            if (self.gameLogicManager.dealerScore > 21) {
                self.dealerScoreLabel.text = @"BUST";
                self.dealerScoreLabel.textColor = [UIColor orangeColor];
                [self.gameLogicManager runGameResultsCalculation];
            }
            else {
                self.dealerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.gameLogicManager.dealerScore];
                //if dealer score is less than 17, we need fourth card logic
                if (self.gameLogicManager.dealerScore < 17) {
                    //we ask for 4th card
                    [self.gameLogicManager setImageAndCardValue:self.optionalDealerCardFour];
                    self.gameLogicManager.dealerScore = self.dealerCardOne.cardValue + self.dealerCardTwo.cardValue + self.optionalDealerCardThree.cardValue + self.optionalDealerCardFour.cardValue;
                    if (self.gameLogicManager.dealerScore <= 21) {
                        self.dealerScoreLabel.text = [NSString stringWithFormat:@"%ld", self.gameLogicManager.dealerScore];
                    }
                    else {
                        self.dealerScoreLabel.text = @"BUST";
                        self.dealerScoreLabel.textColor = [UIColor orangeColor];
                    }
                }
                [self.gameLogicManager runGameResultsCalculation];
            }
        });
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







@end
