//
// Created by Jacob Jennings on 4/1/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//


#import "HTCarDetailsViewV3.h"
#import "HTGraphicsUtilities.h"
#import "UIView+Position.h"
#import "NSObject+HTUpdateAggregator.h"
#import <QuartzCore/QuartzCore.h>


// See V1, V2 and V3 for incremental improvements!


static UIEdgeInsets const kEdgeInsets = { .top = 6, .left = 6, .bottom = 6, .right = 6 };

@interface HTCarDetailsViewV3()<HTUpdatable>

@property (nonatomic, strong) UILabel *makeLabel;
@property (nonatomic, strong) UILabel *modelLabel;
@property (nonatomic, strong) UILabel *colorNameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation HTCarDetailsViewV3

+ (NSArray *)keyPathsToTriggerUpdate
{
    return @[@"make", @"model", @"colorName", @"carDescription"];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        self.layer.cornerRadius = 6;
        
        _makeLabel = [self createAndAddLabel];
        _modelLabel = [self createAndAddLabel];
        _colorNameLabel = [self createAndAddLabel];
        _descriptionLabel = [self createAndAddLabel];
    }
    return self;
}

- (UILabel *)createAndAddLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    [self addSubview:label];
    return label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self sizeThatFits:self.bounds.size setFrames:YES];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [self sizeThatFits:size setFrames:NO];
}

- (CGSize)sizeThatFits:(CGSize)size setFrames:(BOOL)setFrames
{
    [self updateContentIfNeeded];

    CGSize insetSize = HTSizeEdgeInset(size, kEdgeInsets);
    CGRect makeLabelFrame = (CGRect) {
        .origin.x = kEdgeInsets.left,
        .origin.y = kEdgeInsets.top,
        .size = [self.makeLabel sizeThatFits:insetSize]
    };
    CGRect modelLabelFrame = (CGRect) {
        .origin.x = kEdgeInsets.left,
        .origin.y = CGRectGetMaxY(makeLabelFrame),
        .size = [self.modelLabel sizeThatFits:insetSize]
    };
    CGRect colorNameLabelFrame = (CGRect) {
        .origin.x = kEdgeInsets.left,
        .origin.y = CGRectGetMaxY(modelLabelFrame),
        .size = [self.colorNameLabel sizeThatFits:insetSize]
    };
    CGRect descriptionLabelFrame = (CGRect) {
        .origin.x = kEdgeInsets.left,
        .origin.y = CGRectGetMaxY(colorNameLabelFrame),
        .size = [self.descriptionLabel sizeThatFits:insetSize]
    };

    if (setFrames)
    {
        self.makeLabel.frame = makeLabelFrame;
        self.modelLabel.frame = modelLabelFrame;
        self.colorNameLabel.frame = colorNameLabelFrame;
        self.descriptionLabel.frame = descriptionLabelFrame;
    }

    return CGSizeMake(size.width, CGRectGetMaxY(descriptionLabelFrame) + kEdgeInsets.bottom);
}

- (void)updateContent
{
    self.makeLabel.text = self.make;
    self.modelLabel.text = self.model;
    self.colorNameLabel.text = self.colorName;
    self.descriptionLabel.text = self.carDescription;
    [self setNeedsLayout];
}

@end
