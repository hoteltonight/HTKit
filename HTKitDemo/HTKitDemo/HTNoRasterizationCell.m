//
//  HTNoRasterizationCell.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/6/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import "HTNoRasterizationCell.h"

static UIEdgeInsets const kEdgeInsets = { 6, 6, 6, 6 };

@interface HTNoRasterizationCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HTNoRasterizationCell

@synthesize rasterizableComponent = _rasterizableComponent;
@synthesize title = _title;

+ (NSString *)reuseIdentifier
{
    return HTNoRasterizationCellReuseIdentifier;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rasterizableComponent = [[HTExampleRasterizableComponent alloc] init];
        [self addSubview:_rasterizableComponent];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.rasterizableComponent.frame = UIEdgeInsetsInsetRect(self.bounds, kEdgeInsets);
    
    CGSize titleLabelSizeThatFits = [self.titleLabel sizeThatFits:self.bounds.size];
    self.titleLabel.frame = CGRectMake(round(CGRectGetMidX(self.bounds) - titleLabelSizeThatFits.width / 2),
                                       round(CGRectGetMidY(self.bounds) - titleLabelSizeThatFits.height / 2),
                                       titleLabelSizeThatFits.width,
                                       titleLabelSizeThatFits.height);
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
    
    [self setNeedsLayout];
}

@end
