//
//  SelectStateController.m
//  GroceriesToGo
//
//  Created by Sharad Jain on 4/8/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import "SelectStateController.h"
#import "StoreDetailController.h"
#import "FMDatabase.h"

@interface SelectStateController () {
  NSMutableArray *_sortedStateIDs;
  NSMutableArray *_stateNameAndStoreCount;
  FMDatabase *_database;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)loadStoresFromDatabase;
@end

@implementation SelectStateController

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
    return _sortedStateIDs.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary *stateNameAndCount = [_stateNameAndStoreCount objectAtIndex:indexPath.row];
  NSString *stateName = [stateNameAndCount objectForKey:@"state"];
  int storeCount = [((NSNumber *)[stateNameAndCount objectForKey:@"store_count"]) intValue];
  cell.textLabel.text = stateName;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%d stores", storeCount];
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
  NSDictionary *stateNameAndCount = [_stateNameAndStoreCount objectAtIndex:indexPath.row];
  NSNumber *stateID = [stateNameAndCount objectForKey:@"state_id"];
  self.selectStoreController = [[SelectStoreController alloc]
                                initWithStyle:UITableViewStyleGrouped
                                AndSelectedStateID:stateID];
  [self.navigationController pushViewController:self.selectStoreController animated:YES];
}


- (void)loadStoresFromDatabase
{
  FMResultSet *results = [_database executeQuery:@"select us_states.id, us_states.name, count(*) as count from us_states inner join stores on stores.us_state_id = us_states.id group by us_states.name order by us_states.name asc"];
  NSLog(@"loading US state / store counts");
  _sortedStateIDs = [[NSMutableArray alloc] initWithCapacity:60];
  _stateNameAndStoreCount = [[NSMutableArray alloc] initWithCapacity:60];
  while([results next]) {
    int stateID  = [results intForColumn:@"id"];
    NSString *state = [results stringForColumn:@"name"];
    int count  = [results intForColumn:@"count"];
    [_sortedStateIDs addObject:[NSNumber numberWithInt:stateID]];
    [_stateNameAndStoreCount addObject:@{
     @"state": state,
     @"store_count": [NSNumber numberWithInt:count],
     @"state_id": [NSNumber numberWithInt:stateID]
    }];
  }
}

@end
