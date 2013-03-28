//
// Created by Jacob Jennings on 3/24/13.
// Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#import "HTCarDetailsViewV2.h"
#import "HTGraphicsUtilities.h"
#import "UIView+Position.h"
#import "NSObject+HTUpdateAggregator.h"

static UIEdgeInsets const kEdgeInsets = { .top = 6, .left = 6, .bottom = 6, .right = 6 };

@interface HTCarDetailsViewV2()<HTUpdatable>

@property (nonatomic, strong) UILabel *makeLabel;
@property (nonatomic, strong) UILabel *modelLabel;
@property (nonatomic, strong) UILabel *colorNameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation HTCarDetailsViewV2

+ (NSArray *)keyPathsToTriggerUpdate
{
#warning TODO associated object for less boilerplate!
    static NSArray *keyPathsToTriggerUpdate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyPathsToTriggerUpdate = @[@"make", @"model", @"colorName", @"carDescription"];
    });
    return keyPathsToTriggerUpdate;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    [self addSubview:label];
    return label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize insetSize = HTSizeEdgeInset(self.frameSize, kEdgeInsets);
    self.makeLabel.frame = (CGRect) {
            .origin.x = kEdgeInsets.left,
            .origin.y = kEdgeInsets.top,
            .size = [self.makeLabel sizeThatFits:insetSize]
    };
    self.modelLabel.frame = (CGRect) {
            .origin.x = kEdgeInsets.left,
            .origin.y = CGRectGetMaxY(self.makeLabel.frame),
            .size = [self.modelLabel sizeThatFits:insetSize]
    };
    self.colorNameLabel.frame = (CGRect) {
            .origin.x = kEdgeInsets.left,
            .origin.y = CGRectGetMaxY(self.modelLabel.frame),
            .size = [self.colorNameLabel sizeThatFits:insetSize]
    };
    self.descriptionLabel.frame = (CGRect) {
            .origin.x = kEdgeInsets.left,
            .origin.y = CGRectGetMaxY(self.colorNameLabel.frame),
            .size = [self.descriptionLabel sizeThatFits:insetSize]
    };
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize insetSize = HTSizeEdgeInset(size, kEdgeInsets);
    CGSize makeLabelSize = [self.makeLabel sizeThatFits:insetSize];
    CGSize modelLabelSize = [self.modelLabel sizeThatFits:insetSize];
    CGSize colorNameLabelSize = [self.colorNameLabel sizeThatFits:insetSize];
    CGSize descriptionLabelSize = [self.descriptionLabel sizeThatFits:insetSize];

    return CGSizeMake(size.width,
            makeLabelSize.height
                    + modelLabelSize.height
                    + colorNameLabelSize.height
                    + descriptionLabelSize.height
                    + kEdgeInsets.top
                    + kEdgeInsets.bottom);
}

- (void)updateContent
{
    NSLog(@"updateContent");
    self.makeLabel.text = self.make;
    self.modelLabel.text = self.model;
    self.colorNameLabel.text = self.colorName;
    self.descriptionLabel.text = self.carDescription;
    [self setNeedsLayout];
}

@end