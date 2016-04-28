//
//  BaseDAO.m
//  PersistenceLayer
//
//  Created by gibsion on 16/4/27.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "BaseDAO.h"

@implementation BaseDAO

-(id)init
{
    self = [super init];
    if (self) {
        self.dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
        [DBHelper initDB];
    }
    
    return self;
}

- (BOOL)openDB
{
    NSLog(@"dbFilePath=%@", self.dbFilePath);
    
    if (sqlite3_open([self.dbFilePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
        return false;
    }
    
    return true;
}

@end
