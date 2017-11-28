//
//  CustomCollectionViewLayout.m
//  testBezierPJ
//
//  Created by aKerdi on 2017/11/28.
//  Copyright © 2017年 xxtstudio. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@implementation CustomCollectionViewLayout
//准备方法被自动调用，以保证layout实例的正确。
- (void)prepareLayout {
    [super prepareLayout];
}
//返回collectionView的内容的尺寸
- (CGSize)collectionViewContentSize {
    return [super collectionViewContentSize];
}
/*
 1.返回rect中的所有的元素的布局属性
 2.返回的是包含UICollectionViewLayoutAttributes的NSArray
 3.UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
 1)layoutAttributesForCellWithIndexPath:
 2)layoutAttributesForSupplementaryViewOfKind:withIndexPath:
 3)layoutAttributesForDecorationViewOfKind:withIndexPath:
 */
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [super layoutAttributesForElementsInRect:rect];
}
//返回对应于indexPath的位置的cell的布局属性
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

//返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    return [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
}
//当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

@end
