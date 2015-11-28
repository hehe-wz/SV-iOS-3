//
//  AllListsViewController.m
//  ChecklistsII
//
//  Created by Eric Huang on 11/18/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"
#import "ListDetailViewController.h"
#import "DataModel.h"

@interface AllListsViewController () <ListDetailViewControllerDelegate, UINavigationControllerDelegate>
- (IBAction)allRefresh:(UIRefreshControl *)sender;

@end

@implementation AllListsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.dataModel sortChecklists];
  [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.navigationController.delegate = self;
  NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
  if (index != -1) {
    Checklist *checklist = self.dataModel.lists[index];
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
  }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
  
  cell.textLabel.text = [NSString stringWithFormat:@"List %d", indexPath.row];
  Checklist *checklist = self.dataModel.lists[indexPath.row];
  cell.textLabel.text = checklist.name;
  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
  
  NSInteger count = [checklist countUncheckedItems];
  if ([checklist.items count] == 0) {
    cell.detailTextLabel.text = @"(No Items)";
  } else if (count == 0) {
    cell.detailTextLabel.text = @"All Done!";
  } else {
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaining", [checklist countUncheckedItems]];
  }
  
  cell.imageView.image = [UIImage imageNamed:checklist.iconName];
  
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"ChecklistIndex"];
  Checklist *checklist = self.dataModel.lists[indexPath.row];
  [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

#pragma mark - prepare for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier  isEqual: @"ShowChecklist"]) {
    ChecklistViewController *controller = [segue destinationViewController];
    controller.checklist = (Checklist *)sender;
  } else if ([segue.identifier isEqual:@"AddChecklist"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    controller.checklistToEdit = nil;
  }
}

#pragma mark - protocol methods for ItemDetailViewControllerDelegate

-(void)listDetailViewControllerDidCancel {
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)listDetailViewControllerAddingChecklist: (Checklist *)checklist {
  // The following lines are very important!!!
  if (self.dataModel == nil) {
    self.dataModel = [[DataModel alloc] init];
  }
  if (self.dataModel.lists == nil) {
    self.dataModel.lists = [[NSMutableArray alloc] init];
  }
  NSInteger newRowIndex = [self.dataModel.lists count];
  [self.dataModel.lists addObject:checklist];
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
  NSArray *indexPaths = @[indexPath];
  [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)listDetailViewControllerEditingChecklist: (Checklist *)checklist {

  NSInteger index = [self.dataModel.lists indexOfObject:checklist];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  cell.textLabel.text = checklist.name;
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"Remove a new item -> %d .", indexPath.row);
  [self.dataModel.lists removeObjectAtIndex:indexPath.row];
  NSArray *indexPaths = @[indexPath];
  [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
  ListDetailViewController *controller = (ListDetailViewController *)[navigationController topViewController];
  controller.delegate = self;
  
  Checklist *checklist = self.dataModel.lists[indexPath.row];
  controller.checklistToEdit = checklist;
  [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
  if (viewController == self) {
    [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"ChecklistIndex"];
  }
}

- (IBAction)allRefresh:(UIRefreshControl *)sender {
  [self.tableView reloadData];
  [sender endRefreshing];
}
@end
