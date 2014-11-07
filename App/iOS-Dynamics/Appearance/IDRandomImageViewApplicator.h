//
//  IDRandomImageViewGetter.h
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/7/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

@protocol IDRandomImageViewGetterDelegate <NSObject>

- (void)imageDidFinishLoadingWithCell:(UICollectionViewCell *)cell;

@end

@interface IDRandomImageViewApplicator : NSObject

@property (weak, nonatomic)id<IDRandomImageViewGetterDelegate>delegate;

- (instancetype)initWithDelegate:(id<IDRandomImageViewGetterDelegate>)delegate;
- (void)applyRandomImageViewOnCell:(UICollectionViewCell *)cell;

@end
