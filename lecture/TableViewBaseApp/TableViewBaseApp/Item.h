#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding>

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

@property (nonatomic, copy) NSString *itemKey;

@end
