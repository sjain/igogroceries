//
//  SelectStoreController.m
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import "SelectStoreController.h"
#import "FMDatabase.h"
#import "AppDelegate.h"
#import "Store.h"
#import "StoreDetailController.h"

@interface SelectStoreController () {
  NSMutableArray *_cities;
  NSMutableDictionary *_cityStores;
  FMDatabase *_database;
}

- (void)loadCityNames;
- (void)loadStores;
- (NSString *)loadStateName;
@end

@implementation SelectStoreController

@synthesize selectedStateID;

- (id)initWithStateID:(NSNumber *)stateID
{
  self = [super init];
  if (self) {
    _database = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).database;
    self.selectedStateID = stateID;
    NSString *stateName = [self loadStateName];
    self.title = NSLocalizedString(stateName, @"Master");
    [self loadStores];
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return _cities.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSString *city = [_cities objectAtIndex:section];
  NSArray *stores = [_cityStores objectForKey:city];
  return stores.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  NSString *city = [_cities objectAtIndex:section];
  return city;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
  }

  NSString *city = [_cities objectAtIndex:indexPath.section];
  NSArray *cityStores = [_cityStores objectForKey:city];
  Store *store = [cityStores objectAtIndex:indexPath.row];
  cell.textLabel.text = store.name;
  cell.detailTextLabel.text = store.address1;
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *city = [_cities objectAtIndex:indexPath.section];
  NSArray *cityStores = [_cityStores objectForKey:city];
  Store *store = [cityStores objectAtIndex:indexPath.row];
  StoreDetailController *storeDetailController = [[StoreDetailController alloc]
                                initWithSelectedStore:store];
  [self.navigationController pushViewController:storeDetailController animated:YES];
}


- (void)loadStores
{
  [self loadCityNames];
  FMResultSet *results = [_database executeQuery:@"select city, name, id, address1 from stores where us_state_id=? order by city asc, name asc", self.selectedStateID];
  _cityStores = [[NSMutableDictionary alloc] initWithCapacity:100];
  while([results next])
  {
    NSString *city = [results stringForColumn:@"city"];
    NSString *name = [results stringForColumn:@"name"];
    int storeID  = [results intForColumn:@"id"];
    NSString *address = [results stringForColumn:@"address1"];
    NSMutableArray *stores = [_cityStores objectForKey:city];
    if (!stores)
    {
      stores = [[NSMutableArray alloc] initWithCapacity:20];
      [_cityStores setObject:stores forKey:city];
    }
    Store *store = [[Store alloc] initWithObjectID:[NSNumber numberWithInt:storeID]
                                              Name:name
                                           AndCity:city];
    store.address1 = address;
    [stores addObject:store];
  }    
}

- (void)loadCityNames
{
  FMResultSet *results = [_database executeQuery:@"select distinct city from stores where us_state_id=? order by city asc", self.selectedStateID];
  _cities = [[NSMutableArray alloc] initWithCapacity:100];
  while([results next])
  {
    NSString *city = [results stringForColumn:@"city"];
//    NSLog(@"City: [%@]", city);
    [_cities addObject:city];
  }
}

- (NSString *)loadStateName
{
  FMResultSet *results = [_database executeQuery:@"select name from us_states where id=?", self.selectedStateID];
  [results next];
  return [results stringForColumn:@"name"];
}

@end
