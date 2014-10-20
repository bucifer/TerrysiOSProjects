//
//  ViewController.h
//  BlackJack
//
//  Created by Aditya Narayan on 10/17/14.
//  Copyright (c) 2014 TerrysCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCardButton.h"
#import "GameLogicManager.h"

@class GameLogicManager;

@interface ViewController : UIViewController


@property (nonatomic) GameLogicManager *gameLogicManager;


@property (strong, nonatomic) IBOutlet CustomCardButton *dealerCardOne;
@property (strong, nonatomic) IBOutlet CustomCardButton *dealerCardTwo;
@property (strong, nonatomic) IBOutlet CustomCardButton *playerCardOne;
@property (strong, nonatomic) IBOutlet CustomCardButton *playerCardTwo;


@property (strong, nonatomic) IBOutlet UILabel *dealerScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *playerScoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *resultsAnnounceLabel;

@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *hitButton;
@property (strong, nonatomic) IBOutlet UIButton *stayButton;
@property (strong, nonatomic) IBOutlet UIButton *playAgainButton;


- (IBAction)playGameButtonPressAction:(id)sender;
- (IBAction)hitButtonPressedAction:(id)sender;
- (IBAction)stayButtonPressedAction:(id)sender;
- (IBAction)playAgainButton:(id)sender;


- (IBAction)dealerCardOnePressed:(id)sender;
- (IBAction)dealerCardTwoPressed:(id)sender;
- (IBAction)dealerCardThreePressed:(id)sender;
- (IBAction)dealerCardFourPressed:(id)sender;


@property (strong, nonatomic) IBOutlet CustomCardButton *optionalPlayerCardThree;
@property (strong, nonatomic) IBOutlet CustomCardButton *optionalPlayerCardFour;

@property (strong, nonatomic) IBOutlet CustomCardButton *optionalDealerCardThree;
@property (strong, nonatomic) IBOutlet CustomCardButton *optionalDealerCardFour;


- (void) postTieResultScene;
- (void) postPlayerWinScene;
- (void) postPlayerLoseScene;


@end

