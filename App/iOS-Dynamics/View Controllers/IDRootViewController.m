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

static NSString * const kIDRootViewControllerTitle = @"iOS Animations";
static NSString * const kIDDelaySettingButtonTitleOff = @"Delay: Off"; // set it to 'Off' because we don't store setting value in NSSUserDefaults and will get reset on each launch
static NSString * const kIDDelaySettingButtonTitleOn = @"Delay: On";

@interface IDRootViewController ()

@property (strong, nonatomic) IDMainCollectionViewDatasource *mainCollectionViewDataSource;

@property (weak, nonatomic) UIBarButtonItem *delaySettingButton;
@property (weak, nonatomic) UICollectionView *mainMenuCollectionView;

@end

@implementation IDRootViewController

- (instancetype)init {
    self = [super init];
    if ( self ) {
        self.title = kIDRootViewControllerTitle;
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
    
    [self setupMotionEffectOnView:mainMenuCollectionView];
    [self.view addSubview:mainMenuCollectionView];
    _mainMenuCollectionView = mainMenuCollectionView;
    
    UIBarButtonItem *delaySettingButton = [[UIBarButtonItem alloc] initWithTitle:kIDDelaySettingButtonTitleOff
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(switchDelaySimulation)];
    self.navigationItem.rightBarButtonItem = delaySettingButton;
    _delaySettingButton = delaySettingButton;
}

- (void)setupMotionEffectOnView:(UIView *)targetView
{
    const NSValue *minimumMotionMovement = @(-20);
    const NSValue *maximumMotionMovement = @(20);
    
    UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = minimumMotionMovement;
    horizontalMotionEffect.maximumRelativeValue = maximumMotionMovement;
 
    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = minimumMotionMovement;
    verticalMotionEffect.maximumRelativeValue = maximumMotionMovement;
    
    UIMotionEffectGroup *motionEffectsGroup = [UIMotionEffectGroup new];
    motionEffectsGroup.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    [targetView addMotionEffect:motionEffectsGroup];
}

- (void)switchDelaySimulation
{
    if ( [self.delaySettingButton.title isEqualToString:kIDDelaySettingButtonTitleOn] ) {
        self.delaySettingButton.title = kIDDelaySettingButtonTitleOff;
    }
    else {
        self.delaySettingButton.title = kIDDelaySettingButtonTitleOn;
    }
    [self.mainCollectionViewDataSource switchLoadDelaySetting];
}

@end
