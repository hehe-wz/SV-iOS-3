//
//  DataModel.m
//  ChecklistsII
//
//  Created by Eric Huang on 11/19/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "DataModel.h"
#import "Checklist.h"

@implementation DataModel

#pragma mark - init method

-(instancetype)init {
  self = [super init];
  [self loadChecklists];
  return self;
}

#pragma mark - save and load methods

-(NSString *)documentsDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  return paths[0];
}

-(NSString *)dataFilePath {
  NSString *directory = [self documentsDirectory];
  return [directory stringByAppendingString:@"Checklist.plist"];
}

-(void)saveChecklists {
  NSMutableData *data = [[NSMutableData alloc] init];
  NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  [archiver encodeObject:self.lists forKey:@"Checklists"];
  [archiver finishEncoding];
  [data writeToFile:[self dataFilePath] atomically:YES];
  NSLog(@"!!!!! Data have been saved -> %@", data);
}

-(void)loadChecklists {
  NSString *path = [self dataFilePath];
  NSLog(@"!!!!! Data load from -> %@", [self dataFilePath]);
  if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
    [unarchiver finishDecoding];
  }
}

+(NSInteger)nextChecklistItemID {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSInteger itemID = [userDefaults integerForKey:@"ChecklistItemID"];
  [userDefaults setInteger:itemID + 1 forKey:@"ChecklistItemID"];
  [userDefaults synchronize];
  return itemID;
}

-(void)registerDefaults {
  NSDictionary *dictionary = @{@"ChecklistIndex" : [NSNumber numberWithInteger:-1], @"FirstTime" : [NSNumber numberWithBool:YES], @"ChecklistItemID" : [NSNumber numberWithInteger:0]};
  [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

-(void)sortChecklists {
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
  NSArray *tmp = [self.lists sortedArrayUsingDescriptors:@[sort]];
  self.lists = [[NSMutableArray alloc] init];
  for (Checklist *checklist in tmp) {
    [self.lists addObject:checklist];
  }
  [self saveChecklists];
}

@end
