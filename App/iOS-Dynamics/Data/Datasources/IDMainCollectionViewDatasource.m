//
//  IDMainCollectionViewDatasource.m
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/5/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

#import "IDMainCollectionViewDatasource.h"

static NSString * const kIDMainCollectionViewCellReuseIdentifier = @"Cell";

@interface IDMainCollectionViewDatasource ()

@end

@implementation IDMainCollectionViewDatasource

- (void)setMainDataCollectionView:(UICollectionView *)mainDataCollectionView
{
    // TODO: Set to custom cell
    [mainDataCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kIDMainCollectionViewCellReuseIdentifier];
    _mainDataCollectionView = mainDataCollectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 500; // TODO: Figure this out
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIDMainCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.227 green:0.340 blue:1.000 alpha:1.000];
    return cell;
}

@end
