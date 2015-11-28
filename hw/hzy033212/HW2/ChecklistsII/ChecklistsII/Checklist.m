//
//  Checklist.m
//  ChecklistsII
//
//  Created by Eric Huang on 11/18/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "Checklist.h"

@implementation Checklist

-(instancetype)init: (NSString *)name withIconName: (NSString *) iconName {
  self = [super init];
  self.name = name;
  self.iconName = iconName;
  return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  self.name = (NSString *)[aDecoder decodeObjectForKey:@"Name"];
  self.items = (NSMutableArray<ChecklistItem *> *)[aDecoder decodeObjectForKey:@"Items"];
  self.iconName = (NSString *)[aDecoder decodeObjectForKey:@"IconName"];
  return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.name forKey:@"Name"];
  [aCoder encodeObject:self.items forKey:@"Items"];
  [aCoder encodeObject:self.iconName forKey:@"IconName"];
}

-(NSInteger)countUncheckedItems {
  NSInteger count = 0;
  for (ChecklistItem *item in self.items) {
    if (!item.checked) {
      count += 1;
    }
  }
  return count;
}

-(void)sortSingleChecklist {
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES selector:@selector(compare:)];
  NSArray *tmp = [self.items sortedArrayUsingDescriptors:@[sort]];
  self.items = [[NSMutableArray alloc] init];
  for (ChecklistItem *checklistItem in tmp) {
    [self.items addObject:checklistItem];
  }
//  [self saveChecklists];
}

@end
