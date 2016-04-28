//
//  DBHelper.h
//  PersistenceLayer
//
//  Created by gibsion on 16/4/27.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

static sqlite3 *db;

@interface DBHelper : NSObject

//获得沙箱document目录下全部路径
+(NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName;

//初始化病加载数据
+(void)initDB;

//从数据库获得当前数据库版本号
+(int)dbVersionNumber;

@end
