//
//  CustomFlowLayout.m
//  testBezierPJ
//
//  Created by aKerdi on 2017/11/28.
//  Copyright © 2017年 xxtstudio. All rights reserved.
//

#import "CustomFlowLayout.h"

@implementation CustomFlowLayout
- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(150, 150);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        CGFloat inset = (self.collectionView.frame.size.width-self.itemSize.width);
        self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
        
        self.minimumLineSpacing = 50.f;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(150, 150);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat inset = (self.collectionView.frame.size.width-self.itemSize.width);
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    self.minimumLineSpacing = 50.f;
}

/*
 只要手一松开就会调用
 这个方法的返回值 决定了CollectionView 停止滚动时的偏移量
 proposedContentOffset 这个是最终的 偏移量的值 但是实际的情况还是要根据返回值来定
 velocity 是滚动速率 x/y 有正负
 
 */

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.frame.size.width/2 + proposedContentOffset.x;
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attributes in array) {
        if (ABS(minDelta)>ABS(attributes.center.x-centerX)) {
            minDelta = attributes.center.x-centerX;
        }
    }
    
    proposedContentOffset.x +=minDelta;
    
    return proposedContentOffset;
}
/*
 这个方法的返回值是一个数组(数组里存放在rect 范围内所有元素的布局属性)
 这个方法的放回值 决定了rect 范围内所有元素的排布 (frame)
 */
- (nullable NSArray <__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    for (UICollectionViewLayoutAttributes *attributes in array) {
        NSLog(@"第%zd cell -- 距离： %.1f",attributes.indexPath.item, attributes.center.x-centerX);
        CGFloat delta = ABS(attributes.center.x-centerX);
        CGFloat scale = 1-delta/self.collectionView.frame.size.width;
        
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
