//
//  IDSpringFlowLayout.m
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/6/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

#import "IDSpringFlowLayout.h"

static const CGFloat kIDScrollResistanceFactor = 900.0f;

@interface IDSpringFlowLayout ()

@property (strong, nonatomic) UIDynamicAnimator *springAnimator;
@property (strong, nonatomic) NSMutableSet *visibleIndexPaths;
@property (assign, nonatomic) CGFloat lastDelta;

@end

@implementation IDSpringFlowLayout

- (instancetype)init {
    self = [super init];
    if ( self ) {
        self.minimumLineSpacing = 10.0f;
        self.minimumInteritemSpacing = 5.0f;
        self.itemSize = CGSizeMake(90, 90);
        self.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
        
        _springAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        _visibleIndexPaths = [NSMutableSet set];
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    CGRect visibleRect = CGRectInset((CGRect){.origin = self.collectionView.bounds.origin, .size = self.collectionView.frame.size}, -100, -100);
    NSArray *itemsInVisibleRect = [super layoutAttributesForElementsInRect:visibleRect];
    
    NSSet *itemsInVisibleRectSet = [NSSet setWithArray:[itemsInVisibleRect valueForKey:@"indexPath"]];
    
    // Create an array of behaviors that aren't visible using the set of visible index path
    NSArray *hiddenBehaviors = [self.springAnimator.behaviors filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIAttachmentBehavior *behavior, NSDictionary *bindings){
        BOOL currentlyVisible = [itemsInVisibleRectSet containsObject:[[[behavior items] firstObject] indexPath]] == NO;
        return currentlyVisible;
    }]];
    
    // Iterate over hiddenBehaviors and remove them from the dynamic animator and visible index path set
    for (id obj in hiddenBehaviors) {
        [self.springAnimator removeBehavior:obj];
        [self.visibleIndexPaths removeObject:[[[obj items] lastObject] indexPath]];
    };
    
    // Create array of visible items now using the visibleIndexPaths set
    NSArray *newlyVisibleItems = [itemsInVisibleRect filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *item, NSDictionary *bindings){
        BOOL currentlyVisible = [self.visibleIndexPaths containsObject:item.indexPath] == NO;
        return currentlyVisible;
    }]];
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    for (UICollectionViewLayoutAttributes *item in newlyVisibleItems) {
        CGPoint itemCenter = item.center;
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:itemCenter];
        
        springBehavior.length = 1.0f;
        springBehavior.damping = 0.8f;
        springBehavior.frequency = 1.0f;
        
        if (!CGPointEqualToPoint(CGPointZero, touchLocation)) {
            CGFloat distanceFromTouch = fabsf(touchLocation.y - springBehavior.anchorPoint.y);
            CGFloat scrollResistance = distanceFromTouch / kIDScrollResistanceFactor;
            
            if ( self.lastDelta < 0 ) {
                itemCenter.y += MAX(self.lastDelta, self.lastDelta * scrollResistance);
            }
            else {
                itemCenter.y += MIN(self.lastDelta, self.lastDelta * scrollResistance);
            }
            
            item.center = itemCenter;
        }
        
        [self.springAnimator addBehavior:springBehavior];
        [self.visibleIndexPaths addObject:item.indexPath];
    };
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.springAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.springAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    self.lastDelta = delta;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    for (UIAttachmentBehavior *behavior in self.springAnimator.behaviors) {
        CGFloat distanceFromTouch = fabsf(touchLocation.y - behavior.anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / kIDScrollResistanceFactor;
        
        UICollectionViewLayoutAttributes *item = [behavior.items firstObject];
        CGPoint itemCenter = item.center;
        
        if ( delta < 0 ) {
            itemCenter.y += MAX(delta, delta * scrollResistance);
        }
        else {
            itemCenter.y += MIN(delta, delta * scrollResistance);
        }
        
        item.center = itemCenter;
        [self.springAnimator updateItemUsingCurrentState:item];
    };
    
    return NO;
}

@end
