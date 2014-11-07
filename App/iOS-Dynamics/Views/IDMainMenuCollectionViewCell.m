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

//        _circleLayer = [CAShapeLayer layer];
//        _circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius].CGPath;
//        _circleLayer.position = CGPointMake(CGRectGetMidX(frame)-radius, CGRectGetMidY(frame)-radius);
//        
//        _circleLayer.fillColor = [UIColor clearColor].CGColor;
//        _circleLayer.strokeColor = [UIColor whiteColor].CGColor;
//        _circleLayer.lineWidth = 2.0f;
//        
//        _drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        _drawAnimation.duration = 2.5f;
//        _drawAnimation.repeatCount = 5.0f;
//        
//        _drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//        _drawAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//        _drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//        
//        [self.contentView.layer addSublayer:_circleLayer];
//        
//        [self beginLoadingAnimation];
    }
    return self;
}



//- (void)beginLoadingAnimation
//{
//    [self.circleLayer addAnimation:self.drawAnimation forKey:@"drawCircleAnimation"];
//}

@end
