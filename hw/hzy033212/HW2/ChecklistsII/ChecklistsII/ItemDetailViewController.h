//
//  ItemDetailViewController.h
//  ChecklistsII
//
//  Created by Eric Huang on 11/17/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"

@protocol ItemDetailViewControllerDelegate
-(void)ItemDetailViewControllerDidCancel;
-(void)ItemDetailViewControllerAddingItem: (ChecklistItem *) item;
-(void)ItemDetailViewControllerEditingItem: (ChecklistItem *) item;
@end

@interface ItemDetailViewController : UITableViewController

@property (assign,nonatomic) id<ItemDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) ChecklistItem *itemToEdit;

@end
