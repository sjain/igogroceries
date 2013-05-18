//
//  Store.m
//  iGoGroceries
//
//  Created by Sharad Jain on 5/16/13.
//  Copyright (c) 2013 GroceryPORT.com, Inc. All rights reserved.
//

#import "Store.h"

@interface Store ()
- (NSString *)orEmpty:(NSString *)value;
@end
  
@implementation Store

@synthesize objectID;
@synthesize name;
@synthesize address1;
@synthesize address2;
@synthesize city;
@synthesize stateCode;
@synthesize zip;
@synthesize phone;

-(id)initWithObjectID:(NSNumber *)objectIDIn Name:(NSString *)nameIn AndCity:(NSString *)cityIn;
{
  self = [super init];
  self.objectID = objectIDIn;
  self.name = nameIn;
  self.city = cityIn;
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat: @"Store: %@",
          @{
            @"objectID": self.objectID,
            @"name": [self orEmpty:self.name],
            @"address1": [self orEmpty:self.address1],
            @"address2": [self orEmpty:self.address2],
            @"city": [self orEmpty:self.city],
            @"stateCode": [self orEmpty:self.stateCode],
            @"zip": [self orEmpty:self.zip],
            @"phone": [self orEmpty:self.phone]
          }];
}

- (NSString *)orEmpty:(NSString *)value
{
  if (value)
    return value;
  else
    return @"";
}

- (NSString *)phoneFormatted
{
  if (!self.phone || [self.phone length] == 0 )
  {
    return self.phone;
  }
  
  NSString *phoneNumbers = [self.phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
  phoneNumbers = [phoneNumbers stringByReplacingOccurrencesOfString:@")" withString:@""];
  phoneNumbers = [phoneNumbers stringByReplacingOccurrencesOfString:@"." withString:@""];
  phoneNumbers = [phoneNumbers stringByReplacingOccurrencesOfString:@"-" withString:@""];
  phoneNumbers = [phoneNumbers stringByReplacingOccurrencesOfString:@" " withString:@""];
  if ([phoneNumbers length] == 10)
  {
    NSString *areaCode = [phoneNumbers substringWithRange:NSMakeRange(0, 3)];
    NSString *phone3 = [phoneNumbers substringWithRange:NSMakeRange(3, 3)];
    NSString *last4 = [phoneNumbers substringWithRange:NSMakeRange(6, 4)];
    NSString *formattedString = [NSString stringWithFormat:@"(%@) %@-%@", areaCode, phone3, last4];
    return formattedString;
  }
  else
  {
    return phoneNumbers;
  }
}

- (NSString *)cityStateZip
{
  NSString *cityStateZip = [NSString stringWithFormat:@"%@, %@ %@",
                            self.city,
                            self.stateCode,
                            self.zip
                            ];
  return cityStateZip;
}

- (NSArray *)addressStrings
{
  NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:3];
  [result addObject:self.address1];
  if (self.address2 && self.address2.length > 0)
  {
    [result addObject:self.address2];
  }
  [result addObject:[self cityStateZip]];
  return result;
}

@end
