//
//  UIView+AutoLayout.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 20/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)
+ (id)withAutolayout
{
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}
@end
