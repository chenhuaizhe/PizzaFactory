//
//  SQLManager+Data.m
//  PushUps
//
//  Created by ChenYuan's Macbook Air on 2020/1/30.
//  Copyright © 2020 chenyuan. All rights reserved.
//

#import "SQLManager+Data.h"

@implementation SQLManager (Data)
#pragma mark -
#pragma mark - insert
- (BOOL)insertModelToDataDBWith:(NSString *)tableName
                     andColumns:(NSString *)columnStr
                      andValues:(NSString *)valueStr {
    BOOL success = [self insertModelWithDBQueue:self.dataDBQueue andTableName:tableName andColumns:columnStr andValues:valueStr];
    return success;
}


//"CREATE TABLE IF NOT EXISTS Pizza (number INTEGER, chef_name TEXT,toppings TEXT,size INTEGER, date DATE, done INTEGER, PRIMARY KEY(number))"
#pragma mark - Pizza
- (BOOL)insertPizzaData:(Pizza *)pizza withChef:(Chef *)chef{
    NSString *columnString = @"number,chef_name,toppings,size,date,done";
    NSString *valueString = [NSString stringWithFormat:@"%ld, '%@', '%@', %ld,'%@', %ld", pizza.number,chef.name,pizza.toppings,pizza.size,[self dateToString:[NSDate date]],0L];
    NSString *tableName = @"Pizza";
    BOOL success = [self insertModelToDataDBWith:tableName andColumns:columnString andValues:valueString];
    return success;
}

- (void)pizzaDoneWithNumber:(NSInteger)number {
    NSString *tableName = @"Pizza";
    [self.dataDBQueue inDatabase:^(FMDatabase *db) {
        NSString *ssql = [NSString stringWithFormat:@"UPDATE %@ SET done = 1 where number = %ld",tableName, number];
        [db executeUpdate:ssql];
    }];
}


//查找某个厨师所有未完成的Pizza
- (NSMutableArray <Pizza *> *)selectAllUnDoPizzaOfChef:(Chef *)chef; {
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
    __block NSMutableArray *__safe_array = mArr;
    __block NSString *ssql = [NSString stringWithFormat:@"SELECT * FROM Pizza where chef_name = '%@' and done = 0 ORDER BY number",chef.name];
    [self.dataDBQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:ssql];
        [db setDateFormat:[self dbDateFormatter:DATE_TYPE_DATESTAMP]];
        while (rs.next) {
            NSInteger number = [rs intForColumn:@"number"];
            NSInteger size = [rs intForColumn:@"size"];
            NSString *toppings = [rs stringForColumn:@"toppings"];
            Pizza *pizza = [[Pizza alloc]initWithNumber:number];
            pizza.size = size;
            NSArray *toppingsArr = [toppings componentsSeparatedByString:@","];
            pizza.toppings = [[NSMutableArray alloc]initWithArray:toppingsArr];
            [__safe_array addObject:pizza];
        }
        [rs close];
    }];
    return mArr;

}



@end
