//
//  CustomFlowLayout2.m
//  TestCollectionLayout
//
//  Created by aKerdi on 2017/11/28.
//  Copyright © 2017年 XXT. All rights reserved.
//

#import "CustomFlowLayout2.h"

@implementation CustomFlowLayout2
//http://www.jianshu.com/p/a16ffb4bbcc2
- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(150, 150);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.minimumLineSpacing = 50;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.frame.size.width/2 + proposedContentOffset.x;
    
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attributes in array) {
        if (ABS(minDelta)>ABS(attributes.center.x-centerX)) {
            minDelta = attributes.center.x - centerX;
        }
    }
    proposedContentOffset.x +=minDelta;
    return proposedContentOffset;
}

- (nullable NSArray <__kindof UICollectionViewLayoutAttributes *>*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2.0;
    for (UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat delta = ABS(attributes.center.x - centerX);
        CGFloat scale = 1-delta/self.collectionView.frame.size.width;
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
