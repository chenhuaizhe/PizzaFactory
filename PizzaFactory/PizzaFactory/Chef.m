//
//  Chef.m
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import "Chef.h"
#import "Pizza.h"

@implementation Chef

- (instancetype)initWithName:(NSString *)name iconName:(NSString *)iconName speed:(NSInteger)speed remainPizza:(NSMutableArray<Pizza *> *)remainPizza; {
    if (self = [super init]) {
        _name = name;
        _iconName = iconName;
        _speed = speed;
        _remainPizza = remainPizza;
    }
    return self;
}

@end
