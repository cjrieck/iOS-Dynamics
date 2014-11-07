//
//  IDRandomImageViewGetter.h
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/7/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

@protocol IDRandomImageViewGetterDelegate <NSObject>

- (void)imageFinishedApplyingOnCell:(UICollectionViewCell *)cell withDelay:(double)delay;

@end

@interface IDRandomImageViewApplicator : NSObject

- (instancetype)initWithDelegate:(id<IDRandomImageViewGetterDelegate>)delegate;

- (void)applyRandomImageViewOnCell:(UICollectionViewCell *)cell;

@end

@interface IDRandomImageViewApplicator (IDUnavailable)

- (instancetype)init __attribute__((unavailable("Use initWithDelegate: instead")));

@end