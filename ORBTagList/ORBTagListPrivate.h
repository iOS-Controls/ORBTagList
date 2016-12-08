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

@protocol ORBTagListItemProtocol <NSObject>

@required
- (void)tagListItemTapped:(ORBTagListItem *)item;
- (void)tagListAccessoryButtonTapped:(ORBTagListItem *)item;

@end

@interface ORBTagListItem ()

@property (nonatomic, weak) id <ORBTagListItemProtocol> privateDelegate;

@end

#endif /* ORBTagListPrivate_h */
