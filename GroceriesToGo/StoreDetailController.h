//
//  StoreDetailController.h
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"

@interface StoreDetailController : UITableViewController {
  Store *selectedStore;
}

@property (retain, nonatomic) Store *selectedStore;

- (id)initWithSelectedStore:(Store *)storeIn;

@end
