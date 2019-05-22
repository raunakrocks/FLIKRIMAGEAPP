//
//  ImageCell.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 20/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageCell.h"
#import "UIView+AutoLayout.h"

@implementation ImageCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupViews {
    self.imageView = [UIImageView withAutolayout];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color = [UIColor blackColor];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.activityIndicator];
    [self addSubview:self.imageView];
    [self addSubview:self.activityIndicator];
}

- (void)setupConstraints {
    NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray array];
    //image view constraints
    [constraints addObject: [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor]];
    [constraints addObject: [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]];
    [constraints addObject: [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor]];
    [constraints addObject: [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]];
    //activity indicator constraints
    [constraints addObject: [self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]];
    [constraints addObject: [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]];
    [NSLayoutConstraint activateConstraints:constraints];
}

@end
