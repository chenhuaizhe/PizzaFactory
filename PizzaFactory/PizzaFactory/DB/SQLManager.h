//
//  SQLManager.h
//  PushUps
//
//  Created by ChenYuan's Macbook Air on 2020/1/30.
//  Copyright © 2020 chenyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <fmdb/FMDB.h>
#import "sqlite3.h"

NS_ASSUME_NONNULL_BEGIN

#define kDB_DIR         @"/mydb"               //DB_DIR
#define kDataDBName     [NSString stringWithFormat:@"%@/data.sqlite", kDB_DIR]


typedef enum{
    DATE_TYPE_DATESTAMP = 1998,
    DATE_TYPE_CALENDAR = 2000,
} SQLDateType;

@interface SQLManager : NSObject

@property (nonatomic ,strong)FMDatabaseQueue *dataDBQueue;


/*insert DB queue*/
@property (nonatomic ,strong) NSMutableArray *valueStrs;
@property (nonatomic ,strong) NSLock *vsLock;

+ (SQLManager *)shareInstance;

#pragma mark - date
- (NSString *)dateToString:(NSDate *)date;
- (NSString *)calendarToString:(NSDate *)date;
- (NSDateFormatter *)dbDateFormatter:(NSInteger )type;

#pragma mark - insert
- (BOOL)insertModelWithDBQueue:(FMDatabaseQueue *)dbQueue
                  andTableName:(NSString *)tableName
                    andColumns:(NSString *)columnStr
                     andValues:(NSString *)valueStr;


@end

NS_ASSUME_NONNULL_END
