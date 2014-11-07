//
//  IDRandomImageViewGetter.m
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/7/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

#import "IDRandomImageViewApplicator.h"

@interface IDRandomImageViewApplicator ()

@property (strong, nonatomic) NSMutableArray *imagesArray;

@end

@implementation IDRandomImageViewApplicator

- (instancetype)initWithDelegate:(id<IDRandomImageViewGetterDelegate>)delegate {
    self = [super init];
    if ( self ) {
        _delegate = delegate;
        _imagesArray = [[NSMutableArray alloc] init];
        
        // This is arbitrary. Chose 5 random picture from the internet to use
        for (int i = 0; i < 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"img%i", i+1];
            UIImage *image = [UIImage imageNamed:imageName];
            [_imagesArray addObject:image];
        }
    }
    return self;
}

- (NSInteger)generateRandomNumberWithLowerBound:(NSInteger)lower upperBound:(NSInteger)upper
{
    return ( (arc4random() % (upper-lower)) + lower ); // This is an implementation for a non-inclusive upper bound random number generator
}

- (void)applyRandomImageViewOnCell:(UICollectionViewCell *)cell
{
    // TODO: Delay this for random amount of time if setting switched on
    NSInteger randomIndex = [self generateRandomNumberWithLowerBound:0 upperBound:self.imagesArray.count];
    UIImage *randomImage = [self.imagesArray objectAtIndex:randomIndex];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:randomImage];
    [cell.contentView addSubview:imageView];
    
    [self.delegate imageDidFinishLoadingWithCell:cell];
}

@end
