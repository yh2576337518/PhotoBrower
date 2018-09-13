//
//  PhotoCell.h
//  PhotoBrower
//
//  Created by 惠上科技 on 2018/9/13.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoBrowser;
@interface PhotoCell : UICollectionViewCell
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) UIImage *placeHolderImage;
@property (nonatomic, weak) UIImageView *sourceView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) PhotoBrowser *browser;
@property (nonatomic, weak, readonly) UIImageView *imageView;
@end
