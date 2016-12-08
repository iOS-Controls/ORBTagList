//
//  ORBTagList.m
//  ORBTagListDemo
//
//  Created by Vladislav Averin on 07/12/2016.
//  Copyright © 2016 Vlad Averin (hello@vladaverin.me). All rights reserved.
//

#import "ORBTagList.h"

#define kORBTagListDefaultItemHeight 30.0f
#define kORBTagListDefaultSpaceBetweenItems 10.0f

@interface ORBTagList () {
    
}

@property (nonatomic, strong) NSMutableArray *tagItems;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *dataContainer;

@end

@implementation ORBTagList

#pragma mark - View life cycle

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self reloadData];
}

#pragma mark - Data Control

- (void)reloadData {
    NSAssert(self.dataSource, @"Warning: DataSource protocol must be implemented for %@ object", NSStringFromClass([self class]));
    
    /* Clean up previous views*/
    [self.scrollView removeFromSuperview];
    
    /* Pull data from DataSource */
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInTagList)]) {
        self.tagItems = [[NSMutableArray alloc] initWithCapacity:
                         [self.dataSource numberOfItemsInTagList]];
    } else {
        self.tagItems = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    if ([self.dataSource respondsToSelector:@selector(tagItemAtIndex:)]) {
        for (NSUInteger index = 0; index < [self.dataSource numberOfItemsInTagList]; index++) {
            [self.tagItems insertObject:[self.dataSource tagItemAtIndex:index] atIndex:index];
        }
    }
    
    CGFloat tagHeight;
    if ([self.dataSource respondsToSelector:@selector(heightForAllItemsInTagList)]) {
        tagHeight = [self.dataSource heightForAllItemsInTagList];
    } else {
        tagHeight = kORBTagListDefaultItemHeight;
    }
    
    CGFloat horizontalMargin;
    if ([self.dataSource respondsToSelector:@selector(horizontalSpaceBetweenItemsInTagList)]) {
        horizontalMargin = [self.dataSource horizontalSpaceBetweenItemsInTagList];
    } else {
        horizontalMargin = kORBTagListDefaultSpaceBetweenItems;
    }
    
    CGFloat verticalMargin;
    if ([self.dataSource respondsToSelector:@selector(verticalSpaceBetweenItemsInTagList)]) {
        verticalMargin = [self.dataSource verticalSpaceBetweenItemsInTagList];
    } else {
        verticalMargin = kORBTagListDefaultSpaceBetweenItems;
    }
    
    /* Build view structure */
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.dataContainer = [[UIView alloc] initWithFrame:self.scrollView.bounds];
    
    int numOfFilledTagLines = 0;
    CGFloat curX = self.dataContainer.bounds.origin.x;
    
    for (ORBTagListItem *item in self.tagItems) {
        item.frame = CGRectMake(0, 0,
                                1, tagHeight);
        [item performSelector:@selector(constructView)];
        
        CGFloat spaceToTrailingMargin = self.dataContainer.bounds.size.width - curX;
        
        if (spaceToTrailingMargin - item.bounds.size.width < 0) {
            numOfFilledTagLines++;
            curX = self.dataContainer.frame.origin.x;
        }
        
        [item setFrame:CGRectMake(curX,
                                   self.dataContainer.bounds.origin.y + verticalMargin +
                                   (numOfFilledTagLines * (verticalMargin + tagHeight))
                                   + verticalMargin,
                                   item.bounds.size.width,
                                   tagHeight)];
        
        [self.dataContainer addSubview:item];
        
        curX += item.bounds.size.width + horizontalMargin;
    }
    
    numOfFilledTagLines++;
    
    self.dataContainer.frame = CGRectMake(0, 0,
                                          self.dataContainer.bounds.size.width,
                                          (numOfFilledTagLines * (verticalMargin + tagHeight) + verticalMargin));
    
    /* Layout Scroll View */
    [self layoutScrollView];
    [self addSubview:self.scrollView];
}

#pragma mark - UI Layout

- (void)layoutScrollView {
    CGSize newSize = CGSizeMake(self.dataContainer.bounds.size.width,
                                self.dataContainer.bounds.size.height);
    
    if (_tagListHeaderView) {
        newSize.height += _tagListHeaderView.bounds.size.height;
        [self.scrollView addSubview:_tagListHeaderView];
        
        self.dataContainer.frame = CGRectMake(0, _tagListHeaderView.bounds.size.height,
                                              self.dataContainer.bounds.size.width,
                                              self.dataContainer.bounds.size.height);
    } else {
        self.dataContainer.frame = CGRectMake(0, 0,
                                              self.dataContainer.bounds.size.width,
                                              self.dataContainer.bounds.size.height);
    }
    
    if (_tagListFooterView) {
        newSize.height += _tagListFooterView.bounds.size.height;
        
        _tagListFooterView.frame = CGRectMake(0, newSize.height - _tagListFooterView.bounds.size.height,
                                              _tagListFooterView.bounds.size.width,
                                              _tagListFooterView.bounds.size.height);
        [self.scrollView addSubview:_tagListFooterView];
    }
    
    [self.scrollView addSubview:self.dataContainer];
    [self.scrollView setContentSize:newSize];
}

#pragma mark - Custom Assessors

- (void)setTagListHeaderView:(UIView *)tagListHeaderView {
    if (tagListHeaderView && self.scrollView) {
        tagListHeaderView.frame = CGRectMake(0, 0,
                                              tagListHeaderView.bounds.size.width,
                                              tagListHeaderView.bounds.size.height);
    } else {
        [tagListHeaderView removeFromSuperview];
    }
    
    _tagListHeaderView = tagListHeaderView;
    
    [self layoutScrollView];
}

- (void)setTagListFooterView:(UIView *)tagListFooterView {
    if (tagListFooterView && self.scrollView) {
        tagListFooterView.frame = CGRectMake(0, 0,
                                              tagListFooterView.bounds.size.width,
                                              tagListFooterView.bounds.size.height);
    } else {
        [tagListFooterView removeFromSuperview];
    }
    
    _tagListFooterView = tagListFooterView;
    
    [self layoutScrollView];
}

@end
