//
//  Store.m
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import "Store.h"

@implementation Store

-(id)initWithObjectID:(NSNumber *)objectID Name:(NSString *)name AndCity:(NSString *)city;
{
  self = [super init];
  self.objectID = objectID;
  self.name = name;
  self.city = city;
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat: @"Store: objectID=%@ name=%@ city=%@",
          self.objectID,
          self.name,
          self.city];
}

@end
