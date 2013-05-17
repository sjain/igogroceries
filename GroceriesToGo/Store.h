//
//  Store.h
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject {
  NSNumber *objectID;
  NSString *name;
  NSString *address1;
  NSString *address2;
  NSString *city;
  NSString *stateCode;
  NSString *zip;
  NSString *phone;
}

@property (nonatomic, retain) NSNumber *objectID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address1;
@property (nonatomic, retain) NSString *address2;
@property (nonatomic, retain) NSString *stateCode;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *phone;

-(id)initWithObjectID:(NSNumber *)objectID Name:(NSString *)name AndCity:(NSString *)city;
- (NSString *)description;

@end
