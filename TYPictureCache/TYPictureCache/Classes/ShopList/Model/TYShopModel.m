//
//  TYShopModel.m
//  TYPictureCache
//
//  Created by 马天野 on 2017/6/7.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYShopModel.h"

@implementation TYShopModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    TYShopModel *model = [[TYShopModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
