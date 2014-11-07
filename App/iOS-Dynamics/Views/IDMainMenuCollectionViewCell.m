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
        NSLog(@"%@", NSStringFromCGRect(frame));
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.frame = frame;
        circleLayer.fillColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:circleLayer];
        
        
        
        
        
        
        
        
        
        
//        _circleLayer = [CAShapeLayer layer];
//        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
////        [borderPath moveToPoint:CGPointMake(CGRectGetMidX(frame)-radius, CGRectGetMidY(frame)-radius)];
////        [borderPath moveToPoint:CGPointMake(0.0, 0.0)	];
//        _circleLayer.frame = CGRectMake(0, 0, 2.0*radius, 2.0*radius);
//        _circleLayer.path = borderPath.CGPath;
////        _circleLayer.position = CGPointMake(CGRectGetMidX(frame)-radius, CGRectGetMidY(frame)-radius);
//        _circleLayer.position = self.center;
//        _circleLayer.fillColor = [UIColor clearColor].CGColor;
//        _circleLayer.strokeColor = [UIColor whiteColor].CGColor;
//        _circleLayer.lineWidth = 10.0f;
//        
//        _drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        _drawAnimation.duration = 5.5f;
//        _drawAnimation.repeatCount = 5.0f;
//        
//        _drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//        _drawAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//        _drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//        
//        [self.layer addSublayer:_circleLayer];
        
        [self beginLoadingAnimation];
    }
    return self;
}



- (void)beginLoadingAnimation
{
    [self.circleLayer addAnimation:self.drawAnimation forKey:nil];
}

@end
