//
//  DAPagesContainerTopBar.m
//  DAPagesContainerScrollView
//
//  Created by Daria Kopaliani on 5/29/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DAPagesContainerTopBar.h"


@interface DAPagesContainerTopBar (){
    UIButton *_currentButton;
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *itemViews;

- (void)layoutItemViews;

@end


@implementation DAPagesContainerTopBar

CGFloat const DAPagesContainerTopBarItemViewWidth = 50.0;
CGFloat const DAPagesContainerTopBarItemsOffset = 0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        self.font = [UIFont systemFontOfSize:13];
        self.selectColor = [UIColor colorWithWhite:1.0 alpha:1.];
    }
    return self;
}

#pragma mark - Public

- (CGPoint)centerForSelectedItemAtIndex:(NSUInteger)index
{
    CGPoint center = ((UIView *)self.itemViews[index]).center;
    CGPoint offset = [self contentOffsetForSelectedItemAtIndex:index];
    center.x -= offset.x - (CGRectGetMinX(self.scrollView.frame));
    return center;
}

- (CGPoint)contentOffsetForSelectedItemAtIndex:(NSUInteger)index
{
    if (self.itemViews.count < index || self.itemViews.count == 1) {
        return CGPointZero;
    } else {
        CGFloat totalOffset = self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame);
        return CGPointMake(index * totalOffset / (self.itemViews.count - 1), 0.);
    }
}

#pragma mark * Overwritten setters

- (void)setItemTitles:(NSArray *)itemTitles
{
    if (_itemTitles != itemTitles) {
        _itemTitles = itemTitles;
        NSMutableArray *mutableItemViews = [NSMutableArray arrayWithCapacity:itemTitles.count];
        for (NSUInteger i = 0; i < itemTitles.count; i++) {
            UIButton *itemView = [self addItemView];
            [itemView setTitle:itemTitles[i] forState:UIControlStateNormal];
            [mutableItemViews addObject:itemView];
        }
        
//        for(NSUInteger i = 0; i < itemTitles.count-1; i++){
//            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, CGRectGetHeight(self.frame))];
//            //按钮之间的竖线颜色
//            view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
//
//            view.center = ({
//                CGPoint centent = view.center;
//                centent.x = (CGRectGetWidth([[UIScreen mainScreen] bounds])/itemTitles.count)*(i+1);
//                centent;
//            });
//            [self.scrollView addSubview:view];
//        }
        self.itemViews = [NSArray arrayWithArray:mutableItemViews];
        [self layoutItemViews];
    }
}

- (void)setFont:(UIFont *)font
{
    if (![_font isEqual:font]) {
        _font = font;
        for (UIButton *itemView in self.itemViews) {
            [itemView.titleLabel setFont:font];
        }
    }
}
-(void)setColor:(UIColor *)color{
    _color = color;
    for (UIButton *itemView in self.itemViews) {
        [itemView setTitleColor:color forState:UIControlStateNormal];
    }

}
-(void)setSelectColor:(UIColor *)selectColor{
    _selectColor = selectColor;
}
#pragma mark - Private

- (UIButton *)addItemView
{
    CGRect frame = CGRectMake(0., 0., DAPagesContainerTopBarItemViewWidth, CGRectGetHeight(self.frame));
    UIButton *itemView = [[UIButton alloc] initWithFrame:frame];
    [itemView addTarget:self action:@selector(itemViewTapped:) forControlEvents:UIControlEventTouchUpInside];
    itemView.titleLabel.font = self.font;
    [itemView setTitleColor:self.color forState:UIControlStateNormal];
    [self.scrollView addSubview:itemView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-1, DAPagesContainerTopBarItemViewWidth, 1)];
    //修改按钮下横线颜色
    lineView.backgroundColor = [UIColor yellowColor];//[UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1.0f];
    lineView.tag = 10;
    [itemView addSubview:lineView];
    
    return itemView;
}

- (void)itemViewTapped:(UIButton *)sender
{
    
    [self.delegate itemAtIndex:[self.itemViews indexOfObject:sender] didSelectInPagesContainerTopBar:self];
    return;
    if (_currentButton == nil) {
        [self.delegate itemAtIndex:[self.itemViews indexOfObject:sender] didSelectInPagesContainerTopBar:self];
        _currentButton = sender;
        [self performSelector:@selector(setCurrentButtonNil) withObject:nil afterDelay:0.5f];
    }
}
-(void)setCurrentButtonNil{
    _currentButton = nil;
}
- (void)layoutItemViews
{
    CGFloat x = DAPagesContainerTopBarItemsOffset;
    for (NSUInteger i = 0; i < self.itemViews.count; i++) {
        UIView *itemView = self.itemViews[i];
        itemView.frame = CGRectMake(x, 0., [[UIScreen mainScreen]bounds].size.width/self.itemViews.count, CGRectGetHeight(self.frame));
        UIView *lineView = [itemView viewWithTag:10];
        lineView.frame = ({
            CGRect frame = lineView.frame;
            frame.size.width = CGRectGetWidth(itemView.frame);
            frame;
        });
        x += CGRectGetWidth(itemView.frame) + DAPagesContainerTopBarItemsOffset;
    }
    self.scrollView.contentSize = CGSizeMake(x, CGRectGetHeight(self.scrollView.frame));
    CGRect frame = self.scrollView.frame;
    if (CGRectGetWidth(self.frame) > x) {
        frame.origin.x = (CGRectGetWidth(self.frame) - x) / 2.;
        frame.size.width = x;
    } else {
        frame.origin.x = 0.;
        frame.size.width = CGRectGetWidth(self.frame);
    }
    self.scrollView.frame = frame;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutItemViews];
}

@end
