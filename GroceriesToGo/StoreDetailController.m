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
}

@end

@implementation StoreDetailController

@synthesize selectedStore;

- (id)initWithSelectedStore:(Store *)storeIn
{
  self = [super init];
  if (self) {
    self.selectedStore = storeIn;
    _database = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).database;
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
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleValue2
            reuseIdentifier:CellIdentifier];
  }
  
  switch (indexPath.row) {
    case 0:
      cell.textLabel.text = @"Address";
      cell.detailTextLabel.text = selectedStore.address1;
      break;
    case 1:
      cell.textLabel.text = @"Phone";
      cell.detailTextLabel.text = @"(123)123.1232";
      break;
    case 2:
      cell.textLabel.text = @"Email";
      cell.detailTextLabel.text = @"info@groceryport.com";
      break;
    default:
      cell.textLabel.text = @"Unknown";
      cell.detailTextLabel.text = @"Unknown";
      break;
  }
  
  return cell;
}


@end
