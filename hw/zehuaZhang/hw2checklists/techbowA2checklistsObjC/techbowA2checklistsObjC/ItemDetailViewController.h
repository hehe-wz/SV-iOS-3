//
//  ItemDetailViewController.h
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/22/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"

@class ItemDetailViewController;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void) itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void) itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;
- (void) itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;

@end

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <ItemDetailViewControllerDelegate> delegate;

@property (nonatomic) ChecklistItem* itemToEdit;
@property (nonatomic) NSDate* dueDate;
@property (nonatomic) BOOL dataPickerVisible;

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UISwitch *shouldRemindSwitch;
@property (nonatomic, weak) IBOutlet UILabel *dueDateLabel;

@end





