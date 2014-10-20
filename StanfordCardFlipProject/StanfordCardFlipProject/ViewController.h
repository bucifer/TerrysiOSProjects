//
//  ViewController.h
//  StanfordCardFlipProject
//
//  Created by Aditya Narayan on 10/17/14.
//  Copyright (c) 2014 TerrysCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myCustomCardButton.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *myCardButton;


@property (strong, nonatomic) IBOutlet UILabel *flipCountLabel;

@property int flipCount;





- (IBAction)cardButtonPressedAction:(UIButton *)sender;

- (IBAction)realCardImageButtonPressed:(myCustomCardButton *)sender;


@end

