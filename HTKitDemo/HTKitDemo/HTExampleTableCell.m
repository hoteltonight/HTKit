//
//  HTExampleTableCell.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import "HTExampleTableCell.h"
#import "HTCacheKeyCollector.h"

static UIEdgeInsets const kEdgeInsets = { 6, 6, 6, 6 };

@interface HTExampleTableCell () <HTStateAwareRasterImageViewDelegate>

@property (nonatomic, strong) HTStateAwareRasterImageView *stateAwareRasterImageView;
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
        _stateAwareRasterImageView = [[HTStateAwareRasterImageView alloc] init];
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

- (void)rasterImageViewWillRegenerateImage:(HTStateAwareRasterImageView *)rasterImageView
{
    [[HTCacheKeyCollector shared] cacheKeyAdded:[rasterImageView cacheKey]];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
    
    [self setNeedsLayout];
}

@end
