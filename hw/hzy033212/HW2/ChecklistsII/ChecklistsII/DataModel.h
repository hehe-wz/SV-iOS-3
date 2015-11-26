//
//  DataModel.h
//  ChecklistsII
//
//  Created by Eric Huang on 11/19/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Checklist.h"

@interface DataModel : NSObject
@property (nonatomic) NSMutableArray<Checklist *> *lists;
-(NSString *)documentsDirectory;
-(NSString *)dataFilePath;
-(void)saveChecklists;
-(void)loadChecklists;
-(void)sortChecklists;
+(NSInteger)nextChecklistItemID;
@end
