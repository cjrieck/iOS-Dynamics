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
    
    IDSpringFlowLayout *mainCollectionViewLayout = [[IDSpringFlowLayout alloc] init];
    UICollectionView *mainMenuCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:mainCollectionViewLayout];
    mainMenuCollectionView.backgroundColor = [UIColor blackColor]; // maybe put a gradient here?
    
    self.mainCollectionViewDataSource.mainDataCollectionView = mainMenuCollectionView;
    
    mainMenuCollectionView.dataSource = self.mainCollectionViewDataSource;
    [self.view addSubview:mainMenuCollectionView];
    _mainMenuCollectionView = mainMenuCollectionView;
}

@end
