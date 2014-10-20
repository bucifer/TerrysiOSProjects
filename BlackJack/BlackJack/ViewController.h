//
//  ViewController.h
//  BlackJack
//
//  Created by Aditya Narayan on 10/17/14.
//  Copyright (c) 2014 TerrysCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCardButton.h"

@interface ViewController : UIViewController


@property (strong, nonatomic) NSMutableArray* availableCardsInDeck;

@property (strong, nonatomic) IBOutlet CustomCardButton *dealerCardOne;
@property (strong, nonatomic) IBOutlet CustomCardButton *dealerCardTwo;
@property (strong, nonatomic) IBOutlet CustomCardButton *playerCardOne;
@property (strong, nonatomic) IBOutlet CustomCardButton *playerCardTwo;


@property (nonatomic) NSInteger playerScore;
@property (nonatomic) NSInteger dealerScore;
@property (strong, nonatomic) IBOutlet UILabel *dealerScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *playerScoreLabel;


@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *hitButton;


- (IBAction)playGameButtonPressAction:(id)sender;
- (IBAction)hitButtonPressedAction:(id)sender;
- (IBAction)stayButtonPressedAction:(id)sender;


- (IBAction)dealerCardOnePressed:(id)sender;
- (IBAction)dealerCardTwoPressed:(id)sender;
- (IBAction)dealerCardThreePressed:(id)sender;
- (IBAction)dealerCardFourPressed:(id)sender;


@property (strong, nonatomic) IBOutlet CustomCardButton *optionalPlayerCardThree;


@property (strong, nonatomic) IBOutlet CustomCardButton *optionalDealercardThree;


@end

