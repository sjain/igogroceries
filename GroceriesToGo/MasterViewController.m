//
//  MasterViewController.m
//  GroceriesToGo
//
//  Created by Sharad Jain on 4/8/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "FMDatabase.h"

@interface MasterViewController () {
  NSMutableDictionary *_storeCountsByState;
  FMDatabase *_database;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)loadStoresFromDatabase;
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      self.title = NSLocalizedString(@"Select State", @"Master");
    _database = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).database;
    [self loadStoresFromDatabase];
  }
  
  return self;
}
							
- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _storeCountsByState.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
  NSArray *stateNames = [_storeCountsByState allKeys];
  NSLog(@"stateNames: %@", stateNames);
  int rowNumber = indexPath.row;
  NSLog(@"rowNumber: %d", rowNumber);
  NSString *key = [stateNames objectAtIndex:rowNumber];
  NSLog(@"key = %@", key);
  cell.textLabel.text = key;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    if (!self.detailViewController) {
	        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPhone" bundle:nil];
	    }
        self.detailViewController.detailItem = object;
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    } else {
        self.detailViewController.detailItem = object;
    }
}


- (void)loadStoresFromDatabase
{
  FMResultSet *results = [_database executeQuery:@"select state, count(*) as count from stores group by state"];
  NSLog(@"printing results");
  _storeCountsByState = [[NSMutableDictionary alloc] initWithCapacity:60];
  while([results next]) {
    NSString *state = [results stringForColumn:@"state"];
    int count  = [results intForColumn:@"count"];
    NSLog(@"Store: %@ - %d", state, count);
    [_storeCountsByState setValue:[NSNumber numberWithInt:count] forKey:state];
  }
  NSLog(@"printing results done");
}

@end
