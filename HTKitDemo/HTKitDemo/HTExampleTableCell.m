//
//  HTExampleTableCell.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2013 HotelTonight
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "HTExampleTableCell.h"
#import "HTCacheKeyCollector.h"

static UIEdgeInsets const kEdgeInsets = { 6, 6, 6, 6 };

@interface HTExampleTableCell () <HTRasterViewDelegate>

@property (nonatomic, strong) HTRasterView *stateAwareRasterImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HTExampleTableCell

@synthesize rasterizableComponent = _rasterizableComponent;
@synthesize title = _title;

+ (NSString *)reuseIdentifier
{
    return HTExampleTableCellReuseIdentifier;
}

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HTExampleTableCellReuseIdentifier];
    if (self) {
        _rasterizableComponent = [[HTExampleRasterizableComponent alloc] init];
        _stateAwareRasterImageView = [[HTRasterView alloc] init];
        _stateAwareRasterImageView.rasterizableView = _rasterizableComponent;
        _stateAwareRasterImageView.delegate = self;
        [self addSubview:_stateAwareRasterImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.stateAwareRasterImageView.frame = UIEdgeInsetsInsetRect(self.bounds, kEdgeInsets);
    
    CGSize titleLabelSizeThatFits = [self.titleLabel sizeThatFits:self.bounds.size];
    self.titleLabel.frame = CGRectMake(round(CGRectGetMidX(self.bounds) - titleLabelSizeThatFits.width / 2),
                                       round(CGRectGetMidY(self.bounds) - titleLabelSizeThatFits.height / 2),
                                       titleLabelSizeThatFits.width,
                                       titleLabelSizeThatFits.height);
}

- (void)rasterViewWillRegenerateImage:(HTRasterView *)rasterView
{
    [[HTCacheKeyCollector shared] cacheKeyAdded:[rasterView cacheKey]];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
    
    [self setNeedsLayout];
}

@end
