//
//  TYShopCell.h
//  TYPictureCache
//
//  Created by 马天野 on 2017/6/7.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYShopModel;
@interface TYShopCell : UITableViewCell

@property (nonatomic, strong) TYShopModel *cellModel;

/**
 * 记录内存缓存图片.
 * key: 图片的url(img)
 * 暴露出来是因为后面在内存溢出时要清空内存缓存.
 */
@property (nonatomic, strong) NSMutableDictionary *images;

/**
 * 缓存操作
 * key : 图片的url(img)
 */
@property (nonatomic, strong) NSMutableDictionary *operations;

@end
