//
//  SelectStateController.h
//  GroceriesToGo
//
//  Created by Sharad Jain on 4/8/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@class StoreDetailController;

@interface SelectStateController : UITableViewController

@property (strong, nonatomic) StoreDetailController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
