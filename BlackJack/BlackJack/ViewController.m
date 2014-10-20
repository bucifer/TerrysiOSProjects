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
    
    [self setImageAndCardValue:self.playerCardOne];
    [self setImageAndCardValue:self.playerCardTwo];

    self.playerScore = self.playerCardOne.cardValue + self.playerCardTwo.cardValue;
    self.playerScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.playerCardOne.cardValue];
    
    
    
    [self setImageAndCardValue:self.dealerCardOne];
    [self setImageAndCardValue:self.dealerCardTwo];
    
    self.dealerScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.playerCardOne.cardValue];
    self.dealerScore = self.dealerCardOne.cardValue + self.dealerCardTwo.cardValue;
}


- (void) setImageAndCardValue: (CustomCardButton *) yourCardButton{
    
    NSString *myCardNumberString = [self randomCardNumberStringGeneratorUnique];
    NSInteger rawCardNameValue = [myCardNumberString integerValue];
    NSInteger myCardValue;
    
    if (rawCardNameValue <= 20) {
        myCardValue = 10;
    }
    else {
        //21,22,23,24 are all 9s
        //25,26,27,28 are all 8s
        int n = 9;

        for (int j = 21; j <= 49; j = j + 4) {
            for (int i = j; i <= j+3; i++) {
                if (rawCardNameValue == i) {
                    myCardValue = n;
                }
            }
            n = n - 1;
            if (n == 0) break;
        }
        
    }
    [yourCardButton setBackgroundImage:[UIImage imageNamed:myCardNumberString] forState:UIControlStateNormal  ];
    
    yourCardButton.cardValue = myCardValue;
}


- (NSString *) randomCardNumberStringGeneratorUnique {
    
    NSLog(@"Available cards count: %lu", (unsigned long)self.availableCardsInDeck.count);
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
