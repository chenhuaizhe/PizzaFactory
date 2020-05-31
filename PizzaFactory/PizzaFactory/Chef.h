//
//  Chef.h
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Pizza;

NS_ASSUME_NONNULL_BEGIN

@interface Chef : NSObject
@property (nonatomic,copy) NSString *name;//厨师名称
@property (nonatomic,copy) NSString *iconName;//厨师头像
@property (nonatomic,assign) NSInteger speed;//秒
@property (nonatomic,strong) NSMutableArray<Pizza *> *remainPizza;//等待生产的披萨

- (instancetype)initWithName:(NSString *)name iconName:(NSString *)iconName speed:(NSInteger)speed remainPizza:(NSMutableArray<Pizza *> *)remainPizza;

@end

NS_ASSUME_NONNULL_END
