//
// Created by Jacob Jennings on 3/24/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "HTCarDetailsViewV2.h"
#import "HTGraphicsUtilities.h"
#import "UIView+Position.h"
#import "NSObject+HTUpdateAggregator.h"
#import <QuartzCore/QuartzCore.h>


// See V1, V2 and V3 for incremental improvements!


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
    [self updateContentIfNeeded];
    
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
    [self updateContentIfNeeded];
    
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
    self.makeLabel.text = self.make;
    self.modelLabel.text = self.model;
    self.colorNameLabel.text = self.colorName;
    self.descriptionLabel.text = self.carDescription;
    [self setNeedsLayout];
}

@end
