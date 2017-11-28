//
//  CustomCollectionLayoutController.m
//  testBezierPJ
//
//  Created by aKerdi on 2017/11/28.
//  Copyright © 2017年 xxtstudio. All rights reserved.
//

#import "CustomCollectionLayoutController.h"

#import "CollectionViewCell.h"

#import "CustomFlowLayout.h"
#import "CustomFlowLayout2.h"
#import "CircleLayout.h"
#import "SquareLayout.h"

@interface CustomCollectionLayoutController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CustomCollectionLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CustomFlowLayout2 *flowLayout = [CustomFlowLayout2 new];
    CircleLayout *flowLayout = [CircleLayout new];
//    SquareLayout *flowLayout = [SquareLayout new];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%ld %ld",indexPath.section,indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
