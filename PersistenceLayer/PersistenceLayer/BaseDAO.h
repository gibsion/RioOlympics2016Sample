//
//  BaseDAO.h
//  PersistenceLayer
//
//  Created by gibsion on 16/4/27.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "sqlite3.h"
#import "DBHelper.h"

@interface BaseDAO : NSObject
{
    sqlite3 *db;
}

//数据库文件全路径
@property(nonatomic, strong) NSString *dbFilePath;
//打开SQLite数据库
-(BOOL)openDB;

@end
