//
//  ScheduleDAO.h
//  PersistenceLayer
//
//  Created by gibsion on 16/4/28.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "BaseDAO.h"
#import "Schedule.h"
#import "Events.h"

//比赛日程表，数据访问对象类
@interface ScheduleDAO : BaseDAO

+(ScheduleDAO *)shareManager;

//插入Note
-(int)create:(Schedule *)model;

//删除Note
-(int)remove:(Schedule *)model;

//修改Note
-(int)modify:(Schedule *)model;

//查询所有数据
-(NSMutableArray *)findAll;

//按照主键查询
-(Schedule *)findById:(Schedule *)model;

@end
