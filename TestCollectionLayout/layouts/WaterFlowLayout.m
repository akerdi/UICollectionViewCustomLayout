//
//  WaterFlowLayout.m
//  TestCollectionLayout
//
//  Created by aKerdi on 2017/11/28.
//  Copyright © 2017年 XXT. All rights reserved.
//

#import "WaterFlowLayout.h"

static const NSInteger DefaultColumnCount = 3;
static const CGFloat DefaultColumnMargin = 10;
static const CGFloat DefaultRowMargin = 10;
static const UIEdgeInsets DefaultEdgeInsets = {10, 10, 10, 10};

@interface WaterFlowLayout ()
@property (nonatomic, strong) NSMutableArray *attributesArray;
@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, assign) CGFloat contentHeight;

- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInset;

@end

@implementation WaterFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.contentHeight = 0;
    [self.columnHeights removeAllObjects];
    
    for (NSInteger i=0; i<self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInset.top)];
    }
    
    [self.attributesArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArray addObject:attributes];
    }
}

- (nullable NSArray <__kindof UICollectionViewLayoutAttributes *>*)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    CGFloat width = (collectionViewWidth - self.edgeInset.left - self.edgeInset.right - (self.columnCount-1)*self.columnMargin) / self.columnCount;
    CGFloat height = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.row itemWidth:width];
    
    NSInteger indexColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i=1; self.columnCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight>columnHeight) {
            minColumnHeight = columnHeight;
            indexColumn = i;
        }
    }
    
    CGFloat x = self.edgeInset.left + indexColumn*(width+self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y !=self.edgeInset.top) {
        y +=self.rowMargin;
    }
    attributes.frame = CGRectMake(x, y, width, height);
    
    self.columnHeights[indexColumn] = @(CGRectGetMaxY(attributes.frame));
    
    CGFloat columnHeight = [self.columnHeights[indexColumn] doubleValue];
    if (self.contentHeight<columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attributes;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight+self.edgeInset.bottom);
}

#pragma mark - Accessory

- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    }
    return DefaultRowMargin;
}

- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    }
    return DefaultColumnMargin;
}

- (NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    }
    return DefaultColumnCount;
}

- (UIEdgeInsets)edgeInset {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    }
    return DefaultEdgeInsets;
}

- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _columnHeights;
}


@end
