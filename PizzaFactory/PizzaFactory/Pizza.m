//
//  Pizza.m
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import "Pizza.h"

@implementation Pizza

- (instancetype)initWithNumber:(NSInteger)number;
{
    if (self = [super init]) {
        _number = number;
    }
    return self;
}
@end
