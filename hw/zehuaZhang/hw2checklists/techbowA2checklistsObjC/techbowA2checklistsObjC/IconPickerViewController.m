//
//  IconPickerViewController.m
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/23/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController

#pragma mark - initialize

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _icons = @[@"No Icon",
                  @"Appointments",
                  @"Birthdays",
                  @"Chores",
                  @"Drinks",
                  @"Folder",
                  @"Groceries",
                  @"Inbox",
                  @"Photos",
                  @"Trips" ];
        _delegate = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _icons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
    NSString *iconName = _icons[indexPath.row];
    
    cell.textLabel.text = iconName;
    cell.imageView.image = [UIImage imageNamed:iconName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate != nil) {
        NSString *iconName = _icons[indexPath.row];
        [_delegate iconPicker:self didPickIcon:iconName];
    }
}

@end
