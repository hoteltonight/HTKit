//
//  HTShapeDemoView.m
//  HTKitDemo
//
//  Created by Jacob Jennings on 4/2/13.
//  Copyright (c) 2013 HotelTonight. All rights reserved.
//

#import "HTShapeDemoView.h"
#import "HTHighlightedShapeView.h"
#import "HTGraphicsUtilities.h"
#import "UIView+Position.h"

@interface HTShapeDemoView() <HTHighlightedShapeViewDataSource>

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) HTHighlightedShapeView *fillCircleHighlightedShapeView;
@property (nonatomic, strong) HTHighlightedShapeView *shadowCircleHighlightedShapeView;

@end

@implementation HTShapeDemoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor blackColor];
    _fillCircleHighlightedShapeView = [[HTHighlightedShapeView alloc] initWithDataSource:self];
    _fillCircleHighlightedShapeView.highlightThickness = 3;
    _fillCircleHighlightedShapeView.highlightColor = [UIColor colorWithWhite:0.8 alpha:0.7];
    _fillCircleHighlightedShapeView.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_fillCircleHighlightedShapeView];

    _shadowCircleHighlightedShapeView = [[HTHighlightedShapeView alloc] initWithDataSource:self];
    _shadowCircleHighlightedShapeView.style = HTHighlightedShapeViewStyleInnerShadow;
    _shadowCircleHighlightedShapeView.highlightThickness = 3;
    _shadowCircleHighlightedShapeView.highlightSoftness = 1;
    _shadowCircleHighlightedShapeView.highlightColor = [UIColor colorWithWhite:0.8 alpha:0.7];
    _shadowCircleHighlightedShapeView.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_shadowCircleHighlightedShapeView];
    
    _topLabel = [[UILabel alloc] init];
    _topLabel.textColor = [UIColor whiteColor];
    _topLabel.backgroundColor = [UIColor clearColor];
    _topLabel.textAlignment = NSTextAlignmentCenter;
    _topLabel.text = @"HTHighlightedShapeViewStyleInnerShadow";
    _topLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self addSubview:_topLabel];
    
    _bottomLabel = [[UILabel alloc] init];
    _bottomLabel.textColor = [UIColor whiteColor];
    _bottomLabel.backgroundColor = [UIColor clearColor];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.text = @"HTHighlightedShapeViewStyleFill";
    _bottomLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self addSubview:_bottomLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.fillCircleHighlightedShapeView.frame = CGRectOffset(HTCenterSizeInRect(CGSizeMake(200, 200), self.bounds), 0, 130);
    self.shadowCircleHighlightedShapeView.frame = CGRectOffset(HTCenterSizeInRect(CGSizeMake(200, 200), self.bounds), 0, -130);
    
    self.topLabel.frame = (CGRect) {
        .origin.x = 0,
        .origin.y = self.shadowCircleHighlightedShapeView.frameY - 20,
        .size.width = self.bounds.size.width,
        .size.height = 20
    };
    
    self.bottomLabel.frame = (CGRect) {
        .origin.x = 0,
        .origin.y = self.fillCircleHighlightedShapeView.frameY - 20,
        .size.width = self.bounds.size.width,
        .size.height = 20
    };
}

#pragma mark - HTHighlightedShapeViewDataSource

- (UIBezierPath *)highlightedShapeView:(HTHighlightedShapeView *)shapeView pathForSize:(CGSize)size
{
    return [UIBezierPath bezierPathWithOvalInRect:(CGRect){ .origin = CGPointZero, .size = size }];
}

- (UIBezierPath *)highlightedShapeView:(HTHighlightedShapeView *)shapeView highlightPathForSize:(CGSize)size highlightThickness:(CGFloat)highlightThickness
{
    return [UIBezierPath bezierPathWithOvalInRect:(CGRect){ .origin = CGPointZero, .size = size }];
}


@end
