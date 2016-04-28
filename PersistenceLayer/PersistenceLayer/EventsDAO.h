//
//  EventsDAO.h
//  PersistenceLayer
//
//  Created by gibsion on 16/4/27.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "BaseDAO.h"
#import "Events.h"

@interface EventsDAO : BaseDAO

+(EventsDAO *)sharedManager;

//插入Note方法
-(int)create:(Events *)model;

//删除Note
-(int)remove:(Events *)model;

//修改Note
-(int)modify:(Events *)model;

//查询所有数据
-(NSMutableArray *) findAll;

//按主键查询
-(Events *)findById:(Events *)model;

@end
