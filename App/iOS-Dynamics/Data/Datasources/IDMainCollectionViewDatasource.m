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

static const double kIDCellAppearanceAnimationTime               = 0.75f;

@interface IDMainCollectionViewDatasource () <IDRandomImageViewGetterDelegate>

@property (strong, nonatomic) IDRandomImageViewApplicator *imageViewApplicator;

@property (assign, nonatomic) BOOL loadDelayEnabled;

@end

@implementation IDMainCollectionViewDatasource

- (instancetype)init {
    self = [super init];
    if ( self ) {
        _imageViewApplicator = [[IDRandomImageViewApplicator alloc] initWithDelegate:self];
        _loadDelayEnabled = NO;
    }
    return self;
}

- (void)setMainDataCollectionView:(UICollectionView *)mainDataCollectionView
{
    [mainDataCollectionView registerClass:[IDMainMenuCollectionViewCell class] forCellWithReuseIdentifier:kIDMainCollectionViewCellReuseIdentifier];
    _mainDataCollectionView = mainDataCollectionView;
}

- (void)switchLoadDelaySetting
{
    [self.mainDataCollectionView reloadData];
    self.loadDelayEnabled = !self.loadDelayEnabled;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100; // TODO: Figure this out
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IDMainMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIDMainCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.clipsToBounds = YES;
    cell.contentView.layer.opacity = 0.0f;
    [self.imageViewApplicator applyRandomImageViewOnCell:cell];
    return cell;
}

- (void)imageFinishedApplyingOnCell:(IDMainMenuCollectionViewCell *)cell withDelay:(double)delay
{
    if ( !self.loadDelayEnabled ) {
        delay = 0.0f;
    }
    [cell drawLoadingIndicatorForLength:delay];
    
    [UIView animateWithDuration:kIDCellAppearanceAnimationTime
                          delay:delay
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.layer.opacity = 1.0f;
                     }
                     completion:^(BOOL finished){
                         [cell stopLoadingIndicator];
                     }];
}

@end
