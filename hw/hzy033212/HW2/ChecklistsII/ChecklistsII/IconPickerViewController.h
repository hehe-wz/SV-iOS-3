//
//  IconPickerViewController.h
//  ChecklistsII
//
//  Created by Eric Huang on 11/20/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IconPickerViewControllerDelegate
-(void)didPickIcon: (NSString *) iconName;
@end

@interface IconPickerViewController : UITableViewController
@property (weak,nonatomic) id<IconPickerViewControllerDelegate> delegate;
@property (nonatomic) NSArray *icons;
@end
