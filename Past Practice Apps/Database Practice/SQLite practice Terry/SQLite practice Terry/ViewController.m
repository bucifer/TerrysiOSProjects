//
//  ViewController.m
//  SQLite practice Terry
//
//  Created by Aditya Narayan on 9/17/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSMutableArray *arrayOfPeople;
    sqlite3 *personDB;
    NSString *dbPathString;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayOfPeople = [[NSMutableArray alloc]init];
    self.myTableview.delegate = self;
    //remember this step, easy to forget why your tableView is not showing the right cells if you don't set the delegates here
    //also remember to actually populate the array above if you want stuff showing
    self.myTableview.dataSource = self;
    
    [self createOrOpenDB];
    [self displayPerson];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    //this cancelsTouchesInView method for UITapGestureRecognizer makes sure that it doesn't apply freaking everywhere and breaks things like Delete function
}

-(void)dismissKeyboard {
    [self.nameTextfield resignFirstResponder];
    [self.ageTextfield resignFirstResponder];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    UITableView *tableView = self.myTableview;
    CGPoint touchPoint = [touch locationInView:tableView];
    return ![tableView hitTest:touchPoint withEvent:nil];
}

-(void)createOrOpenDB
{
    char *error;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    dbPathString = [docPath stringByAppendingPathComponent:@"person.sqlite3"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:dbPathString])
    {
        const char *dbPath = [dbPathString UTF8String];
        
        //create the database
        if (sqlite3_open(dbPath, &personDB)== SQLITE_OK)
        {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PERSONS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER)";
            if(sqlite3_exec(personDB, sql_stmt, NULL, NULL, &error) == SQLITE_OK)
                //execute the sql statement
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Create" message:@"Create table" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
                [alert show];
            }
            NSLog(@"Created table");
            sqlite3_close(personDB);
        }
        else
        {
            NSLog(@"Unable to open db");
        }
    }
    else {
        NSLog(@"we found your db at the path");
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayOfPeople.count;
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    Person *aPerson = [arrayOfPeople objectAtIndex:indexPath.row];
    cell.textLabel.text = aPerson.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",aPerson.age];
    return cell;
    
}


- (IBAction)addPersonButton:(id)sender {
    char *error;
    if(sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
    {
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PERSONS (NAME,AGE) VALUES ('%s','%d')",[self.nameTextfield.text UTF8String],[self.ageTextfield.text intValue]];
        const char *insert_stmt = [insertStmt UTF8String];
        NSLog(@"Add Person button click..");
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
        {
            NSLog(@"Person added to DB");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add person Complete" message:@"Person added to DB" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alert show];
            Person *person = [[Person alloc] init];
            [person setName:self.nameTextfield.text];
            [person setAge: @([self.ageTextfield.text intValue]) ];
            [arrayOfPeople addObject:person];
        }
        sqlite3_close(personDB);
    }
    [self displayPerson];

    
}

- (IBAction)deletePersonbutton:(id)sender {
    
    UIButton *btn  = sender;
    if([[self myTableview] isEditing])
    {
        [btn setTitle:@"Delete" forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitle:@"Done" forState:UIControlStateNormal];
    }
    
    [[self myTableview]setEditing:!self.myTableview.editing animated:YES];
}

-(void)deleteData:(NSString *)deleteQuery
{
    char *error;
    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK)
    {
        NSLog(@"Person Deleted");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Person Deleted" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Person *p = [arrayOfPeople objectAtIndex:indexPath.row];
        [self deleteData:[NSString stringWithFormat:@"DELETE FROM PERSONS WHERE NAME IS '%s'", [p.name UTF8String]]];
        [arrayOfPeople removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)displayPerson
{
    sqlite3_stmt *statement ;
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK)
    {
        [arrayOfPeople removeAllObjects];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM PERSONS"];
        const char *query_sql = [querySQL UTF8String];
        if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *ageString = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                Person *person = [[Person alloc]init];
                [person setName:name];
                [person setAge: @([ageString intValue]) ];
                [arrayOfPeople addObject:person];
            }
        }
    }
    [[self myTableview]reloadData];
}

@end
