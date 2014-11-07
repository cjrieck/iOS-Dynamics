//
//  IDMainCollectionViewDatasource.m
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/5/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

#import "IDMainCollectionViewDatasource.h"
#import "IDRandomImageViewApplicator.h"
#import "IDMainMenuCollectionViewCell.h"

static NSString * const kIDMainCollectionViewCellReuseIdentifier = @"Cell";

@interface IDMainCollectionViewDatasource () <IDRandomImageViewGetterDelegate>

@property (strong, nonatomic) IDRandomImageViewApplicator *imageViewGetter;

@end

@implementation IDMainCollectionViewDatasource

- (instancetype)init {
    self = [super init];
    if ( self ) {
        _imageViewGetter = [[IDRandomImageViewApplicator alloc] initWithDelegate:self];
    }
    return self;
}

- (void)setMainDataCollectionView:(UICollectionView *)mainDataCollectionView
{
    // TODO: Set to custom cell
    [mainDataCollectionView registerClass:[IDMainMenuCollectionViewCell class] forCellWithReuseIdentifier:kIDMainCollectionViewCellReuseIdentifier];
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
    IDMainMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIDMainCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.227 green:0.340 blue:1.000 alpha:1.000];
    cell.clipsToBounds = YES;
    cell.layer.opacity = 0.0f;
    [self.imageViewGetter applyRandomImageViewOnCell:cell];
    return cell;
}

#pragma mark - IDRandomImageViewGetter delegate

- (void)imageDidFinishLoadingWithCell:(UICollectionViewCell *)cell
{
    // TODO: Animate the cell to appear
    [UIView animateWithDuration:1.0f animations:^{
        cell.layer.opacity = 1.0f;
    }];
}

@end
