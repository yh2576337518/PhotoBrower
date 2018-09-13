//
//  ViewController.m
//  PhotoBrower
//
//  Created by 惠上科技 on 2018/9/13.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "PhotoBrowser.h"
#import "PhotoCell.h"
#import <UIImageView+WebCache.h>
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,PhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 本地图片
    for (int i = 0 ; i < 7; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"cell_%d",i]];
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.row]]];
    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoBrowser *browser = [[PhotoBrowser alloc] init];
    browser.delegate = self;
    browser.cellClass = [PhotoCell class];
    browser.selectedIndex = indexPath.row;
    [browser showWithViewController:self];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat kSCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake((kSCREEN_WIDTH - 60)/3.0, (kSCREEN_WIDTH - 60)/3.0);
}

//设置垂直间距,默认的垂直和水平间距都是10
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}


/**
 图片的个数
 */
- (NSInteger)numberOfPhotosInPhotoBrowser:(PhotoBrowser *)photoBrowser{
    return self.dataSource.count;
}

/**
 图片的URL
 支持本地和远程两种URL
 */
- (NSString *)photoBrowser:(PhotoBrowser *)photoBrowser imageUrlForIndex:(NSInteger)index{
    return self.dataSource[index];
}

/**
 设置占位图片
 @discussion 必须设置，不然在视图没加载出来之前无法显示
 */
-(UIImage *)photoBrowser:(PhotoBrowser *)photoBrowser placeholderImageForIndex:(NSInteger)index{
    NSString *name = [NSString stringWithFormat:@"%zd.jpg",index%7];
    return [UIImage imageNamed:name];
}


/**
 如果需要缩放弹出 需要提供原来的view视图
 */
- (UIImageView *)photoBrowser:(PhotoBrowser *)photoBrowser sourceViewForIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    MyCollectionViewCell *cell = (MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    return cell.imageView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
