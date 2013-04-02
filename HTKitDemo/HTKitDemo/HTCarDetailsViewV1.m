//
//  HTCarDetailsViewV1.m
//  HTKitDemo
//
//  Created by Jacob Jennings on 3/23/13.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <CoreGraphics/CoreGraphics.h>
#import "HTCarDetailsViewV1.h"
#import "UIView+Position.h"
#import "HTGraphicsUtilities.h"
#import <QuartzCore/QuartzCore.h>

static UIEdgeInsets const kEdgeInsets = { .top = 6, .left = 6, .bottom = 6, .right = 6 };

@interface HTCarDetailsViewV1()

@property (nonatomic, strong) UILabel *makeLabel;
@property (nonatomic, strong) UILabel *modelLabel;
@property (nonatomic, strong) UILabel *colorNameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation HTCarDetailsViewV1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        self.layer.cornerRadius = 6;
        
        _makeLabel = [self createAndAddLabel];
        _makeLabel.textAlignment = NSTextAlignmentCenter;
        _makeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        _modelLabel = [self createAndAddLabel];
        _colorNameLabel = [self createAndAddLabel];
        _descriptionLabel = [self createAndAddLabel];
    }
    return self;
}

- (UILabel *)createAndAddLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
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
    [self.makeLabel centerHorizontallyInSuperview];
    self.modelLabel.frame = (CGRect) {
        .origin.x = kEdgeInsets.left,
        .origin.y = CGRectGetMaxY(self.makeLabel.frame),
        .size = [self.modelLabel sizeThatFits:insetSize]
    };
    [self.modelLabel centerHorizontallyInSuperview];
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

- (void)setMake:(NSString *)make
{
    if ([make isEqual:_make])
    {
        return;
    }
    [self willChangeValueForKey:@"make"];
    _make = [make copy];
    [self didChangeValueForKey:@"make"];
    self.makeLabel.text = _make;
    [self setNeedsLayout];
}

- (void)setModel:(NSString *)model
{
    if ([model isEqual:_model])
    {
        return;
    }
    [self willChangeValueForKey:@"model"];
    _model = [model copy];
    [self didChangeValueForKey:@"model"];
    self.modelLabel.text = _model;
    [self setNeedsLayout];
}

- (void)setColorName:(NSString *)colorName
{
    if ([colorName isEqual:colorName])
    {
        return;
    }
    [self willChangeValueForKey:@"colorName"];
    _colorName = [colorName copy];
    [self didChangeValueForKey:@"colorName"];
    self.colorNameLabel.text = _colorName;
    [self setNeedsLayout];
}

- (void)setCarDescription:(NSString *)carDescription
{
    if ([carDescription isEqual:_carDescription])
    {
        return;
    }
    [self willChangeValueForKey:@"carDescription"];
    _carDescription = [carDescription copy];
    [self didChangeValueForKey:@"carDescription"];
    self.descriptionLabel.text = _carDescription;
    [self setNeedsLayout];
}

@end
