//
//  IDRandomImageViewApplicator.m
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/7/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

#import "IDRandomImageViewApplicator.h"

@interface IDRandomImageViewApplicator ()

@property (weak, nonatomic) id<IDRandomImageViewApplicatorDelegate>delegate;

@property (strong, nonatomic) NSMutableArray *imagesArray;

@end

@implementation IDRandomImageViewApplicator

- (instancetype)initWithDelegate:(id<IDRandomImageViewApplicatorDelegate>)delegate {
    NSParameterAssert(delegate);
    
    self = [super init];
    if ( self ) {
        _delegate = delegate;
        _imagesArray = [[NSMutableArray alloc] init];
        
        // This is arbitrary. Chose 5 random pictures from the internet to use
        for (int i = 1; i <= 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"img%i", i];
            UIImage *image = [UIImage imageNamed:imageName];
            [_imagesArray addObject:image];
        }
        
        srand48(time(0)); // initial seed for random time generator
    }
    return self;
}

#pragma mark - Private methods

- (NSInteger)generateRandomNumberWithLowerBound:(NSInteger)lower upperBound:(NSInteger)upper
{
    return ( (arc4random() % (upper-lower)) + lower ); // This is an implementation for a non-inclusive upper bound random number generator
}

- (double)generateRandomDelayTimeWithFactor:(double)factor
{
    return drand48() * factor;
}

#pragma mark - Public methods

- (void)applyRandomImageViewOnCell:(UICollectionViewCell *)cell
{
    NSParameterAssert(cell);
    
    NSInteger randomIndex = [self generateRandomNumberWithLowerBound:0 upperBound:self.imagesArray.count];
    UIImage *randomImage = [self.imagesArray objectAtIndex:randomIndex];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:randomImage];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.transform = CGAffineTransformMakeScale(4.0f, 4.0f);
    imageView.center = cell.contentView.center;
    [cell.contentView addSubview:imageView];
    
    const double timeFactor = 10.0f; // This will keep the random time down to single digit seconds
    double delayInSeconds = [self generateRandomDelayTimeWithFactor:timeFactor];
    [self.delegate imageFinishedApplyingOnCell:cell withDelay:delayInSeconds];
}

@end
