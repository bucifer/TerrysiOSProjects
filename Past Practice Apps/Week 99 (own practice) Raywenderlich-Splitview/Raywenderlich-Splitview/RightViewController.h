//
//  RightViewController.h
//  Raywenderlich-Splitview
//
//  Created by Aditya Narayan on 9/30/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Monster.h"

@interface RightViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *monsterImageView;


@property (strong, nonatomic) IBOutlet UILabel *monsterNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *monsterDescriptionLabel;

@property (strong, nonatomic) IBOutlet UILabel *monsterWeaponLabel;

@property (strong, nonatomic) IBOutlet UIImageView *monsterWeaponImage;


@property (strong, nonatomic) Monster *monster;

-(void)setMonster:(Monster *)monster;
-(void)refreshUI;

@end
