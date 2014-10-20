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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)playButtonPressAction:(id)sender {
    
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
        
        for (NSInteger i = 21; i <= 24; i++) {
            if (rawCardNameValue == i) {
                myCardValue = 9;
            }
        }
        for (NSInteger i = 25; i <= 28; i++) {
            if (rawCardNameValue == i) {
                myCardValue = 8;
            }
        }
        for (NSInteger i = 29; i <= 32; i++) {
            if (rawCardNameValue == i) {
                myCardValue = 7;
            }
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
