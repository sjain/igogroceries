//
//  StoreDetailController.m
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import "StoreDetailController.h"
#import "AppDelegate.h"
#import "FMDatabase.h"

@interface StoreDetailController () {
  FMDatabase *_database;
  NSNumber *_storeID;
  Store *_selectedStore;
}

- (Store *)loadStore;
@end

@implementation StoreDetailController

- (id)initWithSelectedStoreID:(NSNumber *)storeID
{
  self = [super init];
  if (self) {
    _database = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).database;
    _storeID = storeID;
    _selectedStore = [self loadStore];
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = nil;
  if (indexPath.row == 0)
    CellIdentifier = @"AddressCell";
  else
    CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleValue2
            reuseIdentifier:CellIdentifier];
  }
  
  switch (indexPath.row) {
    case 0:
    {
      cell.textLabel.text = @"Address";
      NSString *cityStateZip = [NSString stringWithFormat:@"%@, %@ %@",
                                _selectedStore.city,
                                _selectedStore.stateCode,
                                _selectedStore.zip
                                ];
      NSString *addressString = nil;
      int numberOfLines = 0;
      if (_selectedStore.address2)
      {
        addressString = [NSString stringWithFormat:@"%@\n%@\n%@",
                                   _selectedStore.address1,
                                   _selectedStore.address2,
                                   cityStateZip
                                   ];
        numberOfLines = 3;
      }
      else
      {
        addressString = [NSString stringWithFormat:@"%@\n%@",
                         _selectedStore.address1,
                         cityStateZip
                         ];
        numberOfLines = 2;
      }
      cell.detailTextLabel.text = addressString;
      cell.detailTextLabel.numberOfLines = numberOfLines;
      cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
      break;
    }
    case 1:
    {
      cell.textLabel.text = @"Phone";
      cell.detailTextLabel.text = _selectedStore.phone;
      break;
    }
    case 2:
    {
      cell.textLabel.text = @"Email";
      cell.detailTextLabel.text = @"info@groceryport.com";
      break;
    }
    default:
    {
      cell.textLabel.text = @"Unknown";
      cell.detailTextLabel.text = @"Unknown";
      break;
    }
  }
  return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat height = 0.0f;
  switch (indexPath.row) {
    case 0:
      height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
      height = height + 30.0f;
      break;
    default:
      height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
      break;
  }
  return height;
}

- (Store *)loadStore
{
  FMResultSet *results = [_database executeQuery:@"select * from stores where id=?", _storeID];
  [results next];
  NSString *name = [results stringForColumn:@"name"];
  NSString *address1 = [results stringForColumn:@"address1"];
  NSString *address2 = [results stringForColumn:@"address2"];
  NSString *city = [results stringForColumn:@"city"];
  NSString *stateCode = [results stringForColumn:@"state"];
  NSString *zip = [results stringForColumn:@"zip"];
  NSString *phone = [results stringForColumn:@"phone"];
  Store *store = [[Store alloc] initWithObjectID:_storeID
                                            Name:name
                                         AndCity:city];
  store.address1 = address1;
  store.address2 = address2;
  store.stateCode = stateCode;
  store.zip = zip;
  store.phone = phone;
  return store;
}

@end
