//
//  ScheduleDAO.m
//  PersistenceLayer
//
//  Created by gibsion on 16/4/28.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "ScheduleDAO.h"

@implementation ScheduleDAO

static ScheduleDAO *shareManager = nil;

+(ScheduleDAO *)shareManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManager = [[super alloc]init];
    });
    
    return shareManager;
}

//插入Schedule
-(int)create:(Schedule *)model
{
    if ([self openDB]) {
        NSString *sqlStr = @"INSERT INTO Schedule (GameDate, GameTime, GameInfo, EventID) VALUES (?,?,?,?)";
        sqlite3_stmt *statment;
        //预处理
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statment, NULL) == SQLITE_OK) {
            //绑定参数开始
            sqlite3_bind_text(statment, 1, [model.GameDate UTF8String], -1, NULL);
            sqlite3_bind_text(statment, 2, [model.GameTime UTF8String], -1, NULL);
            sqlite3_bind_text(statment, 3, [model.GameInfo UTF8String], -1, NULL);
            sqlite3_bind_int(statment, 4, model.Event.EventID);
            
            //执行插入
            if (sqlite3_step(statment) != SQLITE_DONE) {
                NSAssert(NO, @"插入数据失败");
            }
        }
        
        sqlite3_finalize(statment);
        sqlite3_close(db);
    }
    
    return 0;
}

//删除Schedule
-(int)remove:(Schedule *)model
{
    if ([self openDB]) {
        NSString *sqlStr = @"DELETE from Schedule where ScheduleID = ?";
        sqlite3_stmt *statment;
        //预处理
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statment, NULL) == SQLITE_OK) {
            //绑定参数开始
            sqlite3_bind_int(statment, 1, model.ScheduleID);
            //执行
            if (sqlite3_step(statment)!= SQLITE_DONE) {
                NSAssert(NO, @"删除数据失败");
            }
        }
        
        sqlite3_finalize(statment);
        sqlite3_close(db);
    }
    
    return 0;
}

//修改Schedule
-(int)modify:(Schedule *)model
{
    if ([self openDB]) {
        NSString *sqlStr = @"UPDATE Schedule set GameInfo=?, EventID=?, GameDate=?, GameTime=? where ScheduleID=?";
        sqlite3_stmt *statment;
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statment, NULL) == SQLITE_OK) {
            //绑定参数开始
            sqlite3_bind_text(statment, 1, [model.GameInfo UTF8String], -1, NULL);
            sqlite3_bind_int(statment, 2, model.Event.EventID);
            sqlite3_bind_text(statment, 3, [model.GameDate UTF8String], -1, NULL);
            sqlite3_bind_text(statment, 4, [model.GameTime UTF8String], -1, NULL);
            //执行
            if (sqlite3_step(statment) != SQLITE_DONE) {
                NSAssert(NO, @"修改数据失败");
            }
        }
        
        sqlite3_finalize(statment);
        sqlite3_close(db);
    }
    
    return 0;
}

//查询所有数据
-(NSMutableArray *)findAll
{
    NSMutableArray *listData = [[NSMutableArray alloc]init];
    if ([self openDB]) {
        NSString *sqlStr = @"SELECT GameDate, GameTime, GameInfo, EventID, ScheduleID FROM Schedule";
        sqlite3_stmt *statment;
        //预处理
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statment, NULL) == SQLITE_OK) {
            while (sqlite3_step(statment) == SQLITE_ROW) {
                Schedule *schedule = [[Schedule alloc]init];
                Events *event = [[Events alloc]init];
                schedule.Event = event;
                
                char*GameDate = (char *)sqlite3_column_text(statment, 0);
                schedule.GameDate = [[NSString alloc] initWithUTF8String:GameDate];
                
                char *GameTime = (char *)sqlite3_column_text(statment, 1);
                schedule.GameTime = [[NSString alloc]initWithUTF8String:GameTime];
                
                char *GameInfo = (char *)sqlite3_column_text(statment, 2);
                schedule.GameInfo = [[NSString alloc] initWithUTF8String:GameInfo];
                
                schedule.Event.EventID = sqlite3_column_int(statment, 3);
                schedule.ScheduleID = sqlite3_column_int(statment, 4);
                
                [listData addObject:schedule];
            }
        }
        
        sqlite3_finalize(statment);
        sqlite3_close(db);
    }
    
    return listData;
}

//按照主键查询
-(Schedule *)findById:(Schedule *)model
{
    
    if ([self openDB]) {
        
        NSString *qsql = @"SELECT GameDate, GameTime,GameInfo,EventID,ScheduleID FROM Schedule where ScheduleID=?";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            //绑定参数开始
            sqlite3_bind_int(statement, 1, model.ScheduleID);
            
            //执行
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                Schedule* schedule = [[Schedule alloc] init];
                Events *event  = [[Events alloc] init];
                schedule.Event = event;
                
                char *cGameDate = (char *) sqlite3_column_text(statement, 0);
                schedule.GameDate = [[NSString alloc] initWithUTF8String: cGameDate];
                
                char *cGameTime = (char *) sqlite3_column_text(statement, 1);
                schedule.GameTime = [[NSString alloc] initWithUTF8String: cGameTime];
                
                char *cGameInfo = (char *) sqlite3_column_text(statement, 2);
                schedule.GameInfo = [[NSString alloc] initWithUTF8String: cGameInfo];
                
                schedule.Event.EventID =  sqlite3_column_int(statement, 3);
                
                schedule.ScheduleID =  sqlite3_column_int(statement, 4);
                
                sqlite3_finalize(statement);
                sqlite3_close(db);
                
                return schedule;
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
        
    }
    return nil;
}

@end
