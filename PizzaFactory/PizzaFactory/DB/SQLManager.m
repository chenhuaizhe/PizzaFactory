//
//  SQLManager.m
//  PushUps
//
//  Created by ChenYuan's Macbook Air on 2020/1/30.
//  Copyright © 2020 chenyuan. All rights reserved.
//

#import "SQLManager.h"


#define DATA_DB_VERSION 0



@interface SQLManager ()


@end

@implementation SQLManager

static SQLManager *sqlManger = nil;

+ (SQLManager *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sqlManger = [[SQLManager alloc]init];
    });
    return sqlManger;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initDataBase];
    }
    return self;
}

- (void)initFileProtectionNone {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [self FilePaths:kDB_DIR];
    if (![fileManager fileExistsAtPath:dirPath]) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:NSFileProtectionNone
                                                               forKey:NSFileProtectionKey];
        BOOL res=[fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:attributes error:nil];
        NSLog(@"============%d",res);
    }
}

//设置数据库文件路径 沙盒
- (NSString*) FilePaths:(NSString*)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] == 0) {
        return (id)NO;
    }
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:fileName];
    return dbPath;
}

#pragma mark - init db
- (void)initDataBase {
    
    [self initFileProtectionNone];
    
    [self initDataDB];

    
    [self updateDBIfNeed];
    /*Property */
    self.valueStrs = [[NSMutableArray alloc] initWithCapacity:0];
    
}


- (void)initDataDB {
    if (self.dataDBQueue == nil) {
        int flags = SQLITE_OPEN_CREATE|SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION|SQLITE_OPEN_READWRITE;
        self.dataDBQueue = [FMDatabaseQueue databaseQueueWithPath:[self FilePaths:kDataDBName] flags:flags];
    }
    
    [self.dataDBQueue inDatabase:^(FMDatabase *db) {
        if (!db.userVersion || db.userVersion < 1) {
            //数据库版本控制
            [db setUserVersion:DATA_DB_VERSION];
        }
        
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Pizza (number INTEGER, chef_name TEXT,toppings TEXT,size INTEGER, date DATE, done INTEGER, PRIMARY KEY(number))"];
        
    }];
}

#pragma mark - db version update
/**
 解决用户覆盖安装 数据库结构发生变化
 */
- (void)updateDBIfNeed {
    [self updateDataDB];
}


- (void)updateDataDB {
    [self.dataDBQueue inDatabase:^(FMDatabase * _Nonnull db) {
       
    }];
}

#pragma mark - insert
- (BOOL)insertModelWithDBQueue:(FMDatabaseQueue *)dbQueue andTableName:(NSString *)tableName andColumns:(NSString *)columnStr andValues:(NSString *)valueStr {
    __block BOOL _safe_success;
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString *ssql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@) values (%@)",tableName,columnStr,valueStr];
        _safe_success = [db executeUpdate:ssql];
    }];
    return _safe_success;
}

#pragma mark - date
- (NSString *)dateToString:(NSDate *)date {
    return [[self dbDateFormatter:DATE_TYPE_DATESTAMP] stringFromDate:date];
}

- (NSString *)calendarToString:(NSDate *)date {
    return [[self dbDateFormatter:DATE_TYPE_CALENDAR] stringFromDate:date];
}

- (NSDateFormatter *)dbDateFormatter:(NSInteger )type {
    NSString *formatStr = @"yyyy-MM-dd HH:mm:ss";
    if (type == DATE_TYPE_CALENDAR) {
        formatStr = @"yyyy-MM-dd";
    }
    NSDateFormatter *formatter = [FMDatabase storeableDateFormat:formatStr];
    formatter.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    return formatter;
}


@end
