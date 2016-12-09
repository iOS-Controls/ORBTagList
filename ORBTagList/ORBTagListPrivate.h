//
//  ORBTagListPrivate.h
//  ORBTagListDemo
//
//  Created by Vladislav Averin on 08/12/2016.
//  Copyright © 2016 Vlad Averin (hello@vladaverin.me). All rights reserved.
//

#ifndef ORBTagListPrivate_h
#define ORBTagListPrivate_h

@class ORBTagListItem;

/**
 \protocol ORBTagListItemDelegate
 \brief Private protocol for ORBTagList and ORBTagListItem communication.
 \discussion You can extend it for your needs but it's not supposed to be implemented elsewhere but in ORBTagList to get updates from ORBTagListItem.
 */
@protocol ORBTagListItemDelegate <NSObject>

@required
- (void)tagListItemTapped:(ORBTagListItem *)item;
- (void)tagListAccessoryButtonTapped:(ORBTagListItem *)item;

@end


/**
 \brief Private ORBTagListItem extension available only to ORBTagList related classes for intercommunication.
 */
@interface ORBTagListItem ()

@property (nonatomic, weak) id <ORBTagListItemDelegate> privateDelegate;

@end

#endif /* ORBTagListPrivate_h */
