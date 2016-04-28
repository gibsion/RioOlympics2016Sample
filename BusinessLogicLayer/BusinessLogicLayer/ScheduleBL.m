//
//  ScheduleBL.m
//  BusinessLogicLayer
//
//  Created by gibsion on 16/4/28.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "ScheduleBL.h"

@implementation ScheduleBL

-(NSMutableDictionary *) readData
{
    ScheduleDAO *scheduleDAO = [ScheduleDAO shareManager];
    NSMutableArray *schedules = [scheduleDAO findAll];
    NSMutableDictionary *resDict = [[NSMutableDictionary alloc]init];
    EventsDAO *eventDAO = [EventsDAO sharedManager];
    
    //延迟加载Events数据
    for (Schedule *schedule in schedules) {
        Events *event = [eventDAO findById:schedule.Event];
        NSArray *allkey = [resDict allKeys];
        
        //把NSMutableArray结构化为NSMutableDictionary结构
        if ([allkey containsObject:schedule.GameDate]) {
            NSMutableArray *value = [resDict objectForKey:schedule.GameDate];
            [value addObject:schedule];
        } else {
            NSMutableArray *value = [[NSMutableArray alloc]init];
            [value addObject:schedule];
            [resDict setObject:value forKey:schedule.GameDate];
        }
    }
    
    return resDict;
}

@end
