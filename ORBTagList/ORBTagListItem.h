//
//  ORBTagListItem.h
//  ORBTagListDemo
//
//  Created by Vladislav Averin on 07/12/2016.
//  Copyright © 2016 Vlad Averin (hello@vladaverin.me). All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger) {
    ORBTagListItemAccessoryViewNone = 0,
    ORBTagListItemAccessoryViewRemoveItem,
    ORBTagListItemAccessoryViewCustom
} ORBTagListItemAccessoryView;

@interface ORBTagListItem : UIView

#pragma mark - Properties

@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) UIFont *tagFont;
@property (nonatomic, strong) UIColor *tagNameColor;
@property (nonatomic, strong) UIColor *tagBackgroundColor;
@property (nonatomic, assign) CGFloat tagCornerRadius;
@property (nonatomic, assign) CGFloat horizontalPadding;

@property (nonatomic, assign) ORBTagListItemAccessoryView accessoryView;
@property (nonatomic, strong) UIView *customAccessoryView;
@property (nonatomic, assign) CGFloat customAccessoryViewPadding;

//@property (nonatomic, assign) BOOL autoresizeText; /* TBD */

#pragma mark - Methods

- (instancetype)initWithText:(NSString *)text;

@end
