//
//  ScheduleDAOTest.m
//  PersistenceLayer
//
//  Created by gibsion on 16/4/28.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "ScheduleDAO.h"
#import "Schedule.h"

@interface ScheduleDAOTests : XCTestCase

@property (nonatomic,strong) ScheduleDAO * dao;
@property (nonatomic,strong) Schedule * theSchedule;

@end

@implementation ScheduleDAOTests



- (void)setUp {
    //创建ScheduleDAO对象
    self.dao = [ScheduleDAO shareManager];
    //创建Schedule对象
    self.theSchedule = [[Schedule alloc] init];
    self.theSchedule.GameDate = @"test GameDate";
    self.theSchedule.GameTime = @"test GameTime";
    self.theSchedule.GameInfo = @"test GameInfo";
    self.theSchedule.Event.EventID = 1;
}

- (void)tearDown {
    self.dao = nil;
}

//测试 插入Schedule方法
-(void) test_1_Create
{
    int res = [self.dao create:self.theSchedule];
    //断言 无异常，返回值为0，
    XCTAssertEqual(res, 0);
}

//测试 按照主键查询数据方法
-(void) test_2_FindById
{
    self.theSchedule.ScheduleID = 502;
    Schedule* resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果非nil
    XCTAssertNotNil(resSchedule, @"查询记录为nil");
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate);
    XCTAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime);
    XCTAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo);
    XCTAssertEqual(self.theSchedule.Event.EventID ,resSchedule.Event.EventID);
}

//测试 查询所有数据方法
-(void) test_3_FindAll
{
    NSArray* list =  [self.dao findAll];
    //断言 查询记录数为1
    XCTAssertEqual([list count], 502);
    
    Schedule* resSchedule  = list[501];
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate);
    XCTAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime);
    XCTAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo);
    XCTAssertEqual(self.theSchedule.Event.EventID ,resSchedule.Event.EventID);
}

//测试 修改Schedule方法
-(void) test_4_Modify
{
    self.theSchedule.ScheduleID = 502;
    self.theSchedule.GameInfo = @"test modify GameInfo";
    
    int res = [self.dao modify:self.theSchedule];
    //断言 无异常，返回值为0
    XCTAssertEqual(res, 0);
    
    Schedule* resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果非nil
    XCTAssertNotNil(resSchedule, @"查询记录为nil");
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate ,resSchedule.GameDate);
    XCTAssertEqualObjects(self.theSchedule.GameTime ,resSchedule.GameTime);
    XCTAssertEqualObjects(self.theSchedule.GameInfo ,resSchedule.GameInfo);
    XCTAssertEqual(self.theSchedule.Event.EventID ,resSchedule.Event.EventID);
    
}

//测试 删除数据方法
-(void) test_5_Remove
{
    int res =   [self.dao remove:self.theSchedule];
    //断言 无异常，返回值为0
    XCTAssertEqual(res, 0);
    
    Schedule* resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果nil
    XCTAssertNil(resSchedule, @"记录删除失败");
    
}

@end
