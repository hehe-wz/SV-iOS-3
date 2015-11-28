//
//  ListDetailViewController.m
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/23/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import "ListDetailViewController.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

#pragma mark - initialize

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _delegate = nil;
        _checklistToEdit = nil;
        _iconName = @"Folder";
    }
    return self;
}

#pragma mark - view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44;
    
    Checklist *checklist = _checklistToEdit;
    if (checklist != nil) {
        self.title = @"Edit Checklist";
        _textField.text = checklist.name;
        _doneBarButton.enabled = true;
        _iconName = checklist.iconName;
    }
    _iconImageView.image = [UIImage imageNamed:_iconName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_textField becomeFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"PickIcon"]) {
        IconPickerViewController *controller = (IconPickerViewController *) segue.destinationViewController;
        controller.delegate = self;
    }
}

#pragma mark - IBAction

- (IBAction)cancel {
    [_delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done {
    Checklist *checklist = _checklistToEdit;
    
    if (checklist != nil) {
        checklist.name = _textField.text;
        checklist.iconName = _iconName;
        [_delegate listDetailViewController:self didFinishEditingChecklist:checklist];
    } else {
        Checklist *checklist = [[Checklist alloc] initWithName:_textField.text iconName:_iconName];
        
        NSLog(@"Checklist.name = %@", checklist.name);
        if (checklist == nil) {
            NSLog(@"Checklist is still empty after initwithNAme");
        }
        
        [_delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    }
}

#pragma mark - IconPicker Delegate

- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName {
    _iconName = iconName;
    
    _iconImageView.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return indexPath;
    } else {
        return nil;
    }
}

#pragma mark - TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *oldText = _textField.text;
    NSString *newText = [oldText stringByReplacingCharactersInRange:range withString:string];
    
    _doneBarButton.enabled = (newText.length > 0);
    return YES;
}

@end
