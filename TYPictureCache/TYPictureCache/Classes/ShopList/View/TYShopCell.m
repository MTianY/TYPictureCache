//
//  TYShopCell.m
//  TYPictureCache
//
//  Created by 马天野 on 2017/6/7.
//  Copyright © 2017年 MTY. All rights reserved.                             
//

#import "TYShopCell.h"
#import "TYShopModel.h"

@interface TYShopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *shopImg;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopHeight;

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation TYShopCell

#pragma mark - 懒加载

- (NSMutableDictionary *)images {
    if (nil == _images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

- (NSMutableDictionary *)operations {
    if (nil == _operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

- (NSOperationQueue *)queue {
    if (nil == _queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

#pragma mark - cellModel 的 set 方法

- (void)setCellModel:(TYShopModel *)cellModel {
    _cellModel = cellModel;
    self.shopPrice.text = [NSString stringWithFormat:@"%@",self.cellModel.price];
    self.shopWidth.constant = self.cellModel.w;
    self.shopHeight.constant = self.cellModel.h;
    
    // 设置图片
    /*
     * 这里不采用 SDWebImage 来加载图片,而是自己实现三级缓存.(内存缓存-沙盒缓存-操作缓存)
     */
    [self downloadPictureAndCache];
}

#pragma mark 图片下载之三级缓存实现

- (void)downloadPictureAndCache {
    
    // 1.首先检查内存缓存是否有图片,如果有,直接使用
    UIImage *image = [self.images objectForKey:self.cellModel.img];
    if (image) {
        self.shopImg.image = image;
        NSLog(@"使用内存缓存图片");
    } else {
        // 2.内存缓存没有的话,检查磁盘缓存.
        NSString *fullPath = [self getDiskCachePath];
        NSData *data = [NSData dataWithContentsOfFile:fullPath];
        if (data) {
            NSLog(@"使用磁盘缓存的图片");
            UIImage *image = [UIImage imageWithData:data];
            self.shopImg.image = image;
            // 保存一份到内存缓存中
            [self.images setObject:image forKey:self.cellModel.img];
        } else {
            // 3.如果磁盘缓存也没有的话,那么就要重新下载图片了
            // 为防止图片显示错乱,设置占位图片.
            self.shopImg.image = [UIImage imageNamed:@"placeholder"];
            // 从缓存操作中取下载操作.看是否正在下载.
            NSBlockOperation *downloadOperation = [self.operations objectForKey:self.cellModel.img];
            if (downloadOperation) {    // 表明当前正在下载图片
                NSLog(@"该图片正在下载中,请稍后...");
            } else {
                downloadOperation = [NSBlockOperation blockOperationWithBlock:^{
                    
                    NSLog(@"图片已重新下载");
                    NSURL *url = [NSURL URLWithString:self.cellModel.img];
                    
                    for (int i=0; i<9999999; i++) {
                        // 耗时操作.模拟网速慢的情况
                    }
                    
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:data];
                    
                    if (nil == image) {
                        // 移除下载操作
                        [self.operations removeObjectForKey:self.cellModel.img];
                        return;
                    }
                    
                    // 保存图片到内存缓存中
                    [self.images setObject:image forKey:self.cellModel.img];
                    // 保存数据到沙盒缓存中
                    [data writeToFile:fullPath atomically:YES];
                    
                    // 主线程设置图片
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        self.shopImg.image = image;
                    }];
                    
                    
                }];
                
                // 缓存下载操作
                [self.operations setObject:downloadOperation forKey:self.cellModel.img];
                // 将操作添加到队列
                [self.queue addOperation:downloadOperation];
            }
        }
    }
    
}

// 获取磁盘缓存文件的全路径
- (NSString *)getDiskCachePath {
    // 截取文件名
    NSString *fileName = [self.cellModel.img lastPathComponent];
    // 缓存文件夹路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",cachePath);
    // 拼接文件全路径
    NSString *fullPath = [cachePath stringByAppendingPathComponent:fileName];
    return fullPath;
}

@end
