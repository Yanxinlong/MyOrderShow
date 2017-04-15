//
//  DAPageIndicatorView.m
//  DAPagesContainerScrollView
//
//  Created by Daria Kopaliani on 5/29/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DAPageIndicatorView.h"


@implementation DAPageIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        _color = [UIColor blackColor];
        self.backgroundColor = _color;
    }
    return self;
}

#pragma mark - Public

- (void)setColor:(UIColor *)color
{
    
    _color = color;
    self.backgroundColor = _color;
    
}

#pragma mark - Private



@end