//
//  DataModel.h
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/21/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Checklist.h"

@interface DataModel : NSObject

@property (nonatomic) NSMutableArray <Checklist *> *lists;
@property (nonatomic) NSInteger indexOfSelectedChecklist;

- (NSInteger) indexOfSelectedChecklist;
- (void) setIndexOfSelectedChecklist:(NSInteger)indexOfSelectedChecklist;

- (NSString *) documentsDirectory;
- (NSString *) dataFilePath;
- (void) saveChecklists;
- (void) loadChecklists;
- (void) registerDefaults;
- (void) handleFirstTime;
+ (NSInteger) nextChecklistItemID;

- (void) sortChecklists;

@end
