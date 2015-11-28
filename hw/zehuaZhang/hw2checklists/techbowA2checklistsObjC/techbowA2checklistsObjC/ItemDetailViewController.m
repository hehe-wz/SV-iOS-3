//
//  ItemDetailViewController.m
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/22/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

#pragma mark - init

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _delegate = nil;
        _itemToEdit = nil;
        _dueDate = [[NSDate alloc] init];
        _dataPickerVisible = NO;
    }
    return self;
}

#pragma mark - view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44;
    ChecklistItem *item = _itemToEdit;
    
    if (item != nil) {
        self.title = @"Edit Item";
        _textField.text = item.text;
        _doneButton.enabled = YES;
        _shouldRemindSwitch.on = item.shouldRemind;
        _dueDate = item.dueDate;
    }
    [self updateDueDateLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_textField becomeFirstResponder];
}

#pragma mark - IBAction

- (IBAction) shouldRemindToggled:(UISwitch *)sender {
    [_textField resignFirstResponder];
    
    if (sender.on) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil]];
    }
}

- (IBAction) cancelButton:(UIBarButtonItem *)sender {
    [_delegate itemDetailViewControllerDidCancel:self];
}

- (IBAction)doneButton:(id)sender {
    ChecklistItem *item = _itemToEdit;
    
    if (item != nil) {
        item.text = _textField.text;
        item.shouldRemind = _shouldRemindSwitch.on;
        item.dueDate = _dueDate;
        [item scheduleNotification];
        
        [_delegate itemDetailViewController:self didFinishEditingItem:item];
    } else {
        ChecklistItem *item = [[ChecklistItem alloc] init];
        item.text = _textField.text;
        item.checked = NO;
        item.shouldRemind = _shouldRemindSwitch.on;
        item.dueDate = _dueDate;
        [item scheduleNotification];
        
        [_delegate itemDetailViewController:self didFinishAddingItem:item];
    }
}

#pragma mark - Other

- (void) updateDueDateLabel {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    _dueDateLabel.text = [formatter stringFromDate:_dueDate];
}

- (void) dateChanged:(UIDatePicker *)datePicker {
    _dueDate = datePicker.date;
    [self updateDueDateLabel];
}

#pragma mark - DatePicker

- (void) showDatePicker {
    _dataPickerVisible = true;
    
    NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
    
    UITableViewCell *dateCell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
    if (dateCell != nil) {
        dateCell.detailTextLabel.textColor = dateCell.detailTextLabel.tintColor;
    }
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
    UITableViewCell *pickerCell = [self.tableView cellForRowAtIndexPath:indexPathDatePicker];
    if (pickerCell != nil) {
        UIDatePicker *datePicker = (UIDatePicker *)[pickerCell viewWithTag:100];
        [datePicker setDate:_dueDate animated:NO];
    }
}

- (void) hideDatePicker {
    if (_dataPickerVisible) {
        _dataPickerVisible = NO;
        
        NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
        NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
        
        UITableViewCell *dateCell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
        if (dateCell != nil) {
            dateCell.detailTextLabel.textColor = [UIColor colorWithWhite:0 alpha:0.5];
        }
        
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView deleteRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

#pragma mark - TextField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self hideDatePicker];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *oldText = _textField.text;
    NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:string];
    
    _doneButton.enabled = (newText.length > 0);
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1 && _dataPickerVisible) {
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

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 2) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DatePickerCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
            datePicker.tag = 100;
            [cell.contentView addSubview:datePicker];
            
            [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        }
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [_textField resignFirstResponder];
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        if (!_dataPickerVisible) {
            [self showDatePicker];
        } else {
            [self hideDatePicker];
        }
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1) {
        return indexPath;
    } else {
        return nil;
    }
}

@end
