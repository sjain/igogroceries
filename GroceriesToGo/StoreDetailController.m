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
- (NSString *)buildMultilineString:(NSArray *)addressLines;
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
      NSArray *addressLines = [_selectedStore addressStrings];
      NSString *addressString = [self buildMultilineString:addressLines];
      cell.detailTextLabel.text = addressString;
      cell.detailTextLabel.numberOfLines = addressLines.count;
      cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
      break;
    }
    case 1:
    {
      cell.textLabel.text = @"Phone";
      cell.detailTextLabel.text = [_selectedStore phoneFormatted];
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
    {
      NSArray *addressLines = [_selectedStore addressStrings];
      NSString *addressString = [self buildMultilineString:addressLines];
      UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
      CGSize withinSize = CGSizeMake(167, 1000); // 167 is the approximate width of detailTextLabel
      CGSize size = [addressString sizeWithFont:font constrainedToSize:withinSize lineBreakMode:UILineBreakModeCharacterWrap];
      height = size.height + 30;
    }
    break;
    default:
    {
      height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
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

- (NSString *)buildMultilineString:(NSArray *)addressLines
{
  NSMutableString *addressString = [NSMutableString stringWithString:@""];
  for (NSString *line in addressLines) {
    if (addressString.length == 0)
      [addressString appendFormat:@"%@", line];
    else
      [addressString appendFormat:@"\n%@", line];
  }
  return addressString;
}

@end
