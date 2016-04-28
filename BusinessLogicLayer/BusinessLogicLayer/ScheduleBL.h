//
//  ScheduleBL.h
//  BusinessLogicLayer
//
//  Created by gibsion on 16/4/28.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PersistenceLayer/Schedule.h>
#import <PersistenceLayer/ScheduleDAO.h>
#import <PersistenceLayer/Events.h>
#import <PersistenceLayer/EventsDAO.h>

@interface ScheduleBL : NSObject

-(NSMutableDictionary *) readData;

@end
