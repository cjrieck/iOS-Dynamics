//
//  IDMainMenuCollectionViewCell.m
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/7/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

#import "IDMainMenuCollectionViewCell.h"

const static CGFloat kIDFullCircularRotation = M_PI * 2.0f;

@interface IDMainMenuCollectionViewCell ()

@property (strong, nonatomic) CAShapeLayer *circleLayer;
@property (strong, nonatomic) CABasicAnimation *drawAnimation;
@property (strong, nonatomic) CABasicAnimation *rotateAnimation;

@end

@implementation IDMainMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ) {
        [self setupCellAndAnimations];
    }
    return self;
}

- (void)setupCellAndAnimations
{
    const CGFloat strokeWidth = 3.0f;
    const CGFloat loadingAnimationDuration = 1.0f;
    const CGFloat radius = CGRectGetWidth(self.frame) / 2.0f;
    self.layer.cornerRadius = radius;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:radius];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.path = circlePath.CGPath;
    circleLayer.frame = CGPathGetBoundingBox(circleLayer.path);
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1].CGColor;
    circleLayer.lineWidth = strokeWidth;
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration = loadingAnimationDuration;
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.1f];
    drawAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    drawAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.byValue = [NSNumber numberWithFloat:kIDFullCircularRotation];
    rotateAnimation.duration = loadingAnimationDuration * 2.0f;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    rotateAnimation.toValue = [NSNumber numberWithFloat:kIDFullCircularRotation];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotateAnimation.removedOnCompletion = YES;
    
    [self.layer addSublayer:circleLayer];
    _circleLayer = circleLayer;
    _drawAnimation = drawAnimation;
    _rotateAnimation = rotateAnimation;
}

#pragma mark - Public methods

- (void)drawLoadingIndicatorForLength:(double)repeatInterval
{
    self.drawAnimation.repeatCount = ceil(repeatInterval);
    self.rotateAnimation.repeatCount = ceil(repeatInterval/self.rotateAnimation.duration);
    [self.circleLayer addAnimation:self.drawAnimation forKey:@"animateStroke"];
    [self.circleLayer addAnimation:self.rotateAnimation forKey:@"animateRotation"];
}

- (void)animateSelection
{
    const CGFloat scaleFactor = 0.9f;
    const CGFloat animationDuration = 0.1f;
    const CGFloat animationDelay = 0.0f;
    
    [UIView animateWithDuration:animationDuration
                          delay:animationDelay
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
                     }
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:animationDuration
                                               delay:animationDelay
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              self.transform = CGAffineTransformIdentity;
                                          }
                                          completion:nil];
                     }];
    
}

- (void)wiggle
{
    CABasicAnimation *wiggleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    wiggleAnimation.byValue = [NSNumber numberWithFloat:kIDFullCircularRotation];
    wiggleAnimation.duration = 0.1;
    wiggleAnimation.repeatCount = 2.0f;
    wiggleAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    wiggleAnimation.toValue = [NSNumber numberWithFloat:0.1f];
    wiggleAnimation.autoreverses = YES;
    wiggleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    wiggleAnimation.removedOnCompletion = YES;
    
    [self.layer addAnimation:wiggleAnimation forKey:nil];
}

@end
