//
//  CircleLayout.m
//  TestCollectionLayout
//
//  Created by aKerdi on 2017/11/28.
//  Copyright © 2017年 XXT. All rights reserved.
//

#import "CircleLayout.h"

@interface CircleLayout ()

@property (nonatomic, strong) NSMutableArray *attrsArr;

@end

@implementation CircleLayout
//http://www.jianshu.com/p/83e31a2f18d9
- (void)prepareLayout {
    [super prepareLayout];
    
    [self.attrsArr removeAllObjects];
    [self createAttributes];
}

- (void)createAttributes {
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    /*
     因为不是继承流水布局 UICollectionViewFlowLayout
     所以我们需要自己创建 UICollectionViewLayoutAttributes
     */
    
    //如果是多组的话 需要2层循环
    for (int i=0; i<count; i++) {
        //创建UICollectionViewLayoutAttributes
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attributes];
    }
}

- (nullable NSArray <__kindof UICollectionViewLayoutAttributes *>*)layoutAttributesForElementsInRect:(CGRect)rect {
    //TODO:  特别注意 在这个方法里 可以边滑动边刷新（添加） attrs 一劳永逸 如果只需要添加一次的话  可以把这些 prepareLayout方法中去
    return self.attrsArr;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat angle = 2*M_PI / count *indexPath.item;
    
    CGFloat radius = 100;
    
    CGFloat Ox = self.collectionView.frame.size.width/2;
    CGFloat Oy = self.collectionView.frame.size.height/2;
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.center = CGPointMake(Ox+radius*sin(angle), Oy+radius*cos(angle));
    if (count==1) {
        attributes.size = CGSizeMake(200, 200);
    } else {
        attributes.size = CGSizeMake(50, 50);
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
