//
//  HTGeneratedImageTableCell.m
//  HTStateAwareRasterDemo
//
//  Created by Jacob Jennings on 12/7/12.
//  Copyright (c) 2012 HotelTonight. All rights reserved.
//

#import "HTGeneratedImageTableCell.h"

static CGFloat const horizontalMargin = 6;

@interface HTGeneratedImageTableCell ()

@property (nonatomic, strong) UITextView *cacheKeyTextView;
@property (nonatomic, strong) UIImageView *actualSizeImageView;
@property (nonatomic, strong) UIImageView *standardSizeImageView;

@end

@implementation HTGeneratedImageTableCell

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HTGeneratedImageTableCellReuseIdentifier];
    if (self)
    {
        _cacheKeyTextView = [[UITextView alloc] init];
        _cacheKeyTextView.editable = NO;
        _cacheKeyTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
        [self.contentView addSubview:_cacheKeyTextView];
        
        _actualSizeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_actualSizeImageView];
        
        _standardSizeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_standardSizeImageView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageViewSizeThatFits = [self.actualSizeImageView sizeThatFits:self.bounds.size];
    CGFloat imageWidthForCellHeight = imageViewSizeThatFits.height ? (imageViewSizeThatFits.width / imageViewSizeThatFits.height) * self.bounds.size.height : 0;
    
    self.standardSizeImageView.frame = CGRectMake(self.bounds.size.width - imageWidthForCellHeight,
                                                  0,
                                                  imageWidthForCellHeight,
                                                  self.bounds.size.height);
    
    self.actualSizeImageView.frame = CGRectMake(CGRectGetMinX(self.standardSizeImageView.frame) - imageViewSizeThatFits.width - horizontalMargin,
                                                0,
                                                imageViewSizeThatFits.width,
                                                imageViewSizeThatFits.height);
    
    self.cacheKeyTextView.frame = CGRectMake(0,
                                             0,
                                             CGRectGetMinX(self.actualSizeImageView.frame) - horizontalMargin,
                                             self.bounds.size.height);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.actualSizeImageView.image = image;
    self.standardSizeImageView.image = [UIImage imageWithCGImage:image.CGImage];
    
    [self setNeedsLayout];
}

- (void)setCacheKey:(NSString *)cacheKey
{
    _cacheKey = cacheKey;
    
    self.cacheKeyTextView.text = cacheKey;
    
    [self setNeedsLayout];
}

@end
