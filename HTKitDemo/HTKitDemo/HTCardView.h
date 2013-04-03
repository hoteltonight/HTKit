//
//  HTCardView.h
//  HTKitDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTCardViewState)
{
    HTCardViewStateTuckedIn,
    HTCardViewStateCardUp,
    HTCardViewStateCardPresented
};

@protocol HTCardViewDelegate

- (void)cardTapped;

@end

@interface HTCardView : UIView

@property (nonatomic, assign) HTCardViewState state;
- (void)setState:(HTCardViewState)state animated:(BOOL)animated;

@property (nonatomic, weak) IBOutlet id<HTCardViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<HTCardViewDelegate>)delegate;

@end
