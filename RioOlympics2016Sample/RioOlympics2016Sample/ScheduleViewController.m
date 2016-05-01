//
//  ScheduleViewController.m
//  RioOlympics2016Sample
//
//  Created by gibsion on 16/4/30.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "ScheduleViewController.h"
#import "EventsDetailViewController.h"
#import <PersistenceLayer/Schedule.h>
#import <BusinessLogicLayer/ScheduleBL.h>

@interface ScheduleViewController ()

//表视图使用的数据
@property (strong, nonatomic) NSDictionary *data;
//比赛日期列表
@property (strong, nonatomic) NSArray *arrayGameDateList;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    if (self.data == nil || [self.data count] == 0) {
        ScheduleBL *bl = [ScheduleBL new];
        self.data = [bl readData];
        
        NSArray *keys = [self.data allKeys];
        //对key进行排序
        self.arrayGameDateList = [keys sortedArrayUsingSelector:@selector(compare:)];
    }
}




#pragma mark - TableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.data allKeys] count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //比赛日期
    NSString *strGameDate = [self.arrayGameDateList objectAtIndex:section];
    //比赛日期下的比赛日程表
    NSArray *schedule = [self.data objectForKey:strGameDate];
    return [schedule count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *strGameDate = [self.arrayGameDateList objectAtIndex:section];
    
    return strGameDate;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strGameDate = [self.arrayGameDateList objectAtIndex:indexPath.section];
    //比赛日期下的比赛日程表
    NSArray *schedules = [self.data objectForKey:strGameDate];
    Schedule *schedule = [schedules objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *subTitle = [[NSString alloc] initWithFormat:@"%@ | %@", schedule.GameInfo, schedule.Event.EventName];
    cell.textLabel.text = schedule.GameTime;
    cell.detailTextLabel.text = subTitle;
    
    NSLog(@"subTitile=%@", subTitle);
   // NSLog(@"schedule.GameInfo = %@, schedule.Event.EventName=%@", schedule.GameInfo, schedule.Event.EventName);
   // NSLog(@"cell.textLabel.text = %@", cell.textLabel.text);
    NSLog(@"cell.detailTextLabel.text = %@", cell.detailTextLabel.text);
    return cell;
}

-(NSArray *)sectionIndexTitlesForTableView: (UITableView *) tableView
{
    NSMutableArray *listTitile = [[NSMutableArray alloc] init];
    
    for (NSString *item in self.arrayGameDateList) {
        NSString *titile = [item substringFromIndex:5];
        [listTitile addObject:titile];
    }
    
    return listTitile;
}

@end
