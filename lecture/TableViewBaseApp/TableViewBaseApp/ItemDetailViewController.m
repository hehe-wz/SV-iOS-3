//
//  ItemDetailViewController.m
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/15/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "ItemDetailViewController.h"

#import "Item.h"

@interface ItemDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *SerialTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation ItemDetailViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.nameTextField.text = self.item.itemName;
  self.SerialTextField.text = self.item.serialNumber;
  self.valueTextField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
  
  static NSDateFormatter *dateFormatter;
  if (dateFormatter == nil) {
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
  }
  
  self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  [self.view endEditing:YES];
  
  self.item.itemName = self.nameTextField.text;
  self.item.serialNumber = self.SerialTextField.text;
  self.item.valueInDollars = [self.valueTextField.text intValue];
}

- (void)setItem:(Item *)item {
  _item = item;
  
  self.navigationItem.title = self.item.itemName;
}

@end
