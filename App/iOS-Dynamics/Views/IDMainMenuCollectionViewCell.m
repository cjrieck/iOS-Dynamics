//
//  IDMainMenuCollectionViewCell.m
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/7/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

#import "IDMainMenuCollectionViewCell.h"

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
        
        const CGFloat strokeWidth = 3.0f;
        const CGFloat radius = CGRectGetWidth(frame) / 2.0f;
        self.layer.cornerRadius = radius;
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:radius];
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.path = circlePath.CGPath;
        circleLayer.frame = CGPathGetBoundingBox(circleLayer.path);
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeColor = [UIColor whiteColor].CGColor;
        circleLayer.lineWidth = strokeWidth;
        
        CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        drawAnimation.duration = 1.0f;
        drawAnimation.fromValue = [NSNumber numberWithFloat:0.1f];
        drawAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [rotateAnimation setByValue:[NSNumber numberWithFloat:M_PI*2.0f]];
        rotateAnimation.duration = 2.0f;
        rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0f];
        rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [self.layer addSublayer:circleLayer];
        _circleLayer = circleLayer;
        _drawAnimation = drawAnimation;
        _rotateAnimation = rotateAnimation;
    }
    return self;
}

- (void)drawLoadingIndicatorForLength:(double)repeatInterval
{
    self.drawAnimation.repeatCount = ceil(repeatInterval);
    self.rotateAnimation.repeatCount = ceil(repeatInterval/self.rotateAnimation.duration);
    [self.circleLayer addAnimation:self.drawAnimation forKey:nil];
    [self.circleLayer addAnimation:self.rotateAnimation forKey:nil];
}

- (void)stopLoadingIndicator
{
    [self.circleLayer removeAllAnimations];
}

@end
