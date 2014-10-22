//
//  faveCarsViewController.h
//  faveCars
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cars.h"

@interface faveCarsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textFieldMake;

@property (strong, nonatomic) IBOutlet UITextField *textFieldModel;

@property (strong, nonatomic) IBOutlet UITextField *textFieldColor;

@property (strong) Cars *car;

@end
