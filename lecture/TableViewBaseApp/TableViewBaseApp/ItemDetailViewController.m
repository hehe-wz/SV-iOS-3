//
//  ItemDetailViewController.m
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/15/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "ItemDetailViewController.h"

#import "Item.h"
#import "ImageStore.h"

@interface ItemDetailViewController () <
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *SerialTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.imageView = [[UIImageView alloc] initWithImage:nil];
  self.imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.imageView];
  
  NSDictionary *nameMap = @{@"imageView" : self.imageView,
                            @"dateLabel" : self.dateLabel,
                            @"toolbar": self.toolbar};
  NSArray *hConstraints =
  [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                          options:0
                                          metrics:nil
                                            views:nameMap];
  NSArray *vConstraints =
  [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-8-[imageView]-8-[toolbar]"
                                          options:0
                                          metrics:nil
                                            views:nameMap];
  NSLayoutConstraint *imageViewRatioConstraint =
  [NSLayoutConstraint constraintWithItem:self.imageView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.imageView
                               attribute:NSLayoutAttributeHeight
                              multiplier:1.5
                                constant:0];
  
  [self.view addConstraints:hConstraints];
  [self.view addConstraints:vConstraints];
  [self.imageView addConstraint:imageViewRatioConstraint];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.nameTextField.text = self.item.itemName;
  self.SerialTextField.text = self.item.serialNumber;
  self.valueTextField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
  
  self.nameTextField.delegate = self;
  self.SerialTextField.delegate = self;
  self.valueTextField.delegate = self;
  
  static NSDateFormatter *dateFormatter;
  if (dateFormatter == nil) {
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
  }
  
  self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
  self.imageView.image = [[ImageStore sharedStore] imageForeKey:self.item.itemKey];
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

#pragma mark - user acton

- (IBAction)userTapCameraButton:(UIBarButtonItem *)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  
  imagePicker.sourceType =
  [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
  ? UIImagePickerControllerSourceTypeCamera
  : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
  
  imagePicker.delegate = self;
  
  [self presentViewController:imagePicker
                     animated:YES
                   completion:nil];
}

- (IBAction)userTapBackground:(UIControl *)sender {
  [self.view endEditing:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  UIImage *image = info[UIImagePickerControllerOriginalImage];
  [[ImageStore sharedStore] setImage:image
                              forKey:self.item.itemKey];
  self.imageView.image = image;
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self.view endEditing:YES];
  return YES;
}

@end
