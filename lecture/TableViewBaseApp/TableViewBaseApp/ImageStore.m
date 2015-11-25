//
//  ImageStore.m
//  TableViewBaseApp
//
//  Created by Zun Wang on 11/21/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "ImageStore.h"

@implementation ImageStore {
  NSMutableDictionary *_imageDict;
}

+ (instancetype)sharedStore {
  static ImageStore *sharedStore;
  
  if (sharedStore == nil) {
    sharedStore = [[ImageStore alloc] initPriate];
  }
  
  return sharedStore;
}

- (instancetype)init {
  [NSException raise:@"Wrong init"
              format:@"Please use sharedStore!"];
  return nil;
}

- (instancetype)initPriate {
  if (self = [super init]) {
    _imageDict = [[NSMutableDictionary alloc] init];
    
    NSNotificationCenter *nt = [NSNotificationCenter defaultCenter];
    [nt addObserver:self
           selector:@selector(clearCache:)
               name:UIApplicationDidReceiveMemoryWarningNotification
             object:nil];
  }
  return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
  _imageDict[key] = image;
  
  NSString *path = [self imagePathForKey:key];
  NSLog(@"image path is %@", path);
  NSData *data = UIImageJPEGRepresentation(image, 0.5);
  [data writeToFile:path atomically:YES];
}

- (UIImage *)imageForeKey:(NSString *)key {
  UIImage *result = _imageDict[key];
  if (result == nil) {
    NSString *path = [self imagePathForKey:key];
    result = [UIImage imageWithContentsOfFile:path];
    if (result) {
      _imageDict[key] = result;
    } else {
      NSLog(@"image not exists");
    }
  }
  return result;
}

- (void)deleteImageForKey:(NSString *)key {
  [_imageDict removeObjectForKey:key];
  NSString *path = [self imagePathForKey:key];
  [[NSFileManager defaultManager] removeItemAtPath:path
                                             error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key {
  NSArray *documentDirectories =
  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  NSString *documentDirectory = [documentDirectories firstObject];
  return [documentDirectory stringByAppendingPathComponent:key];
}

- (void)clearCache:(NSNotification *)note {
  NSLog(@"Clear %@ images out of cache", @(_imageDict.count));
  [_imageDict removeAllObjects];
}

@end
