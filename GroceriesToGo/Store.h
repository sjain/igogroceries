//
//  Store.h
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject

@property (nonatomic, retain) NSNumber *objectID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address1;
@property (nonatomic, retain) NSString *city;

-(id)initWithObjectID:(NSNumber *)objectID Name:(NSString *)name AndCity:(NSString *)city;
- (NSString *)description;

@end
