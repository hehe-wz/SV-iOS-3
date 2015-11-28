//
//  DataModel.m
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/21/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lists = [[NSMutableArray<Checklist *> alloc] init];
        [self loadChecklists];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

#pragma mark - setter getter

- (NSInteger) indexOfSelectedChecklist {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}

- (void) setIndexOfSelectedChecklist:(NSInteger)indexOfSelectedChecklist {
    [[NSUserDefaults standardUserDefaults] setInteger:indexOfSelectedChecklist forKey:@"ChecklistIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - fileManage

- (NSString *) documentsDirectory {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    return paths[0];
}

- (NSString *) dataFilePath {
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

- (void) saveChecklists {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:_lists forKey:@"Checklist"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void) loadChecklists {
    NSString *path = [self dataFilePath];
    NSLog(@"%@", path);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        if (data != nil) {
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            _lists = (NSMutableArray<Checklist *>*)[unarchiver decodeObjectForKey: @"Checklist"];
            [unarchiver finishDecoding];
            
            // [self sortChecklists];
        }
    }
}

- (void) registerDefaults {
    NSDictionary *dictionary = @{
                                 @"ChecklistIndex": [NSNumber numberWithInteger: -1],
                                 @"FirstTime": [NSNumber numberWithBool: YES],
                                 @"ChecklistItemID": [NSNumber numberWithInteger: 0]
                                };
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (void) handleFirstTime {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    bool firstTime = [userDefault boolForKey:@"FirstTime"];
    
    NSLog(@"First Time ? %d", firstTime);
    
    if (firstTime) {
        Checklist *checklist = [[Checklist alloc] initWithName:@"List"];
        [_lists addObject:checklist];
        self.indexOfSelectedChecklist = 0;
        
        [userDefault setBool:NO forKey:@"FirstTime"];
    }
}

+ (NSInteger) nextChecklistItemID {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger itemID = [userDefault integerForKey:@"ChecklistItemID"];
    [userDefault setInteger:itemID + 1 forKey:@"ChecklistItemID"];
    [userDefault synchronize];
    
    return itemID;
}

#pragma mark - others
- (void) sortChecklists {
    _lists = (NSMutableArray<Checklist *> *)[[_lists sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *first = [(Checklist *) obj1 name];
        NSString *second =[(Checklist *) obj2 name];
        return [first compare:second];
    }]mutableCopy];
}


@end
