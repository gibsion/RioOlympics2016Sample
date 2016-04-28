//
//  EventsBL.m
//  BusinessLogicLayer
//
//  Created by gibsion on 16/4/28.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "EventsBL.h"

@implementation EventsBL

-(NSMutableArray *)readData
{
    EventsDAO *dao = [EventsDAO sharedManager];
    NSMutableArray *list = [dao findAll];

    return list;
}

@end
