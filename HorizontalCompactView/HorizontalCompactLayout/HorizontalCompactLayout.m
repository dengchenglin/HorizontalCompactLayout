//
//  HorizontalCompactLayout.m
//  HorizontalCompactView
//
//  Created by peikua on 16/8/19.
//  Copyright © 2016年 peikua. All rights reserved.
//

#import "HorizontalCompactLayout.h"

@implementation HorizontalCompactLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}
-(void)prepareLayout
{
    [super prepareLayout];
    
}
-(CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 1; i < attributes.count; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        NSInteger maximumSpacing = self.minimumInteritemSpacing;
        if((id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate && [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]){
            maximumSpacing = [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:currentLayoutAttributes.indexPath.section];
        }
        
        UIEdgeInsets inset = self.sectionInset;
        if((id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate && [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]){
            inset = [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:currentLayoutAttributes.indexPath.section];
        }
        
        //核心代码
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        if((origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width - inset.left - inset.right) && (prevLayoutAttributes.indexPath.section == currentLayoutAttributes.indexPath.section)) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    
    return attributes;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    return attributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}
@end
