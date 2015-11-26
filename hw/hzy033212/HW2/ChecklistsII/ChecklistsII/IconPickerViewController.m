//
//  IconPickerViewController.m
//  ChecklistsII
//
//  Created by Eric Huang on 11/20/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController

#pragma mark - view load functions

- (void)viewDidLoad {
    [super viewDidLoad];
    self.icons = @[ @"No Icon",@"Appointments",@"Birthdays",@"Chores",@"Drinks",@"Folder",@"Groceries",@"Inbox",@"Photos", @"Trips"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.icons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
 
    NSString *iconName = self.icons[indexPath.row];
    cell.textLabel.text = iconName;
    cell.imageView.image = [UIImage imageNamed:iconName];
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *iconName = self.icons[indexPath.row];
  [self.delegate didPickIcon:iconName];
}

@end
