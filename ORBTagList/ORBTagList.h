//
//  ORBTagList.h
//  ORBTagListDemo
//
//  Created by Vladislav Averin on 07/12/2016.
//  Copyright © 2016 Vlad Averin (hello@vladaverin.me). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORBTagListItem.h"

@protocol ORBTagListDataSource <NSObject>

@required
- (NSUInteger)numberOfItemsInTagList;
- (ORBTagListItem *)tagItemAtIndex:(NSUInteger)tagItemIndex;

@optional
- (CGFloat)heightForAllItemsInTagList;
- (CGFloat)horizontalSpaceBetweenItemsInTagList;
- (CGFloat)verticalSpaceBetweenItemsInTagList;

@end

@protocol ORBTagListDelegate <NSObject>

@optional
- (void)tagListItemTappedAtIndex:(NSUInteger)tagItemIndex;
- (void)tagListItemAccessoryButtonTappedAtIndex:(NSUInteger)tagItemIndex;
- (BOOL)shouldRemoveTagListItemAtIndex:(NSUInteger)tagItemIndex;

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

- (void)reloadData;

@end
