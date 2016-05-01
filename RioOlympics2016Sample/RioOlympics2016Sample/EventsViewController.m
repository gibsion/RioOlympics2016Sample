//
//  EventsViewController.m
//  RioOlympics2016Sample
//
//  Created by gibsion on 16/4/30.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsViewCell.h"
#import "EventsDetailViewController.h"
#import <BusinessLogicLayer/EventsBL.h>
#import <PersistenceLayer/Events.h>


@interface EventsViewController ()
{
    //一行中列数
    NSUInteger COL_COUNT;
}
@property (strong, nonatomic) NSArray *events;

@end

@implementation EventsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    printf("EventsViewController %s \n", __FUNCTION__);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //iPhone
        COL_COUNT = 2;
    }
    else
    {
        //iPad
        COL_COUNT = 5;
    }
    
    if (self.events == nil || [self.events count] == 0) {
        EventsBL *bl = [[EventsBL alloc] init];
        
        //获取全部数据
        NSMutableArray *array = [bl readData];
        self.events = array;
        [self.collectionView reloadData];
    }
    
    NSLog(@"EventsViewController %s SUCCESS ! COL_COUNT = %li\n", __FUNCTION__, COL_COUNT);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  [self.events count]/COL_COUNT;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return COL_COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EventsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Events *event = [self.events objectAtIndex:(indexPath.section*COL_COUNT + indexPath.row)];
    cell.imgEventView.image = [UIImage imageNamed:event.EventIcon];
    NSLog(@"eventName=%@, eventIcon=%@", event.EventName, event.EventIcon);
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        Events *event =[self.events objectAtIndex:(indexPath.section * COL_COUNT + indexPath.row)];
        EventsDetailViewController *detailVC = [segue destinationViewController];
        detailVC.event = event;
    }
}

@end
