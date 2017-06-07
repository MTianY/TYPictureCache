//
//  TYShopListVc.m
//  TYPictureCache
//
//  Created by 马天野 on 2017/6/7.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYShopListVc.h"
#import "TYShopModel.h"
#import "TYShopCell.h"

static NSString *const cellID = @"cellID";

@interface TYShopListVc ()

@property (nonatomic, strong) NSArray *shops;
@property (nonatomic, strong) TYShopCell *cell;

@end

@implementation TYShopListVc

#pragma mark -- 懒加载

- (NSArray *)shops {
    if (nil == _shops) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shop.plist" ofType:nil]];
        NSMutableArray *tempArrayM = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            TYShopModel *model = [TYShopModel modelWithDict:dict];
            [tempArrayM addObject:model];
        }
        _shops = tempArrayM;
    }
    return _shops;
}

#pragma mark - view 的生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TYShopCell" bundle:nil] forCellReuseIdentifier:cellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.cell.operations removeAllObjects];
    [self.cell.images removeAllObjects];
}

#pragma mark - UITableViewDataSoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    self.cell = cell;
    cell.cellModel = self.shops[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYShopModel *model = self.shops[indexPath.row];
    return model.h + 50;
}

@end
