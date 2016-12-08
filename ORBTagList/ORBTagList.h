//
//  ORBTagList.h
//  ORBTagListDemo
//
//  Created by Vladislav Averin on 07/12/2016.
//  Copyright © 2016 Vlad Averin (hello@vladaverin.me). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORBTagListItem.h"

@class ORBTagList;

@protocol ORBTagListDataSource <NSObject>

@required
- (NSUInteger)numberOfItemsInTagList:(ORBTagList *)tagList;
- (ORBTagListItem *)tagList:(ORBTagList *)tagList tagItemAtIndex:(NSUInteger)tagItemIndex;

@optional
- (CGFloat)heightForAllItemsInTagList:(ORBTagList *)tagList;
- (CGFloat)horizontalSpaceBetweenItemsInTagList:(ORBTagList *)tagList;
- (CGFloat)verticalSpaceBetweenItemsInTagList:(ORBTagList *)tagList;

@end

@protocol ORBTagListDelegate <NSObject>

@optional
- (void)tagList:(ORBTagList *)tagList itemTappedAtIndex:(NSUInteger)tagItemIndex;
- (void)tagList:(ORBTagList *)tagList itemAccessoryButtonTappedAtIndex:(NSUInteger)tagItemIndex;
- (void)tagList:(ORBTagList *)tagList requestedTagListItemRemovalAtIndex:(NSUInteger)tagItemIndex;

@end

@interface ORBTagList : UIView

#pragma mark - Properties

@property (nonatomic, weak) id <ORBTagListDataSource> dataSource;
@property (nonatomic, weak) id <ORBTagListDelegate> delegate;

@property (nonatomic, strong) UIView *tagListHeaderView;
@property (nonatomic, strong) UIView *tagListFooterView;
@property (nonatomic, assign) CGFloat leftEdgeInset;
@property (nonatomic, assign) CGFloat rightEdgeInset;

#pragma mark - Methods

- (ORBTagListItem *)tagItemAtIndex:(NSUInteger)tagIndex;
- (void)reloadData;

@end
