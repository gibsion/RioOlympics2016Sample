//
//  EventsDAOTest.m
//  PersistenceLayer
//
//  Created by gibsion on 16/4/28.
//  Copyright © 2016年 gibsion. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Events.h"
#import "EventsDAO.h"
#import "DBHelper.h"

@interface EventsDAOTest : XCTestCase

@property (nonatomic, strong) EventsDAO *dao;
@property (nonatomic, strong) Events *theEvents;

@end

@implementation EventsDAOTest

- (void)setUp {
    [super setUp];
    
    self.dao = [[EventsDAO alloc]init];
    self.theEvents = [[Events alloc]init];
    self.theEvents.EventName = @"test EventName";
    self.theEvents.EventIcon = @"test EventIcon";
    self.theEvents.KeyInfo = @"test KeyInfo";
    self.theEvents.BasicsInfo = @"test BasicsInfo";
    self.theEvents.OlympicsInfo = @"test OlympicsInfo";
}

- (void)tearDown {
    self.dao = nil;
    [super tearDown];
}

- (void)test_1_Create {
    int res  = [self.dao create:self.theEvents];
    XCTAssertEqual(res, 0);
}

- (void)test_2_FindById
{
    NSLog(@"self.theEvents.EventID = %i", self.theEvents.EventID);
    self.theEvents.EventID = 41;
    Events *resEvents = [self.dao findById:self.theEvents];
    
    XCTAssertNotNil(resEvents, @"查询记录为nil");
    
    XCTAssertEqualObjects(self.theEvents.EventName, resEvents.EventName);
    XCTAssertEqualObjects(self.theEvents.EventIcon, resEvents.EventIcon);
    XCTAssertEqualObjects(self.theEvents.KeyInfo, resEvents.KeyInfo);
    XCTAssertEqualObjects(self.theEvents.BasicsInfo, resEvents.BasicsInfo);
    XCTAssertEqualObjects(self.theEvents.OlympicsInfo, resEvents.OlympicsInfo);
}

- (void)test_3_FindAll
{
    NSArray *list = [self.dao findAll];
    XCTAssertEqual([list count], 41);
    
    Events *resEvents = list[40];
    XCTAssertEqualObjects(self.theEvents.EventName, resEvents.EventName);
    XCTAssertEqualObjects(self.theEvents.EventIcon, resEvents.EventIcon);
    XCTAssertEqualObjects(self.theEvents.KeyInfo, resEvents.KeyInfo);
    XCTAssertEqualObjects(self.theEvents.BasicsInfo, resEvents.BasicsInfo);
    XCTAssertEqualObjects(self.theEvents.OlympicsInfo, resEvents.OlympicsInfo);
}

//测试 修改Events方法
-(void) test_4_Modify
{
    self.theEvents.EventID = 40;
    self.theEvents.EventName = @"test modify EventName";
    
    int res = [self.dao modify:self.theEvents];
    //断言 无异常，返回值为0
    XCTAssertEqual(res, 0);
    
    Events* resEvents = [self.dao findById:self.theEvents];
    //断言 查询结果非nil
    XCTAssertNotNil(resEvents, @"查询记录为nil");
    //断言
    XCTAssertEqualObjects(self.theEvents.EventName ,resEvents.EventName);
    XCTAssertEqualObjects(self.theEvents.EventIcon ,resEvents.EventIcon);
    XCTAssertEqualObjects(self.theEvents.KeyInfo ,resEvents.KeyInfo);
    XCTAssertEqualObjects(self.theEvents.BasicsInfo ,resEvents.BasicsInfo);
    XCTAssertEqualObjects(self.theEvents.OlympicsInfo ,resEvents.OlympicsInfo);
    
}

//测试 删除数据方法
-(void) test_5_Remove
{
    int res =   [self.dao remove:self.theEvents];
    //断言 无异常，返回值为0
    XCTAssertEqual(res, 0);
    
    Events* resEvents = [self.dao findById:self.theEvents];
    //断言 查询结果nil
    XCTAssertNil(resEvents, @"记录删除失败");
    
}

@end
