//
//  ORBTagListItem.m
//  ORBTagListDemo
//
//  Created by Vladislav Averin on 07/12/2016.
//  Copyright © 2016 Vlad Averin (hello@vladaverin.me). All rights reserved.
//

#import "ORBTagListItem.h"

#define kORBTagListItemDefaultHeight 30.0f
#define kORBTagListItemDefaultHorizontalPadding 5.0f

#define kORBTagListItemDefaultAccessoryViewPadding 10.0f

#define kORBTagListItemDefaultText @""

@interface ORBTagListItem ()

@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation ORBTagListItem

#pragma mark - Initialization

- (instancetype)init {
    return [self initWithText:kORBTagListItemDefaultText];
};

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithText:kORBTagListItemDefaultText];
};

- (instancetype)initWithText:(NSString *)text {
    if ([super initWithFrame:CGRectZero]) {
        self.tagName = text;
        self.tagFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        self.tagNameColor = [UIColor whiteColor];
        self.tagBackgroundColor = [UIColor darkGrayColor];
        self.tagCornerRadius = 10.0f;
        
        self.horizontalPadding = kORBTagListItemDefaultHorizontalPadding;
        self.accessoryView = ORBTagListItemAccessoryViewNone;
        self.customAccessoryView = nil;
        self.customAccessoryViewPadding = kORBTagListItemDefaultAccessoryViewPadding;
    }
    
    return self;
}

#pragma mark - View Life Cycle

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - View setup

- (void)constructView {
    self.tagLabel = [[UILabel alloc] init];
    self.tagLabel.font = self.tagFont;
    self.tagLabel.text = self.tagName;
    self.tagLabel.textColor = self.tagNameColor;
    
    CGFloat trueLabelWidth = [self.tagLabel.text
                            boundingRectWithSize:self.tagLabel.frame.size
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{ NSFontAttributeName:self.tagLabel.font }
                            context:nil].size.width;
    
    CGFloat estimatedTagViewWidth = (self.horizontalPadding * 2) + trueLabelWidth;
    
    switch (self.accessoryView) {
        case ORBTagListItemAccessoryViewRemoveItem:
            estimatedTagViewWidth += (self.bounds.size.height - kORBTagListItemDefaultAccessoryViewPadding * 2) + (kORBTagListItemDefaultAccessoryViewPadding * 2);
            break;
            
        case ORBTagListItemAccessoryViewCustom: {
            NSAssert(self.customAccessoryView, @"Warning: %@ needs customAccessoryView to be set when in ORBTagListItemAccessoryViewCustom mode", NSStringFromClass([self class]));
            
            estimatedTagViewWidth += self.customAccessoryView.bounds.size.width + (self.customAccessoryViewPadding * 2);
            break;
        }
            
        default:
            break;
    }
    
    self.frame = CGRectMake(0, 0,
                            estimatedTagViewWidth, self.bounds.size.height);
    
    self.tagLabel.frame = CGRectMake(self.horizontalPadding, 0,
                                     trueLabelWidth, self.bounds.size.height);
    [self addSubview:self.tagLabel];
    
    self.backgroundColor = self.tagBackgroundColor;
    self.layer.cornerRadius = self.tagCornerRadius;
    
    UIButton* tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tagButton.backgroundColor = [UIColor clearColor];
    tagButton.frame = self.bounds;
    [tagButton addTarget:self action:@selector(tagButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tagButton];
    
    if (self.accessoryView > ORBTagListItemAccessoryViewNone) {
        CGFloat accessoryX, accessoryY, w, h;
        
        accessoryX = self.bounds.size.width - ((self.accessoryView == ORBTagListItemAccessoryViewRemoveItem) ? self.horizontalPadding : self.customAccessoryViewPadding) - ((self.accessoryView == ORBTagListItemAccessoryViewRemoveItem) ? (self.bounds.size.height - kORBTagListItemDefaultAccessoryViewPadding * 2) : self.customAccessoryView.bounds.size.width);
        
        accessoryY = self.bounds.size.height/2 - ((self.accessoryView == ORBTagListItemAccessoryViewRemoveItem) ? kORBTagListItemDefaultAccessoryViewPadding : self.customAccessoryView.bounds.size.height/2);
        
        w = (self.accessoryView == ORBTagListItemAccessoryViewRemoveItem) ? (self.bounds.size.height - kORBTagListItemDefaultAccessoryViewPadding * 2) : self.customAccessoryView.bounds.size.width;
        
        h = (self.accessoryView == ORBTagListItemAccessoryViewRemoveItem) ? w : self.customAccessoryView.bounds.size.height;
        
        UIView *accessoryView = [[UIView alloc]
                                 initWithFrame:CGRectMake(accessoryX, accessoryY, w, h)];
        accessoryView.contentMode = UIViewContentModeScaleAspectFit;
        
        UIView *customSubview;
        if (self.accessoryView == ORBTagListItemAccessoryViewCustom) {
            customSubview = self.customAccessoryView;
        } else {
            UIImageView *accessoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross"]];
            customSubview.contentMode = accessoryView.contentMode;
            customSubview = accessoryImage;
        }
        
        customSubview.frame = accessoryView.bounds;
        [accessoryView addSubview:customSubview];
        
        [self addSubview:accessoryView];
        
        UIButton* accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        accessoryButton.backgroundColor = [UIColor clearColor];
        accessoryButton.frame = accessoryView.bounds;
        [accessoryButton addTarget:self action:@selector(accessoryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [accessoryView addSubview:accessoryButton];
    }
}

#pragma mark - Button events

- (void)tagButtonTapped:(UIButton *)button {
    
}

- (void)accessoryButtonTapped:(UIButton *)button {
    
}

#pragma mark - Custom Accessors

- (void)setCustomAccessoryView:(UIView *)customAccessoryView {
    _customAccessoryView = customAccessoryView;
    
    if (_customAccessoryView) {
        self.accessoryView = ORBTagListItemAccessoryViewCustom;
    }
}

@end
