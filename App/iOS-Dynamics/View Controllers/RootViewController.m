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

- (void)loadView {
    [super loadView];
    
    UICollectionViewLayout *mainCollectionViewLayout = [[UICollectionViewLayout alloc] init];
    UICollectionView *mainMenuCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:mainCollectionViewLayout];
    // TODO: Set delegate (may not be needed) and datasource
    [self.view addSubview:mainMenuCollectionView];
    _mainMenuCollectionView = mainMenuCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor]; // maybe put gradient here?
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
