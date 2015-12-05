//
//  Item.m
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/28/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "Item.h"

@implementation Item

- (void)awakeFromInsert {
  [super awakeFromInsert];
  
  self.dateCreated = [[NSDate alloc] init];
  
  NSUUID *uuid = [[NSUUID alloc] init];
  self.itemKey = [uuid UUIDString];
}

// Insert code here to add functionality to your managed object subclass
+ (id)randomItem
{
  // Create an array of three adjectives
  NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
  // Create an array of three nouns
  NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
  // Get the index of a random adjective/noun from the lists
  // Note: The % operator, called the modulo operator, gives
  // you the remainder. So adjectiveIndex is a random number
  // from 0 to 2 inclusive.
  NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
  NSInteger nounIndex = rand() % [randomNounList count];
  // Note that NSInteger is not an object, but a type definition
  // for "unsigned long"
  NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                          randomAdjectiveList[adjectiveIndex],
                          randomNounList[nounIndex]];
  int randomValue = rand() % 100;
  NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                  '0' + rand() % 10,
                                  'A' + rand() % 26,
                                  '0' + rand() % 10,
                                  'A' + rand() % 26,
                                  '0' + rand() % 10];
  Item *newItem =
  [[self alloc] initWithItemName:randomName
                  valueInDollars:randomValue
                    serialNumber:randomSerialNumber];
  return newItem;
}

- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
          serialNumber:(NSString *)sNumber
{
  // Call the superclass's designated initializer
  self = [super init];
  // Did the superclass's designated initializer succeed?
  if (self) {
    // Give the instance variables initial values
    self.itemName = name;
    self.serialNumber = sNumber;
    self.valueInDollars = value;
    self.dateCreated = [[NSDate alloc] init];
    
    NSUUID *uuid = [[NSUUID alloc] init];
    self.itemKey = [uuid UUIDString];
  }
  
  // Return the address of the newly initialized object
  return self;
}

- (id)init {
  return [self initWithItemName:@"Item"
                 valueInDollars:0
                   serialNumber:@""];
}

- (NSString *)description
{
  NSString *descriptionString =
  [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
   self.itemName,
   self.serialNumber,
   self.valueInDollars,
   self.dateCreated];
  return descriptionString;
}

- (void)dealloc
{
  NSLog(@"Destroyed: %@", self);
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.itemName forKey:@"itemName"];
  [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
  [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
  [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
  [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super init]) {
    self.itemName = [aDecoder decodeObjectForKey:@"itemName"];
    self.serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
    self.dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
    self.itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
    self.valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
  }
  return self;
}

@end
