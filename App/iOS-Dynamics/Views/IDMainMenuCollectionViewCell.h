//
//  IDMainMenuCollectionViewCell.h
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/7/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

@interface IDMainMenuCollectionViewCell : UICollectionViewCell

- (void)drawLoadingIndicatorForLength:(double)repeatInterval;
- (void)stopLoadingIndicator;

@end
