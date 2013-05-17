//
//  SelectStoreController.h
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectStoreController : UITableViewController {
  NSNumber *selectedStateID;
}

@property (nonatomic, retain) NSNumber* selectedStateID;

- (id)initWithStateID:(NSNumber *)stateID;

@end
