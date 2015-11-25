//
//  ItemsViewController.m
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/14/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "ItemsViewController.h"

#import "ItemStore.h"
#import "ItemDetailViewController.h"

@interface ItemsViewController ()
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@end

@implementation ItemsViewController {
}

- (instancetype)init {
  if (self = [super initWithStyle:UITableViewStylePlain]) {
//    for (int i = 0; i < 5; i++) {
//      [[ItemStore sharedStore] createItem];
//    }
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"Item List";
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *rightButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(addItem)];
    self.navigationItem.rightBarButtonItem = rightButton;
  }
  return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:@"ItemsViewControllerCell"];
  
//  self.tableView.tableHeaderView = self.headerView;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self.tableView reloadData];
}

- (UIView *)headerView {
  if (_headerView == nil) {
    [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                  owner:self
                                options:nil];
  }
  return _headerView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [ItemStore sharedStore].allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemsViewControllerCell"];
  //cell.title = ....
  cell.textLabel.text = [[ItemStore sharedStore].allItems[indexPath.row] description];
  return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [[ItemStore sharedStore] removeItemAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationRight];
  }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
  [[ItemStore sharedStore] moveItemFromIndex:sourceIndexPath.row
                                     toIndex:destinationIndexPath.row];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ItemDetailViewController *detailVC = [[ItemDetailViewController alloc] init];
  detailVC.item = [ItemStore sharedStore].allItems[indexPath.row];
  
  [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - User Action

- (IBAction)userTapEditButton:(UIButton *)sender {
  if (self.editing) {
    [sender setTitle:@"Edit" forState:UIControlStateNormal];
    [self setEditing:NO animated:YES];
    self.addButton.enabled = YES;
  } else {
    [sender setTitle:@"Done" forState:UIControlStateNormal];
    [self setEditing:YES animated:YES];
    self.addButton.enabled = NO;
  }
}

- (IBAction)userTapAddButton:(UIButton *)sender {
  [self addItem];
}

- (void)addItem {
  [[ItemStore sharedStore] createItem];
  NSInteger row = [ItemStore sharedStore].allItems.count - 1;
  [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]]
                        withRowAnimation:UITableViewRowAnimationLeft];
}

@end
