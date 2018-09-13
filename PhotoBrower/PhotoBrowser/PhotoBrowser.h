//
//  PhotoBrowser.h
//  PhotoBrower
//
//  Created by 惠上科技 on 2018/9/13.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTypeScale,
    AnimationTypePush
} NS_ENUM_AVAILABLE_IOS(7_0);

@class PhotoBrowser;

@protocol PhotoBrowserDelegate <NSObject>

/**
 图片的个数
 */
-(NSInteger)numberOfPhotosInPhotoBrowser:(PhotoBrowser *)photoBrowser;


/**
 图片的名称或地址
 支持本地与远程两种URL
 */
-(NSString *)photoBrowser:(PhotoBrowser *)photoBrowser imageUrlForIndex:(NSInteger)index;


/**
 设置占位图片
 @discussion 必须设置，不然在视图没加载出来之前无法显示
 */
-(UIImage *)photoBrowser:(PhotoBrowser *)photoBrowser placeholderImageForIndex:(NSInteger)index;

@optional

/**
 如果需要缩放弹出 需要提供原来的view视图
 */
-(UIImageView *)photoBrowser:(PhotoBrowser *)photoBrowser sourceViewForIndex:(NSInteger)index;

@end

@interface PhotoBrowser : UIViewController

/**
 提供数据的代理
 */
@property (nonatomic, weak) id<PhotoBrowserDelegate>delegate;

/**
 当前选中的索引页
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 支持自定义cell 但必须集成PhotoCell
 @discussion 添加操作视图等等
 * 注意不支持xib
 */
@property (nonatomic, assign) Class cellClass;

/**
 弹出动画 默认为（AnimationTypeScale）缩放
 */
@property (nonatomic, assign) AnimationType animationType;


/**
 如果animationType设置为LNAnimationTypePush时，viewController必须有navigationCotnroller才可以
 */
-(void)showWithViewController:(UIViewController *)viewController;

@end
