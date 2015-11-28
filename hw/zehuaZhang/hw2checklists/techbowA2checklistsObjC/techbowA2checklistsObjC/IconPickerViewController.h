//
//  IconPickerViewController.h
//  techbowA2checklistsObjC
//
//  Created by ZhangZehua on 11/23/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>

- (void) iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName;

@end


@interface IconPickerViewController : UITableViewController

@property (nonatomic, weak) id <IconPickerViewControllerDelegate> delegate;

@property (nonatomic) NSArray<NSString *> *icons;

@end
