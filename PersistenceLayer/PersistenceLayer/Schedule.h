//
//  Schedule.h
//  PersistenceLayer
//
//  Created by gibsion on 16/4/27.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "Events.h"

@interface Schedule : NSObject

//编号
@property (nonatomic, assign) NSUInteger ScheduleID;
///比赛日期
@property (nonatomic, strong) NSString *GameDate;
//比赛时间
@property (nonatomic, strong) NSString *GameTime;
//比赛描述
@property (nonatomic, strong) NSString *GameInfo;
//比赛项目
@property (nonatomic, strong) Events *Event;

@end
