//
//  TYHomeViewController.m
//  TYPictureCache
//
//  Created by 马天野 on 2017/6/7.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYHomeViewController.h"
#import "TYPictureListVc.h"

@interface TYHomeViewController ()

@end

@implementation TYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - PushToPictureList

- (IBAction)pushToPictureList:(id)sender {
    TYPictureListVc *pictureListVc = [[TYPictureListVc alloc] init];
    [self.navigationController pushViewController:pictureListVc animated:YES];
}


@end
