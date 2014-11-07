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

@end

@implementation IDMainMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ) {
        
        const CGFloat radius = frame.size.width / 2.0f;
        self.layer.cornerRadius = radius;
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:radius];
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.path = circlePath.CGPath;
        circleLayer.frame = CGPathGetBoundingBox(circleLayer.path);
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeColor = [UIColor whiteColor].CGColor;
        circleLayer.lineWidth = 2.0f;
        
        CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        drawAnimation.duration = 1.0f;
        drawAnimation.repeatCount = 5.0f;
        
        drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        drawAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        [self.layer addSublayer:circleLayer];
        [circleLayer addAnimation:drawAnimation forKey:nil];        
    }
    return self;
}

@end
