//
//  LeftTableViewController.m
//  Raywenderlich-Splitview
//
//  Created by Aditya Narayan on 9/30/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "LeftTableViewController.h"
#import "Monster.h"

@interface LeftTableViewController ()

@end

@implementation LeftTableViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        //Initialize the array of monsters for display.
        self.monsters = [NSMutableArray array];
        
        //Create monster objects then add them to the array.
        [self.monsters addObject:[Monster newMonsterWithName:@"Cat-Bot" description:@"MEE-OW"
                                                iconName:@"meetcatbot.png" weapon:Sword]];
        [self.monsters addObject:[Monster newMonsterWithName:@"Dog-Bot" description:@"BOW-WOW"
                                                iconName:@"meetdogbot.png" weapon:Blowgun]];
        [self.monsters addObject:[Monster newMonsterWithName:@"Explode-Bot"
                                             description:@"Tick, tick, BOOM!" iconName:@"meetexplodebot.png" weapon:Smoke]];
        [self.monsters addObject:[Monster newMonsterWithName:@"Fire-Bot"
                                             description:@"Will Make You Steamed" iconName:@"meetfirebot.png" weapon:NinjaStar]];
        [self.monsters addObject:[Monster newMonsterWithName:@"Ice-Bot"
                                             description:@"Has A Chilling Effect" iconName:@"meeticebot.png" weapon:Fire]];
        [self.monsters addObject:[Monster newMonsterWithName:@"Mini-Tomato-Bot"
                                             description:@"Extremely Handsome" iconName:@"meetminitomatobot.png" weapon:NinjaStar]];        
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.monsters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Monster *monster = self.monsters[indexPath.row];
    cell.textLabel.text = monster.name;
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
