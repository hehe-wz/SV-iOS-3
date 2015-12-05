//
//  Item+CoreDataProperties.h
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/28/15.
//  Copyright © 2015 ZW. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

@property (nonatomic, strong) NSDate *dateCreated;
@property (nullable, nonatomic, retain) NSString *itemKey;
@property (nullable, nonatomic, retain) NSString *itemName;
@property (nullable, nonatomic, retain) NSString *serialNumber;
@property (nullable, nonatomic, retain) NSManagedObject *assetType;
@property (nonatomic) double orderingValue;
@property (nonatomic) int32_t valueInDollars;

@end

NS_ASSUME_NONNULL_END
