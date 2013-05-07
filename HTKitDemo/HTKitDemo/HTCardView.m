//
//  HTCardView.m
//  HTKitDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "HTCardView.h"
#import "HTGraphicsUtilities.h"

static CGSize const kCardSize = (CGSize){ .width = 260, .height = 356 };
static CGFloat const kDistanceAbovePocketToPullCard = 12;
static CGFloat const kCardTuckedYOffset = 50;

@interface HTCardView()

@property (nonatomic, strong) UIView *pocketView;
@property (nonatomic, strong) UIView *cardView;

@end

@implementation HTCardView

- (instancetype)initWithDelegate:(id<HTCardViewDelegate>)delegate
{
    self = [self init];
    if (self)
    {
        _delegate = delegate;
        [self.cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:delegate action:@selector(cardTapped)]];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        _cardView = [[UIView alloc] init];
        _cardView.backgroundColor = [UIColor greenColor];
        _cardView.layer.cornerRadius = 10;
        [self addSubview:_cardView];

        _pocketView = [[UIView alloc] init];
        _pocketView.backgroundColor = [UIColor blueColor];
        _pocketView.layer.shadowRadius = 3;
        _pocketView.layer.shadowOpacity = 0.6;
        [self addSubview:_pocketView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutForCurrentState];
}

- (void)layoutForCurrentState
{
    self.pocketView.transform = CGAffineTransformIdentity;
    self.pocketView.frame = (CGRect) {
            .origin.x = -60,
            .origin.y = 200,
            .size.width = self.bounds.size.width + 120,
            .size.height = self.bounds.size.height
    };
    self.pocketView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.pocketView.bounds].CGPath;
    self.pocketView.transform = CGAffineTransformMakeRotation(M_PI / 32);

    switch (self.state)
    {
        case HTCardViewStateTuckedIn:
        {
            self.cardView.transform = CGAffineTransformIdentity;
            self.cardView.frame = CGRectOffset(HTCenterSizeInRect(kCardSize, self.bounds), 0, kCardTuckedYOffset);
            break;
        }
        case HTCardViewStateCardUp:
        {
            self.cardView.transform = CGAffineTransformIdentity;
            self.cardView.frame = (CGRect) {
                    .origin.x = round((self.bounds.size.width - kCardSize.width) / 2),
                    .origin.y = self.pocketView.frame.origin.y - kCardSize.height - kDistanceAbovePocketToPullCard,
                    .size = kCardSize
            };
            self.cardView.transform = CGAffineTransformMakeRotation(M_PI / 16);
            break;
        }
        case HTCardViewStateCardPresented:
        {
            self.cardView.transform = CGAffineTransformIdentity;
            self.cardView.frame = HTCenterSizeInRect(kCardSize, self.bounds);
            break;
        }
    }
}

- (void)setState:(HTCardViewState)state
{
    [self setState:state animated:NO];
}

- (void)setState:(HTCardViewState)state animated:(BOOL)animated
{
    if (!animated)
    {
        _state = state;
        [self setNeedsLayout];
        return;
    }

    [self transitionToState:state];
}

- (void)transitionToState:(HTCardViewState)toState
{
    NSLog(@"transitionToState: %d", self.state);
    if (self.state == toState)
    {
        return;
    }
    _state = [self nextStateForTransitionToState:toState];
    switch (self.state)
    {
        case HTCardViewStateTuckedIn:
        {
            [self sendSubviewToBack:self.cardView];
            break;
        }
        case HTCardViewStateCardPresented:
        {
            [self bringSubviewToFront:self.cardView];
            break;
        }
        default:break;
    }

    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionBeginFromCurrentState
                     animations:^
                     {
                         [self layoutForCurrentState];
                     }
                     completion:^(BOOL finished)
                     {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [self transitionToState:toState];
                         });
                     }];
}

- (HTCardViewState)nextStateForTransitionToState:(HTCardViewState)toState
{
    switch (self.state)
    {
        case HTCardViewStateTuckedIn:
            return HTCardViewStateCardUp;

        case HTCardViewStateCardUp:
            return toState;

        case HTCardViewStateCardPresented:
            return HTCardViewStateCardUp;

        default:
            return HTCardViewStateTuckedIn;
    }
}

@end
