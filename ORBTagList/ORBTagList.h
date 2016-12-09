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

/**
 \protocol ORBTagListDataSource
 \brief Protocol to provide data source for Tag List.
 \discussion It should be implemented by data provider object (usually containing view) in order for Tag List to display anything.
 */
@protocol ORBTagListDataSource <NSObject>

@required
- (NSUInteger)numberOfItemsInTagList:(ORBTagList *)tagList;
- (ORBTagListItem *)tagList:(ORBTagList *)tagList tagItemAtIndex:(NSUInteger)tagItemIndex;

@optional
- (CGFloat)heightForAllItemsInTagList:(ORBTagList *)tagList;
- (CGFloat)horizontalSpaceBetweenItemsInTagList:(ORBTagList *)tagList;
- (CGFloat)verticalSpaceBetweenItemsInTagList:(ORBTagList *)tagList;

@end

/**
 \protocol ORBTagListDelegate
 \brief Protocol to receive events from Tag List.
 \discussion It should be implemented by any object in order to handle UI events.
 */
@protocol ORBTagListDelegate <NSObject>

@optional
- (void)tagList:(ORBTagList *)tagList itemTappedAtIndex:(NSUInteger)tagItemIndex;
- (void)tagList:(ORBTagList *)tagList itemAccessoryButtonTappedAtIndex:(NSUInteger)tagItemIndex;
- (void)tagList:(ORBTagList *)tagList requestedTagListItemRemovalAtIndex:(NSUInteger)tagItemIndex;

@end

/**
 \class ORBTagList
 \brief Main object representing Tag List itself.
 \discussion It adopts convenient iOS-friendly paradigm utilizing 'dataSource' and 'delegate' to control appearance and handle user feedback, as well as some customization properties, available to change on the fly.
 */
@interface ORBTagList : UIView

#pragma mark - Properties

/* DATA CONTROL */

/**
 Reference to object implementing ORBTagListDataSource protocol.
 */
@property (nonatomic, weak) id <ORBTagListDataSource> dataSource;

/**
 Reference to object implementing ORBTagListDelegate protocol.
 */
@property (nonatomic, weak) id <ORBTagListDelegate> delegate;

/* CUSTOMIZATION */

/**
 Custom header view on top of the Tag List.
 */
@property (nonatomic, strong) UIView *tagListHeaderView;

/**
 Custom footer view in the bottom of the Tag List.
 */
@property (nonatomic, strong) UIView *tagListFooterView;

/**
 Left inset of Tag List view.
 */
@property (nonatomic, assign) CGFloat leftEdgeInset;

/**
 Right inset of Tag List view.
 */
@property (nonatomic, assign) CGFloat rightEdgeInset;

#pragma mark - Methods

/**
 \brief Returns necessary Tag Item in List if any.
 \param tagIndex Index of List Item to get.
 \returns ORBTagListItem object at given index.
 */
- (ORBTagListItem *)tagItemAtIndex:(NSUInteger)tagIndex;

/**
 \brief Forces Tag List ro reload its data and layout using DataSource and Delegate protocols.
 */
- (void)reloadData;

@end
