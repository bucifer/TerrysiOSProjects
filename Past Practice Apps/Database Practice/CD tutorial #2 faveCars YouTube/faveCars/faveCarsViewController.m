//
//  faveCarsViewController.m
//  faveCars
//
//  Created by Aditya Narayan on 9/23/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "faveCarsViewController.h"

@interface faveCarsViewController ()

@end

@implementation faveCarsViewController
@synthesize textFieldMake;
@synthesize textFieldModel;
@synthesize textFieldColor;
@synthesize car;

//we need this to retrieve managed object context and later save data (for both Controllers)
- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)savePressed:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    if (car) {
        //Update existing car
        [car setValue:textFieldMake.text forKey:@"make"];
        [car setValue:textFieldModel.text forKey:@"model"];
        [car setValue:textFieldColor.text forKey:@"color"];
        
        Drivers *driver = [NSEntityDescription insertNewObjectForEntityForName:@"Drivers" inManagedObjectContext:context];
        [driver setValue:@"Katie" forKey:@"name"];
        
        [car addDriversObject:driver];
        
        
        Drivers *thisDriver = [car valueForKey: @"drivers"];
        NSLog(@"Testing let's print out driver's name %@", [thisDriver valueForKey:@"name"]);
        
    } else {
        //Create a new car
        //Create a new car
        Cars *newCar = [NSEntityDescription insertNewObjectForEntityForName: @"Cars" inManagedObjectContext:context];
        [newCar setValue:textFieldMake.text forKey:@"make"];
        [newCar setValue:textFieldModel.text forKey:@"model"];
        [newCar setValue:textFieldColor.text forKey:@"color"];
    }

    NSError *error = nil;
    //Save the context
    if (![context save:&error]) {
        NSLog(@"save Failed %@", error.localizedDescription);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    //this code jumps back to TableView
    
}

- (IBAction)cancelPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (car) {
        [textFieldMake setText:[car valueForKey:@"make"]];
        [textFieldModel setText:[car valueForKey:@"model"]];
        [textFieldColor setText:[car valueForKey:@"color"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
