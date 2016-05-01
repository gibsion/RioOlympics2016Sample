//
//  CountDownViewController.m
//  RioOlympics2016Sample
//
//  Created by gibsion on 16/4/30.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "CountDownViewController.h"

@interface CountDownViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelCountDown;

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建NSDateComponents对象
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //设置NSDateComponents日期
    [comps setDay:5];
    //设置NSDateComponents月
    [comps setMonth:8];
    //设置NSDateComponents年
    [comps setYear:2016];
    
    //创建日历对象
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获得2016-8-5日的NSDate日期对象
    NSDate *destinationDate = [calendar dateFromComponents:comps];
    //获得2016-8-5时间的NSDateComonents对象
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:[NSDate date] toDate:destinationDate options:0];
    //获得当前日期到2016-8-5相差的天数
    NSInteger days = [components day];
    NSString *strLabel = [NSString stringWithFormat:@"%li天", days];
    self.labelCountDown.text = strLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
