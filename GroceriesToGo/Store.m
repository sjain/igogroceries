//
//  Store.m
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import "Store.h"

@implementation Store

@synthesize objectID;
@synthesize name;
@synthesize address1;
@synthesize city;

-(id)initWithObjectID:(NSNumber *)objectIDIn Name:(NSString *)nameIn AndCity:(NSString *)cityIn;
{
  self = [super init];
  self.objectID = objectIDIn;
  self.name = nameIn;
  self.city = cityIn;
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat: @"Store: objectID=%@ name=%@ city=%@",
          self.objectID,
          self.name,
          self.city];
}

@end
