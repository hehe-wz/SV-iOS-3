//
//  ItemDetailViewController.m
//  ChecklistsII
//
//  Created by Eric Huang on 11/17/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) IBOutlet UISwitch *shouldReminderSwitch;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (nonatomic) bool datePickerVisible;
@property (nonatomic) NSDate *dueDate;

@end

@implementation ItemDetailViewController

#pragma mark - cancel and done button methods

-(IBAction)cancel {
  [self.delegate ItemDetailViewControllerDidCancel];
}

-(IBAction)done {
  NSLog(@"Content of the text field -> %@", self.textField.text);
  if (self.itemToEdit != nil) {
    ChecklistItem *item = self.itemToEdit;
    item.text = _textField.text;
    item.shouldRemind = self.shouldReminderSwitch.on;
    item.dueDate = self.dueDate;
    [item scheduleNotification];
    [self.delegate ItemDetailViewControllerEditingItem:item];
  } else {
    ChecklistItem *item = [[ChecklistItem alloc] init];
    item.text = _textField.text;
    item.shouldRemind = self.shouldReminderSwitch.on;
    item.dueDate = self.dueDate;
    item.checked = NO;
    [item scheduleNotification];
    [self.delegate ItemDetailViewControllerAddingItem:item];
  }
}

-(IBAction)shouldRemindToggled: (UISwitch *) switchControl{
  [self.textField resignFirstResponder];
  if (switchControl.on) {
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
  }
}

#pragma mark - view related methods

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.textField becomeFirstResponder];
  self.datePickerVisible = NO;
  if (self.dueDate == nil) {
    self.dueDate = [[NSDate alloc] init];
  }
}

-(void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.rowHeight = 44;
  ChecklistItem *item = self.itemToEdit;
  if (item != nil) {
    self.title = @"Edit item";
    self.textField.text = item.text;
    self.doneBarButton.enabled = YES;
    self.shouldReminderSwitch.on = item.shouldRemind;
    self.dueDate = item.dueDate;
  }
  [self updateDueDateLabel];
}

#pragma mark - tableView related methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 1) {
    return indexPath;
  } else {
    return nil;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 2) {
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
    if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DatePickerCell"];
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
      UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame: CGRectMake(0, 0, 320, 216)];
      datePicker.tag = 100;
      [cell.contentView addSubview:datePicker];
      [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return cell;
  } else {
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
  }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 1 && self.datePickerVisible) {
    return 3;
  } else {
    return [super tableView:tableView numberOfRowsInSection:section];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 2) {
    return 217;
  } else {
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self.textField resignFirstResponder];
  if (indexPath.section == 1 && indexPath.row == 1) {
    if (self.datePickerVisible) {
      [self hideDatePicker];
    } else {
      [self showDatePicker];
    }
  }
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 2) {
    indexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
  }
  return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  NSString *oldtext = textField.text;
  NSString *newtext = [oldtext stringByReplacingCharactersInRange:range withString:string];
  if ([newtext length] > 0) {
    _doneBarButton.enabled = YES;
  } else {
    _doneBarButton.enabled = NO;
  }
  return YES;
}

-(void)updateDueDateLabel {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateStyle = NSDateFormatterMediumStyle;
  formatter.timeStyle = NSDateFormatterShortStyle;
  self.dueDateLabel.text = [formatter stringFromDate:self.dueDate];
}

-(void)dateChanged: (UIDatePicker *) datePicker {
  self.dueDate = datePicker.date;
  [self updateDueDateLabel];
}

-(void)showDatePicker {
  self.datePickerVisible = YES;
  NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
  NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
  UITableViewCell *dateCell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
  dateCell.detailTextLabel.textColor = dateCell.detailTextLabel.tintColor;
  [self.tableView beginUpdates];
  [self.tableView insertRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
  [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
  [self.tableView endUpdates];
  
  UITableViewCell *pickCell = [self.tableView cellForRowAtIndexPath:indexPathDatePicker];
  UIDatePicker *datePicker = (UIDatePicker *)[pickCell viewWithTag:100];
  [datePicker setDate:self.dueDate animated:NO];
}

-(void)hideDatePicker {
  if (self.datePickerVisible) {
    self.datePickerVisible = NO;
    NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
    UITableViewCell *dateCell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
    dateCell.detailTextLabel.textColor = [[UIColor alloc] initWithWhite:0 alpha:0.5];
    
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView deleteRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
  }
}

-(void)textFieldDidBeginEditing {
  [self hideDatePicker];
}

@end
