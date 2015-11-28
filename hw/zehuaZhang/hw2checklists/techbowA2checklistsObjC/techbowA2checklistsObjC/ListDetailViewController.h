//
//  ListDetailViewController.h
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/23/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checklist.h"
#import "IconPickerViewController.h"

@class ListDetailViewController;

@protocol ListDetailViewControllerDelegate <NSObject>

- (void) listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
- (void) listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *) checklist;
- (void) listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *) checklist;

@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>

@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *iconImageView;

@property (nonatomic) Checklist* checklistToEdit;
@property (nonatomic) NSString* iconName;

@end
