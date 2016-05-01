//
//  AboutViewController.m
//  RioOlympics2016Sample
//
//  Created by gibsion on 16/4/30.
//  Copyright © 2016年 gibsion. All rights reserved.
//

#import "AboutViewController.h"
#import "GADBannerView.h"

#define AdUnitID @"ca-app-pub-1990684556219793/1962464393"

@interface AboutViewController () <GADBannerViewDelegate>

@property (strong, nonatomic) GADBannerView *bannerView;

- (void) createBannerView:(GADAdSize) size;

-(GADRequest *)request;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBannerView:kGADAdSizeSmartBannerPortrait];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createBannerView:(GADAdSize)size
{
    if (self.bannerView != nil) {
        self.bannerView.delegate = nil;
        [self.bannerView removeFromSuperview];
    }
    
    self.bannerView = [[GADBannerView alloc] initWithAdSize:size];
    self.bannerView.adUnitID = AdUnitID;
    self.bannerView.delegate = self;
    self.bannerView.rootViewController = self;
    [self.view addSubview:self.bannerView];
    
    [self.bannerView loadRequest:[self request]];
}

-(GADRequest *)request
{
    GADRequest *request = [[GADRequest alloc]init];
    request.testDevices = [NSArray arrayWithObjects:@"7740674c81cf31a50d2f92bcdb729f10", GAD_SIMULATOR_ID, nil];

    return request;
}

#pragma mark - GADBannerViewDelegate

-(void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"广告接收成功");
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"广告接收失败 %@", [error localizedFailureReason]);
}

@end
