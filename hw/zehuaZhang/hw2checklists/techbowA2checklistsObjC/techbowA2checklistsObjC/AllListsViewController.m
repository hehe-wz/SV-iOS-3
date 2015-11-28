//
//  AllListsViewController.m
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/23/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import "AllListsViewController.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController

#pragma mark - initialize

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dataModel = nil;
    }
    return self;
}

#pragma mark - view

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    NSInteger index = _dataModel.indexOfSelectedChecklist;
    
    if (index >= 0 && index < _dataModel.lists.count) {
        Checklist *checklist = _dataModel.lists[index];
        [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"ShowChecklist"]) {
        ChecklistViewController *controller = (ChecklistViewController *) segue.destinationViewController;
        controller.checklist = (Checklist *)sender;
    } else if ([segue.identifier isEqual:@"AddChecklist"]) {
        UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        
        controller.delegate = self;
        controller.checklistToEdit = nil;
    }
}

#pragma mark - NavigationController Delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self) {
        _dataModel.indexOfSelectedChecklist = -1;
    }
}

#pragma mark - ListDetailViewController Delegate

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist {
    NSLog(@"Before Adding checklist.name = %@", checklist.name);
    
    [_dataModel.lists addObject:checklist];
    
    NSLog(@"After Adding Checklists.count = %d", _dataModel.lists.count);
    
    [_dataModel sortChecklists];
    
    if (_dataModel == nil) {
        NSLog(@"Datamodel is still nil!");
    }
    NSLog(@"ListNAme = %@", _dataModel.lists[0].name);
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist {
    [_dataModel sortChecklists];
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataModel.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Checklist *checklist = _dataModel.lists[indexPath.row];
    cell.textLabel.text = checklist.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    NSInteger count = [checklist countUncheckedItems];

    if (checklist.items.count == 0) {
        cell.detailTextLabel.text = @"No Items";
    } else if (count == 0) {
        cell.detailTextLabel.text = @"All Done!";
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld Remaining", (long)count];
    }
    
    cell.imageView.image = [UIImage imageNamed:checklist.iconName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _dataModel.indexOfSelectedChecklist = indexPath.row;
    
    Checklist *checklist = _dataModel.lists[indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_dataModel.lists removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

    UINavigationController *navigationController = (UINavigationController *) [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    ListDetailViewController *controller = (ListDetailViewController *) navigationController.topViewController;
    
    controller.delegate = self;
    
    Checklist *checklist = _dataModel.lists[indexPath.row];
    controller.checklistToEdit = checklist;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
