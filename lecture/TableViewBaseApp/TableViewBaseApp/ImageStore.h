//
//  ImageStore.h
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/21/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForeKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
