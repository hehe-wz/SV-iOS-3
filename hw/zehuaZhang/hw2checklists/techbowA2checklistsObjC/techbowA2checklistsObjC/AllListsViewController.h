//
//  AllListsViewController.h
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/23/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "ListDetailViewController.h"
#import "ChecklistViewController.h"
#import "ListDetailViewController.h"

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) DataModel *dataModel;

@end
