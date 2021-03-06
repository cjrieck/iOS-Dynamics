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

@interface IDMainCollectionViewDatasource () <IDRandomImageViewApplicatorDelegate>

@property (strong, nonatomic) IDRandomImageViewApplicator *imageViewApplicator;
@property (assign, nonatomic) BOOL loadDelayEnabled;

@end

@implementation IDMainCollectionViewDatasource

- (instancetype)init {
    self = [super init];
    if ( self ) {
        _imageViewApplicator = [[IDRandomImageViewApplicator alloc] initWithDelegate:self];
        _loadDelayEnabled = NO; // always set delayed simulation to 'off' on restart. Could have persisted in NSUserDefaults, but not relavent for this demo
    }
    return self;
}

- (void)setMainDataCollectionView:(UICollectionView *)mainDataCollectionView
{
    [mainDataCollectionView registerClass:[IDMainMenuCollectionViewCell class] forCellWithReuseIdentifier:kIDMainCollectionViewCellReuseIdentifier];
    _mainDataCollectionView = mainDataCollectionView;
}

# pragma mark - UICollectionView datasource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Arbitrary number for demo purposes
    // NOTE: Number can be as big as you like with very little performance hit.
    // Cells are reused and UIKit Dynamic behaviors are only applied to visible cells
    return 1000;
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

#pragma mark - Public methods

- (void)switchLoadDelaySetting
{
    [self.mainDataCollectionView reloadData];
    self.loadDelayEnabled = !self.loadDelayEnabled;
}

#pragma mark - IDRandomImageViewSetter delegate

- (void)imageFinishedApplyingOnCell:(IDMainMenuCollectionViewCell *)cell withDelay:(double)delay
{
    if ( !self.loadDelayEnabled ) {
        delay = 0.0f;
    }
    
    UIImageView *imageViewToTransform = [cell.contentView.subviews lastObject];

    [cell drawLoadingIndicatorForLength:delay];
    [UIView animateWithDuration:kIDCellAppearanceAnimationTime
                          delay:delay
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         imageViewToTransform.transform = CGAffineTransformIdentity;
                         cell.contentView.layer.opacity = 1.0f;
                     }
                     completion:nil];
}

@end
