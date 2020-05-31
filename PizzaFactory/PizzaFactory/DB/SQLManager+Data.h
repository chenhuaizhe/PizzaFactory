//
//  SQLManager+Data.h
//  PushUps
//
//  Created by ChenYuan's Macbook Air on 2020/1/30.
//  Copyright © 2020 chenyuan. All rights reserved.
//


#import "SQLManager.h"
#import "Pizza.h"
#import "Chef.h"


NS_ASSUME_NONNULL_BEGIN

@interface SQLManager (Data)


#pragma mark - 俯卧撑数量

//Piza 入表
- (BOOL)insertPizzaData:(Pizza *)pizza withChef:(Chef *)chef;

//完成某个pizza
- (void)pizzaDoneWithNumber:(NSInteger)number;

//查找某个厨师所有未完成的Pizza
- (NSMutableArray <Pizza *> *)selectAllUnDoPizzaOfChef:(Chef *)chef;
@end

NS_ASSUME_NONNULL_END
