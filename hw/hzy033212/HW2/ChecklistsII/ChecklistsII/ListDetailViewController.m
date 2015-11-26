//
//  ListDetailViewController.m
//  ChecklistsII
//
//  Created by Eric Huang on 11/18/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"
#import "IconPickerViewController.h"

@interface ListDetailViewController () <UITextFieldDelegate, IconPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic) NSString *iconName;

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.rowHeight = 44;
  Checklist *checklist = self.checklistToEdit;
  if (checklist != nil) {
    self.title = @"Edit Checklist";
    self.textField.text = checklist.name;
    self.doneBarButton.enabled = YES;
    self.iconName = checklist.iconName;
  }
  
  self.iconImageView.image = [UIImage imageNamed:self.iconName];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.textField becomeFirstResponder];
}

-(IBAction)cancel {
  [self.delegate listDetailViewControllerDidCancel];
}

-(IBAction)done {
  NSLog(@"Content of the list detail text field -> %@", self.textField.text);
  if (self.checklistToEdit != nil) {
    Checklist *checklist = self.checklistToEdit;
    checklist.name = self.textField.text;
    checklist.iconName = self.iconName;
    [self.delegate listDetailViewControllerEditingChecklist:checklist];
  } else {
    Checklist *checklist = [[Checklist alloc] init:self.textField.text withIconName:self.iconName];
    [self.delegate listDetailViewControllerAddingChecklist:checklist];
  }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1) {
    return indexPath;
  } else {
    return nil;
  }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  NSString *oldtext = textField.text;
  NSString *newtext = [oldtext stringByReplacingCharactersInRange:range withString:string];
  if ([newtext length] > 0) {
    self.doneBarButton.enabled = YES;
  } else {
    self.doneBarButton.enabled = NO;
  }
  return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier  isEqual: @"PickIcon"]) {
    IconPickerViewController *controller = (IconPickerViewController *)segue.destinationViewController;
    controller.delegate = self;
  }
}

-(void)didPickIcon: (NSString *) iconName {
  self.iconName = iconName;
  self.iconImageView.image = [UIImage imageNamed:iconName];
  [self.navigationController popViewControllerAnimated:YES];
}

@end
