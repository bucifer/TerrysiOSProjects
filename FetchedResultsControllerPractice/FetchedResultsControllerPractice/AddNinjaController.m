//
//  AddNinjaController.m
//  FetchedResultsControllerPractice
//
//  Created by Aditya Narayan on 12/11/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "AddNinjaController.h"

@interface AddNinjaController ()

@end

@implementation AddNinjaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)save:(id)sender {
    // Helpers
    NSString *name = self.nameTextField.text;
    NSNumber *age = [NSNumber numberWithInt:[self.ageTextField.text intValue]];
    BOOL canDoRasengan = self.rasenganSwitch.selected;
    
    
    if (name && name.length) {
        // Create Entity
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ninja" inManagedObjectContext:self.managedObjectContext];
        
        // Initialize Record
        NSManagedObject *record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        
        // Populate Record
        [record setValue:name forKey:@"name"];
        [record setValue:age forKey:@"age"];
        [record setValue:[NSNumber numberWithBool:canDoRasengan] forKey:@"canDoRasengan"];

        
        // Save Record
        NSError *error = nil;
        
        if ([self.managedObjectContext save:&error]) {
            // Dismiss View Controller
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            if (error) {
                NSLog(@"Unable to save record.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
    } else {
        // Show Alert View
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do needs a name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (IBAction)switchAction:(id)sender {
    
    if([sender isOn]){
        NSLog(@"Switch is ON");
    } else{
        NSLog(@"Switch is OFF");
    }
    
}


@end
