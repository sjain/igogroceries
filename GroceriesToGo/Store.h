//
//  Store.h
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject

@property (strong, nonatomic) NSNumber *objectID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;

-(id)initWithObjectID:(NSNumber *)objectID Name:(NSString *)name AndCity:(NSString *)city;
- (NSString *)description;

@end
