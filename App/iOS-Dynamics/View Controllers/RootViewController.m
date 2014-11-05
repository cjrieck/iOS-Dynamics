//
//  ViewController.m
//  iOS-Dynamics
//
//  Created by Clayton Rieck on 11/5/14.
//  Copyright (c) 2014 Clayton Rieck. All rights reserved.
//

#import "RootViewController.h"
#import "IDMainCollectionViewDatasource.h"

@interface RootViewController ()

@property (strong, nonatomic) IDMainCollectionViewDatasource *mainCollectionViewDataSource;

@property (weak, nonatomic) UICollectionView *mainMenuCollectionView;

@end

@implementation RootViewController

- (instancetype)init {
    self = [super init];
    if ( self ) {
        _mainCollectionViewDataSource = [[IDMainCollectionViewDatasource alloc] init];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    UICollectionViewFlowLayout *mainCollectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    mainCollectionViewLayout.itemSize = CGSizeMake(30, 30);
    
    UICollectionView *mainMenuCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:mainCollectionViewLayout];
    mainMenuCollectionView.backgroundColor = [UIColor whiteColor]; // maybe put a gradient here?
    
    self.mainCollectionViewDataSource.mainDataCollectionView = mainMenuCollectionView;
    
    mainMenuCollectionView.dataSource = self.mainCollectionViewDataSource;
    [self.view addSubview:mainMenuCollectionView];
    _mainMenuCollectionView = mainMenuCollectionView;
}

@end
