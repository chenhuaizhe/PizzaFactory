//
//  MainViewModel.h
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Chef;

NS_ASSUME_NONNULL_BEGIN

@interface MainViewModel : NSObject

@property (nonatomic, strong) Chef *chef0;
@property (nonatomic, strong) Chef *chef1;
@property (nonatomic, strong) Chef *chef2;
@property (nonatomic, strong) Chef *chef3;
@property (nonatomic, strong) Chef *chef4;
@property (nonatomic, strong) Chef *chef5;
@property (nonatomic, strong) Chef *chef6;

@property (nonatomic, strong) NSString *remindingPizzaSummary;

- (instancetype)initWithRemainingPizza:(NSInteger)pizzaCount;

- (instancetype)initFromLocal;

#pragma mark - view 触发的操作

- (void)chefSwitchActionWithName:(NSString *)name isOn:(BOOL)isOn;
- (void)stopAllPizzaQueue;
- (void)startAllPizzaQueue;
- (void)addMorePizza:(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
