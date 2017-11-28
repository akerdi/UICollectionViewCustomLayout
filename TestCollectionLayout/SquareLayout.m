//
//  SquareLayout.m
//  TestCollectionLayout
//
//  Created by aKerdi on 2017/11/28.
//  Copyright © 2017年 XXT. All rights reserved.
//

#import "SquareLayout.h"

@interface SquareLayout ()
@property (nonatomic, strong) NSMutableArray *attrsArr;
@end

@implementation SquareLayout
//http://www.jianshu.com/p/58e06e1f2f6d

- (void)prepareLayout {
    [super prepareLayout];
    
    [self.attrsArr removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attributes];
    }
}

- (nullable NSArray <__kindof UICollectionViewLayoutAttributes *>*)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArr;
}

- (CGSize)collectionViewContentSize {
    int count = (int)[self.collectionView numberOfItemsInSection:0];
    int rows = (count +3 -1)/3;
    CGFloat rowH = self.collectionView.frame.size.width/2;
    if ((count)%6==2|(count)%6==4) {
        return CGSizeMake(0, rows*rowH);//rows*rowH-rowH/2
    } else {
        return CGSizeMake(0, rows*rowH);
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.collectionView.frame.size.width*.5;
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat height = width;
    NSInteger i = indexPath.item;
    if (i==0) {
        attributes.frame = CGRectMake(0, 0, width, height);
    } else if (i==1) {
        attributes.frame = CGRectMake(width, 0, width, height/2);
    } else if (i==2) {
        attributes.frame = CGRectMake(width, height/2, width, height/2);
    } else if (i==3) {
        attributes.frame = CGRectMake(0, height, width, height/2);
    } else if (i==4) {
        attributes.frame = CGRectMake(0, height+height/2, width, height/2);
    } else if (i==5) {
        attributes.frame = CGRectMake(width, height, width, height);
    } else {
        UICollectionViewLayoutAttributes *lastAttributes = self.attrsArr[i-6];
        CGRect frame = lastAttributes.frame;
        frame.origin.y +=2*height;
        attributes.frame = frame;
    }
    return attributes;
    
}

#pragma mark - Accessory

- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        _attrsArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _attrsArr;
}

@end
