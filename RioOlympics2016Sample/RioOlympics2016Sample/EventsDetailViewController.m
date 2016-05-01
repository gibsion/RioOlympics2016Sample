//
//  EventsDetailViewController.m
//  RioOlympics2016Sample
//
//  Created by gibsion on 16/4/30.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "EventsDetailViewController.h"

@interface EventsDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imgEventIcon;
@property (weak, nonatomic) IBOutlet UILabel *lableEventName;
@property (weak, nonatomic) IBOutlet UITextView *textKeyInfo;
@property (weak, nonatomic) IBOutlet UITextView *textBasicsInfo;
@property (weak, nonatomic) IBOutlet UITextView *textOlympicInfo;

@end

@implementation EventsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgEventIcon.image = [UIImage imageNamed:self.event.EventIcon];
    self.lableEventName.text = self.event.EventName;
    self.textBasicsInfo.text = self.event.BasicsInfo;
    self.textKeyInfo.text = self.event.KeyInfo;
    self.textOlympicInfo.text = self.event.OlympicsInfo;
    
    self.scrollView.frame = self.view.frame;
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
