//
//  DFHelper.m
//  PersistenceLayer
//
//  Created by gibsion on 16/4/27.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper

+(NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName
{
    NSString *docDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docDirectory stringByAppendingString:fileName];
    
    return path;
}

//初始化并加载数据
+(void)initDB
{
    NSString *configTablePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"DBConfig" ofType:@"plist"];
    NSDictionary *configTable = [[NSDictionary alloc] initWithContentsOfFile:configTablePath];
    //从配置文件获得数据版本号
    NSNumber *dbConfigVersion = [configTable objectForKey:@"DB_VERSION"];
    if (dbConfigVersion == nil) {
        dbConfigVersion = [NSNumber numberWithInt:0];
    }
    
    //从数据库DBVersionInfo表记录返回的数据库版本号
    int versionNumber = [self dbVersionNumber];
    
    //版本号不一致
    if ([dbConfigVersion intValue] != versionNumber) {
        NSString *dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
        NSLog(@"###dbFilePath=%@ ###", dbFilePath);
        if (sqlite3_open([dbFilePath UTF8String], &db)) {
            sqlite3_close(db);
            NSAssert(NO, @"数据库打开失败");
        } else {
            //加载数据到业务表中
            NSLog(@"数据库升级中...");
            char *err = NULL;
            NSString *createTablePath = [[NSBundle bundleForClass:[self class]]pathForResource:@"create_load" ofType:@"sql"];
            NSString *sql = [[NSString alloc] initWithContentsOfFile:createTablePath encoding:NSUTF8StringEncoding error:nil];
            
            if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
                NSLog(@"数据库升级失败：%@", [NSMutableString stringWithCString:err encoding: NSUTF8StringEncoding]);
            }
            
            //把当前版本号写回到文件中
            NSString *updateSql = [[NSString alloc] initWithFormat:@"update DBVersionInfo set version_number = %i", [dbConfigVersion intValue] ];
            if (sqlite3_exec(db, [updateSql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
                NSLog(@"更新DBVersionInfo数据失败");
                NSLog(@"version_number=%i", [dbConfigVersion intValue]);
            }
            else
            {
                NSLog(@"更新DBVersionInfo数据成功！version_number=%i", [dbConfigVersion intValue]);
            }
            
            sqlite3_close(db);
        }
    }
}

+ (int)dbVersionNumber
{
    NSString *dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
    int versionNumber = -1;
    
    if (sqlite3_open([dbFilePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }
    else
    {
        NSString *sql = @"create Table if not exists DBVersionInfo (version_number int);";
        sqlite3_stmt *statment;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statment, NULL) == SQLITE_OK) {
            if (sqlite3_step(statment) == SQLITE_ROW) {
                NSLog(@"有数据情况");
                versionNumber = sqlite3_column_int(statment, 0);
            }
            else
            {
                NSLog(@"无数据情况");
                NSString *insertSql = @"insert into DBVersionInfo (version_number) values(-1)";
                if (sqlite3_exec(db, [insertSql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
                    NSLog(@"插入数据失败");
                }
            }
        }
        else
        {
            NSLog(@"预处理失败：%@", sql);
        }
        
        sqlite3_finalize(statment);
        sqlite3_close(db);
    }
    
    return versionNumber;
}

@end
