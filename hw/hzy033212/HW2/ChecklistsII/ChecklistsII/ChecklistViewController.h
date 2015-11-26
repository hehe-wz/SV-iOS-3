//
//  ViewController.h
//  ChecklistsII
//
//  Created by Eric Huang on 11/16/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"
#import "ItemDetailViewController.h"
#import "Checklist.h"

@interface ChecklistViewController : UITableViewController <ItemDetailViewControllerDelegate>
@property (nonatomic) Checklist *checklist;
-(void)configureCheckmarkForCell: (UITableViewCell *) cell withChecklistItem: (ChecklistItem *) item;
-(void)configureTextForCell: (UITableViewCell *) cell withChecklistItem: (ChecklistItem *) item;
@end

