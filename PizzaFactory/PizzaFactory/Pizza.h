//
//  Pizza.h
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,SizeType){
    SizeTypeSmall,
    SizeTypeMedium,
    SizeTypeLarge
};

NS_ASSUME_NONNULL_BEGIN

@interface Pizza : NSObject

@property (nonatomic,assign) NSInteger number;//编号
@property (nonatomic,assign) SizeType size;//大小
@property (nonatomic,copy) NSMutableArray <NSString *>*toppings;//配料

- (instancetype)initWithNumber:(NSInteger)number;

@end

NS_ASSUME_NONNULL_END
