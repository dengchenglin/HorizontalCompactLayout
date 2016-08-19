//
//  ViewController.m
//  HorizontalCompactView
//
//  Created by peikua on 16/8/19.
//  Copyright © 2016年 peikua. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalCompactLayout.h"
#import "CollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,copy)  NSArray *dataSoures;
@end

@implementation ViewController
- (void)awakeFromNib{
    [super awakeFromNib];
    self.dataSoures = @[@"一款",@"基于UICollectionView",@"横向紧凑",@"布局的",@"控件，",@"创建原因:",@"系统默认的布局",@"每排横向布满的情况下",@"横向间隙是",@"平均分配的",@"这时通过",@"UICollectionViewDelegateFlowLayout",@"设置的",@"横间隙",@"是无效的。",@"而该布局方式",@"则解决这一问题",@"只需要将的系统的",@"UICollectionViewFlowLayout",@"替换成",@"HorizontalCompactLayout",@"就可以了。"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    HorizontalCompactLayout *layout = [HorizontalCompactLayout new];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSoures.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *text = self.dataSoures[indexPath.row];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(320, 16)];
    return CGSizeMake(size.width + 1, 16);
}

//横间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//竖间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.label.text = self.dataSoures[indexPath.row];
    return cell;
}

@end
