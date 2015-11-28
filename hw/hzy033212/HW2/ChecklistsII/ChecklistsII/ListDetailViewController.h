//
//  ListDetailViewController.h
//  ChecklistsII
//
//  Created by Eric Huang on 11/18/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checklist.h"
#import "IconPickerViewController.h"

@protocol ListDetailViewControllerDelegate
-(void)listDetailViewControllerDidCancel;
-(void)listDetailViewControllerAddingChecklist: (Checklist *) checklist;
-(void)listDetailViewControllerEditingChecklist: (Checklist *) checklist;
@end

@interface ListDetailViewController : UITableViewController

@property (assign,nonatomic) id<ListDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) Checklist *checklistToEdit;

@end
