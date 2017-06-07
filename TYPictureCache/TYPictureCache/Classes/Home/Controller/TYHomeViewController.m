//
//  TYHomeViewController.m
//  TYPictureCache
//
//  Created by 马天野 on 2017/6/7.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYHomeViewController.h"
#import "TYShopListVc.h"

@interface TYHomeViewController ()

@end

@implementation TYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - PushToPictureList

- (IBAction)pushToPictureList:(id)sender {
    TYShopListVc *shopListVc = [[TYShopListVc alloc] init];
    [self.navigationController pushViewController:shopListVc animated:YES];
}


@end
