//
//  CollectionViewCell.m
//  TestCollectionLayout
//
//  Created by aKerdi on 2017/11/28.
//  Copyright © 2017年 XXT. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 0.5;
}

@end
