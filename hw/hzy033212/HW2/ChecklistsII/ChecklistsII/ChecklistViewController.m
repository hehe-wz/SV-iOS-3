//
//  ViewController.m
//  ChecklistsII
//
//  Created by Eric Huang on 11/16/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistItem.h"
#import "ItemDetailViewController.h"
#import "Checklist.h"

@interface ChecklistViewController () <ItemDetailViewControllerDelegate>
- (IBAction)refresh:(UIRefreshControl *)sender;

@end

@implementation ChecklistViewController

-(void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.rowHeight = 44;
  self.title = self.checklist.name;
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.checklist sortSingleChecklist];
  [self.tableView reloadData];
}

#pragma mark - tableView protocol required methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return [self.checklist.items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
  ChecklistItem *item = self.checklist.items[indexPath.row];
  [self configureTextForCell:cell withChecklistItem:item];
  [self configureCheckmarkForCell:cell withChecklistItem:item];
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  ChecklistItem *item = self.checklist.items[indexPath.row];
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  [item toggleChecked];
  [self configureCheckmarkForCell:cell withChecklistItem:item];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"Remove a new item -> %d .", indexPath.row);
  [self.checklist.items removeObjectAtIndex:indexPath.row];
  NSArray *indexPaths = @[indexPath];
  [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - congifure for text and checkmark for cell

-(void)configureCheckmarkForCell: (UITableViewCell *) cell withChecklistItem: (ChecklistItem *) item {
  
  UILabel *label = [cell viewWithTag:1001];
  if (item.checked) {
    label.text = @"√";
  } else {
    label.text = @"";
  }
  label.textColor = self.view.tintColor;
}

-(void)configureTextForCell: (UITableViewCell *) cell withChecklistItem: (ChecklistItem *) item {
  
  UILabel *label = [cell viewWithTag:1000];
  label.text = [NSString stringWithFormat:@"%d : %@", item.itemID, item.text];
}

#pragma mark - protocol methods for ItemDetailViewControllerDelegate

-(void)ItemDetailViewControllerDidCancel {
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ItemDetailViewControllerAddingItem: (ChecklistItem *) item {
  if (self.checklist.items == nil) {
    self.checklist.items = [[NSMutableArray alloc] init];
  }
  NSInteger newRowIndex = [self.checklist.items count];
  [self.checklist.items addObject:item];
  NSLog(@"%@", self.checklist.items);
  NSLog(@"%@", item);
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
  NSArray *indexPaths = @[indexPath];
  [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ItemDetailViewControllerEditingItem:(ChecklistItem *)item {
  NSInteger index = [self.checklist.items indexOfObject:item];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  [self configureTextForCell:cell withChecklistItem:item];
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - prepare for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier  isEqual: @"AddItem"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
  } else if ([segue.identifier isEqual: @"EditItem"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
    controller.itemToEdit = self.checklist.items[indexPath.row];
  }
}

- (IBAction)refresh:(UIRefreshControl *)sender {
  NSLog(@"Begin to refresh!");
  [self.tableView reloadData];
  [sender endRefreshing];
}

@end
