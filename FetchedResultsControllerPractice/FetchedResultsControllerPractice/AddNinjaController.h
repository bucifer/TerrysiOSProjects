//
//  AddNinjaController.h
//  FetchedResultsControllerPractice
//
//  Created by Aditya Narayan on 12/11/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddNinjaController : UIViewController <UITextFieldDelegate>



@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *ageTextField;

@property (strong, nonatomic) IBOutlet UISwitch *rasenganSwitch;

- (IBAction)switchAction:(id)sender;



@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
