//
//  TYShopModel.h
//  TYPictureCache
//
//  Created by 马天野 on 2017/6/7.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TYShopModel : NSObject

@property (nonatomic, assign) CGFloat h;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *price;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
