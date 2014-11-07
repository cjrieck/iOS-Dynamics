//
//  ViewController.m
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/5/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

#import "IDRootViewController.h"
#import "IDMainCollectionViewDatasource.h"
#import "IDSpringFlowLayout.h"

@interface IDRootViewController ()

@property (strong, nonatomic) IDMainCollectionViewDatasource *mainCollectionViewDataSource;

@property (weak, nonatomic) UICollectionView *mainMenuCollectionView;

@end

@implementation IDRootViewController

- (instancetype)init {
    self = [super init];
    if ( self ) {
        _mainCollectionViewDataSource = [[IDMainCollectionViewDatasource alloc] init];
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CAGradientLayer *gradientBackground = [CAGradientLayer layer];
    gradientBackground.frame = self.view.bounds;
    gradientBackground.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0.322 green:0.929 blue:0.78 alpha:1].CGColor, (id)[UIColor colorWithRed:0.353 green:0.784 blue:0.984 alpha:1].CGColor, nil];
    [self.view.layer addSublayer:gradientBackground];
    
    IDSpringFlowLayout *mainCollectionViewLayout = [[IDSpringFlowLayout alloc] init];
    UICollectionView *mainMenuCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:mainCollectionViewLayout];
    mainMenuCollectionView.backgroundColor = [UIColor clearColor];
    
    self.mainCollectionViewDataSource.mainDataCollectionView = mainMenuCollectionView;
    
    mainMenuCollectionView.dataSource = self.mainCollectionViewDataSource;
    [self.view addSubview:mainMenuCollectionView];
    _mainMenuCollectionView = mainMenuCollectionView;
}

@end
