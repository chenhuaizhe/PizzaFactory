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

////某个日期之后的所有的俯卧撑记录
//- (NSArray <PushUpNumberModel *> *)selectPushUpNumberDataAfterDate:(NSDate *)startDate {
//    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
//    __block NSMutableArray *__safe_array = mArr;
//    __block NSString *ssql = [NSString stringWithFormat:@"SELECT * FROM pushups_number_data where date >= '%@' ORDER BY date ",[self dateToString:startDate]];
//    [self.dataDBQueue inDatabase:^(FMDatabase *db) {
//        FMResultSet *rs = [db executeQuery:ssql];
//        [db setDateFormat:[self dbDateFormatter:DATE_TYPE_DATESTAMP]];
//        while (rs.next) {
//            PushUpNumberModel *sModel = [[PushUpNumberModel alloc] init];
//            sModel.uid = [rs intForColumn:@"uid"];
//             sModel.data_from = [rs stringForColumn:@"data_from"];
//            sModel.date = [rs dateForColumn:@"date"];
//            sModel.count = [rs intForColumn:@"count"];
//           sModel.calorie = [rs doubleForColumn:@"calorie"];
//            [__safe_array addObject:sModel];
//        }
//        [rs close];
//    }];
//    return mArr;
//}
//
////查找某一天之后所有有数据的日期数组
//- (NSArray <NSDate *> *)selectAllDateWhichHaveDataAfterDate:(NSDate *)startDate;{
//    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
//    __block NSMutableArray *__safe_array = mArr;
//    __block NSString *ssql = [NSString stringWithFormat:@"SELECT date FROM pushups_number_data where date >= '%@' ORDER BY date",[self dateToString:startDate]];
//    [self.dataDBQueue inDatabase:^(FMDatabase *db) {
//        FMResultSet *rs = [db executeQuery:ssql];
//        [db setDateFormat:[self dbDateFormatter:DATE_TYPE_DATESTAMP]];
//        while (rs.next) {
//             NSDate *date = [rs dateForColumn:@"date"];
//            NSDate *dayDate = [NSDate dateWithYearMonthAndDay:date.year andMonth:date.month andDay:date.day];
//            if (![__safe_array containsObject:dayDate]) {
//                [__safe_array addObject:dayDate];
//            }
//
//        }
//        [rs close];
//    }];
//    return mArr;
//
//}
//
////查找某一天的俯卧撑总个数
//- (NSInteger)selectAllPushUpCountWithDate:(NSDate *)dayDate; {
//    NSDate *startDate = [dayDate dateAtStartOfDay];
//    NSDate *endDate = [dayDate dateByAddingDays:1];
//    endDate = [endDate dateAtStartOfDay];
//    __block NSString *ssql = [NSString stringWithFormat:@"SELECT SUM(count) as allcount FROM pushups_number_data where date >= '%@' and date < '%@'",[self dateToString:startDate],[self dateToString:endDate]];
//    __block NSInteger count = 0;
//    [self.dataDBQueue inDatabase:^(FMDatabase *db) {
//        FMResultSet *rs = [db executeQuery:ssql];
//        [db setDateFormat:[self dbDateFormatter:DATE_TYPE_DATESTAMP]];
//        while (rs.next) {
//             count = [rs intForColumn:@"allcount"];
//        }
//        [rs close];
//    }];
//    return count;
//}
//
////查找某一天的俯卧撑总卡路里
//- (CGFloat)selectAllPushUpCalorieWithDate:(NSDate *)dayDate; {
//    NSDate *startDate = [dayDate dateAtStartOfDay];
//      NSDate *endDate = [dayDate dateByAddingDays:1];
//      endDate = [endDate dateAtStartOfDay];
//      __block NSString *ssql = [NSString stringWithFormat:@"SELECT SUM(calorie) as allcount FROM pushups_number_data where date >= '%@' and date < '%@'",[self dateToString:startDate],[self dateToString:endDate]];
//          __block CGFloat count = 0;
//      [self.dataDBQueue inDatabase:^(FMDatabase *db) {
//          FMResultSet *rs = [db executeQuery:ssql];
//          [db setDateFormat:[self dbDateFormatter:DATE_TYPE_DATESTAMP]];
//          while (rs.next) {
//               count = [rs doubleForColumn:@"allcount"];
//          }
//          [rs close];
//      }];
//      return count;
//}

@end
