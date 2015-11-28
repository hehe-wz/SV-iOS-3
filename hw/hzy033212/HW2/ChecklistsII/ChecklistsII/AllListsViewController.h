//
//  AllListsViewController.h
//  ChecklistsII
//
//  Created by Eric Huang on 11/18/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checklist.h"
#import "ListDetailViewController.h"
#import "DataModel.h"

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate>
@property (nonatomic) DataModel *dataModel;
@end
