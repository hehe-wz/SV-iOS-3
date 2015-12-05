//
//  Item.h
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/28/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

@end

NS_ASSUME_NONNULL_END

#import "Item+CoreDataProperties.h"
