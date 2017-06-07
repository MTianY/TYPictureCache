//
//  TYTabBarViewController.m
//  TYPictureCache
//
//  Created by 马天野 on 2017/6/7.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYTabBarViewController.h"
#import "TYHomeViewController.h"

@interface TYTabBarViewController ()

@end

@implementation TYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVcs];
}

#pragma mark - 添加子控制器

- (void)addChildVcs {
    TYHomeViewController *homeVc = [[TYHomeViewController alloc] init];
    homeVc.title = @"首页";
    UINavigationController *navVc_home = [[UINavigationController alloc] initWithRootViewController:homeVc];
    [self addChildViewController:navVc_home];
}

@end
